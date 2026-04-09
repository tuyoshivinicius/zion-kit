#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Orquestrador de planos de implementação para Claude Code CLI.

.DESCRIPTION
    Lê um plano de implementação em Markdown, extrai tarefas estruturadas,
    e executa cada uma via Claude Code CLI em modo headless (--print).
    Suporta: retry em falha, checkpoints, logging, retomada parcial.

.PARAMETER PlanFile
    Caminho para o arquivo Markdown do plano de implementação.

.PARAMETER StartFrom
    ID da tarefa a partir da qual retomar execução (ex: "E2.T1").
    Tarefas anteriores são marcadas como "skipped".

.PARAMETER DryRun
    Exibe as tarefas que seriam executadas sem executá-las.

.PARAMETER MaxRetries
    Número máximo de tentativas por tarefa em caso de falha (default: 2).

.PARAMETER LogDir
    Diretório para logs de execução (default: ./logs).

.EXAMPLE
    ./run-plan.ps1 -PlanFile ./docs/plan-feature-x.md
    ./run-plan.ps1 -PlanFile ./docs/plan-feature-x.md -StartFrom "E2.T1"
    ./run-plan.ps1 -PlanFile ./docs/plan-feature-x.md -DryRun

.NOTES
    Requer: PowerShell 7+, Claude Code CLI instalado e autenticado.
#>

#Requires -Version 7.0

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript({ Test-Path $_ -PathType Leaf })]
    [string]$PlanFile,

    [Parameter()]
    [string]$StartFrom = "",

    [Parameter()]
    [switch]$DryRun,

    [Parameter()]
    [ValidateRange(0, 5)]
    [int]$MaxRetries = 2,

    [Parameter()]
    [string]$LogDir = "./logs"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ============================================================
# CONFIGURAÇÃO
# ============================================================

$Script:CheckpointFile = Join-Path $LogDir "checkpoint.json"
$Script:ReportFile = Join-Path $LogDir "execution-report.json"
$Script:StartTime = Get-Date

# ============================================================
# FUNÇÕES AUXILIARES
# ============================================================

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "[$timestamp] [$Level] $Message"
    Write-Host $line -ForegroundColor $(switch ($Level) {
        "ERROR" { "Red" }
        "WARN"  { "Yellow" }
        "OK"    { "Green" }
        default { "White" }
    })
    if ($Script:LogFile) {
        Add-Content -Path $Script:LogFile -Value $line
    }
}

function Parse-PlanMetadata {
    <#
    .SYNOPSIS
        Extrai o bloco YAML de metadados do plano.
    #>
    param([string]$Content)

    $metadata = @{}
    if ($Content -match '(?s)## Metadados\s*```yaml\s*(.+?)```') {
        $yamlBlock = $Matches[1]
        foreach ($line in $yamlBlock -split "`n") {
            $line = $line.Trim()
            if ($line -match '^(\w[\w_]*)\s*:\s*"?(.+?)"?\s*$') {
                $metadata[$Matches[1]] = $Matches[2].Trim('"')
            }
        }
    }
    return $metadata
}

function Parse-Tasks {
    <#
    .SYNOPSIS
        Extrai todas as tarefas do plano Markdown.
        Retorna um array de objetos com: Id, Name, DependsOn, Prompt, Validation, Priority.
    #>
    param([string]$Content)

    $tasks = [System.Collections.ArrayList]::new()

    # Split por headers de tarefa (### E{n}.T{n})
    $taskPattern = '###\s+(E\d+\.T\d+(?:\.S\d+)?)\s+.+?\s+(.+?)(?=###\s+E\d+\.T\d+|## Épico \d+|## Validação Final|$)'
    $taskMatches = [regex]::Matches($Content, $taskPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    foreach ($match in $taskMatches) {
        $taskId = $match.Groups[1].Value
        $taskBody = $match.Groups[2].Value

        # Nome da tarefa (do header)
        $taskName = ""
        if ($Content -match "###\s+$([regex]::Escape($taskId))\s+—\s+(.+)") {
            $taskName = $Matches[1].Trim()
        }

        # Dependências
        $dependsOn = @()
        if ($taskBody -match 'depends_on:\s*\[([^\]]*)\]') {
            $depStr = $Matches[1]
            if ($depStr.Trim() -ne "") {
                $dependsOn = ($depStr -split ',') | ForEach-Object { $_.Trim().Trim('"').Trim("'") }
            }
        }

        # Prompt (primeiro bloco de código após "Prompt para o Claude Code:")
        $prompt = ""
        if ($taskBody -match '(?s)\*\*Prompt para o Claude Code:\*\*\s*```\s*\n(.+?)```') {
            $prompt = $Matches[1].Trim()
        }

        # Validação pós-execução
        $validation = ""
        if ($taskBody -match '(?s)\*\*Validação pós-execução:\*\*\s*```bash\s*\n(.+?)```') {
            $validation = $Matches[1].Trim()
            # Remove linhas de comentário
            $validation = ($validation -split "`n" | Where-Object { $_ -notmatch '^\s*#' } | Where-Object { $_.Trim() -ne "" }) -join "`n"
        }

        # Prioridade
        $priority = "medium"
        if ($taskBody -match 'priority:\s*"(\w+)"') {
            $priority = $Matches[1]
        }

        $null = $tasks.Add([PSCustomObject]@{
            Id         = $taskId
            Name       = $taskName
            DependsOn  = $dependsOn
            Prompt     = $prompt
            Validation = $validation
            Priority   = $priority
            Status     = "pending"
            Attempts   = 0
            Output     = ""
            Duration   = $null
        })
    }

    # Parse validação final
    if ($Content -match '(?s)## Validação Final.+?\*\*Validação:\*\*\s*```bash\s*\n(.+?)```') {
        $finalValidation = $Matches[1].Trim()
        $finalValidation = ($finalValidation -split "`n" | Where-Object { $_ -notmatch '^\s*#' } | Where-Object { $_.Trim() -ne "" }) -join "`n"

        $null = $tasks.Add([PSCustomObject]@{
            Id         = "FINAL"
            Name       = "Validação Final"
            DependsOn  = @("*")
            Prompt     = ""
            Validation = $finalValidation
            Priority   = "high"
            Status     = "pending"
            Attempts   = 0
            Output     = ""
            Duration   = $null
        })
    }

    return $tasks.ToArray()
}

function Resolve-ExecutionOrder {
    <#
    .SYNOPSIS
        Ordena tarefas respeitando dependências (topological sort).
    #>
    param([array]$Tasks)

    $resolved = [System.Collections.ArrayList]::new()
    $unresolved = [System.Collections.ArrayList]::new($Tasks)
    $resolvedIds = [System.Collections.Generic.HashSet[string]]::new()
    $maxIterations = $Tasks.Count * $Tasks.Count + 1

    $iteration = 0
    while ($unresolved.Count -gt 0 -and $iteration -lt $maxIterations) {
        $iteration++
        $progressed = $false

        for ($i = $unresolved.Count - 1; $i -ge 0; $i--) {
            $task = $unresolved[$i]

            # FINAL depende de todas as tarefas não-FINAL
            if ($task.DependsOn -contains "*") {
                $allNonFinal = ($Tasks | Where-Object { $_.Id -ne "FINAL" }).Id
                $allResolved = $true
                foreach ($dep in $allNonFinal) {
                    if (-not $resolvedIds.Contains($dep)) {
                        $allResolved = $false
                        break
                    }
                }
                if ($allResolved) {
                    $null = $resolved.Add($task)
                    $null = $resolvedIds.Add($task.Id)
                    $unresolved.RemoveAt($i)
                    $progressed = $true
                }
                continue
            }

            # Verifica se todas as dependências foram resolvidas
            $depsOk = $true
            foreach ($dep in $task.DependsOn) {
                if (-not $resolvedIds.Contains($dep)) {
                    $depsOk = $false
                    break
                }
            }

            if ($depsOk) {
                $null = $resolved.Add($task)
                $null = $resolvedIds.Add($task.Id)
                $unresolved.RemoveAt($i)
                $progressed = $true
            }
        }

        if (-not $progressed) {
            $remaining = ($unresolved | ForEach-Object { $_.Id }) -join ", "
            throw "Dependência circular detectada entre tarefas: $remaining"
        }
    }

    return $resolved.ToArray()
}

function Save-Checkpoint {
    param([array]$Tasks)
    $checkpoint = @{
        timestamp = (Get-Date -Format "o")
        plan_file = $PlanFile
        tasks     = $Tasks | ForEach-Object {
            @{
                id       = $_.Id
                status   = $_.Status
                attempts = $_.Attempts
            }
        }
    }
    $checkpoint | ConvertTo-Json -Depth 5 | Set-Content -Path $Script:CheckpointFile -Encoding UTF8
}

function Load-Checkpoint {
    <#
    .SYNOPSIS
        Restaura estado das tarefas a partir do checkpoint.json.
        Tarefas "done" são mantidas, "running" volta a "pending" para retry.
    #>
    param([array]$Tasks)

    if (-not (Test-Path $Script:CheckpointFile)) {
        Write-Log "Nenhum checkpoint encontrado — execução do início"
        return $false
    }

    try {
        $checkpoint = Get-Content -Path $Script:CheckpointFile -Raw -Encoding UTF8 | ConvertFrom-Json

        # Verifica se o checkpoint é do mesmo plano
        $checkpointPlan = [System.IO.Path]::GetFullPath($checkpoint.plan_file)
        $currentPlan = [System.IO.Path]::GetFullPath($PlanFile)
        if ($checkpointPlan -ne $currentPlan) {
            Write-Log "Checkpoint é de outro plano ($($checkpoint.plan_file)) — ignorando" "WARN"
            return $false
        }

        $restored = 0
        foreach ($savedTask in $checkpoint.tasks) {
            $task = $Tasks | Where-Object { $_.Id -eq $savedTask.id }
            if (-not $task) { continue }

            if ($savedTask.status -eq "done") {
                $task.Status = "done"
                $task.Attempts = $savedTask.attempts
                $restored++
            }
            elseif ($savedTask.status -eq "failed") {
                # Permite retry de tarefas que falharam
                $task.Status = "pending"
                $task.Attempts = 0
            }
            elseif ($savedTask.status -eq "running") {
                # Tarefa interrompida — volta a pending para retry
                $task.Status = "pending"
                $task.Attempts = 0
            }
            # "pending" e "skipped" permanecem como estão
        }

        if ($restored -gt 0) {
            Write-Log "Checkpoint restaurado: $restored tarefa(s) já concluída(s)" "OK"
        }
        return $restored -gt 0
    }
    catch {
        Write-Log "Erro ao ler checkpoint: $_ — execução do início" "WARN"
        return $false
    }
}

function Update-TaskStatusInPlan {
    <#
    .SYNOPSIS
        Atualiza o status de uma tarefa no arquivo Markdown do plano.
    #>
    param(
        [string]$TaskId,
        [string]$NewStatus
    )

    $content = Get-Content -Path $PlanFile -Raw -Encoding UTF8

    # Pattern: dentro do bloco da tarefa, encontra status: "..."
    # Busca o header da tarefa seguido do bloco YAML contendo status
    $pattern = "(###\s+$([regex]::Escape($TaskId))\s+.+?status:\s*`")(\w+)(`")"
    $replacement = "`${1}$NewStatus`${3}"

    $newContent = [regex]::Replace($content, $pattern, $replacement, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    if ($newContent -ne $content) {
        Set-Content -Path $PlanFile -Value $newContent -Encoding UTF8 -NoNewline
        Write-Log "Status de $TaskId atualizado para '$NewStatus' no plano"
    }
}

function Invoke-ClaudeTask {
    <#
    .SYNOPSIS
        Executa uma tarefa via Claude Code CLI em modo --print.
    #>
    param(
        [PSCustomObject]$Task,
        [hashtable]$Metadata
    )

    $model = if ($Metadata.ContainsKey("model")) { $Metadata["model"] } else { "sonnet" }
    $maxTurns = if ($Metadata.ContainsKey("max_turns_per_task")) { $Metadata["max_turns_per_task"] } else { "25" }
    $maxBudget = if ($Metadata.ContainsKey("max_budget_per_task_usd")) { $Metadata["max_budget_per_task_usd"] } else { "1.00" }
    $permissionMode = if ($Metadata.ContainsKey("permission_mode")) { $Metadata["permission_mode"] } else { "bypassPermissions" }
    $workDir = if ($Metadata.ContainsKey("working_directory")) { $Metadata["working_directory"] } else { (Get-Location).Path }

    $taskLogFile = Join-Path $LogDir "$($Task.Id)-output.json"

    # Monta argumentos do Claude CLI
    $args = @(
        "--print"
        "--model", $model
        "--output-format", "json"
        "--max-turns", $maxTurns
        "--max-budget-usd", $maxBudget
        "--permission-mode", $permissionMode
        "--verbose"
    )

    Write-Log "Executando Claude CLI: claude $($args -join ' ')"
    Write-Log "Prompt: $($Task.Prompt.Substring(0, [Math]::Min(120, $Task.Prompt.Length)))..."

    try {
        # Executa Claude Code via stdin para evitar problemas de escape
        $result = $Task.Prompt | & claude @args 2>&1

        # Salva output completo
        $result | Set-Content -Path $taskLogFile -Encoding UTF8

        # Tenta extrair resultado JSON
        $jsonOutput = $null
        try {
            $jsonOutput = $result | ConvertFrom-Json
        }
        catch {
            # Output não é JSON válido — trata como texto
            $jsonOutput = @{ result = ($result -join "`n") }
        }

        return @{
            Success = $true
            Output  = $jsonOutput
            LogFile = $taskLogFile
        }
    }
    catch {
        Write-Log "Erro na execução do Claude: $_" "ERROR"
        return @{
            Success = $false
            Output  = $_.ToString()
            LogFile = $taskLogFile
        }
    }
}

function Invoke-Validation {
    <#
    .SYNOPSIS
        Executa comandos de validação pós-tarefa.
    #>
    param([string]$ValidationCommands, [hashtable]$Metadata)

    if ([string]::IsNullOrWhiteSpace($ValidationCommands)) {
        Write-Log "Nenhuma validação definida — assumindo sucesso" "WARN"
        return $true
    }

    $workDir = if ($Metadata.ContainsKey("working_directory")) { $Metadata["working_directory"] } else { (Get-Location).Path }

    foreach ($cmd in ($ValidationCommands -split "`n")) {
        $cmd = $cmd.Trim()
        if ([string]::IsNullOrWhiteSpace($cmd)) { continue }

        # Remove chaves de placeholder
        $cmd = $cmd.TrimStart('{').TrimEnd('}')

        Write-Log "Validação: $cmd"
        try {
            Push-Location $workDir
            $output = Invoke-Expression $cmd 2>&1
            $exitCode = $LASTEXITCODE
            Pop-Location

            if ($exitCode -ne 0) {
                Write-Log "Validação falhou (exit $exitCode): $cmd" "ERROR"
                Write-Log "Output: $($output | Out-String)" "ERROR"
                return $false
            }
            Write-Log "Validação OK: $cmd" "OK"
        }
        catch {
            Pop-Location
            Write-Log "Erro na validação: $_" "ERROR"
            return $false
        }
    }

    return $true
}

function Write-ExecutionReport {
    param([array]$Tasks, [hashtable]$Metadata)

    $endTime = Get-Date
    $duration = $endTime - $Script:StartTime

    $report = @{
        plan_file  = $PlanFile
        plan_name  = $Metadata["plan_name"]
        started_at = $Script:StartTime.ToString("o")
        ended_at   = $endTime.ToString("o")
        duration   = $duration.ToString()
        summary    = @{
            total   = $Tasks.Count
            done    = @($Tasks | Where-Object { $_.Status -eq "done" }).Count
            failed  = @($Tasks | Where-Object { $_.Status -eq "failed" }).Count
            skipped = @($Tasks | Where-Object { $_.Status -eq "skipped" }).Count
            pending = @($Tasks | Where-Object { $_.Status -eq "pending" }).Count
        }
        tasks      = $Tasks | ForEach-Object {
            @{
                id       = $_.Id
                name     = $_.Name
                status   = $_.Status
                attempts = $_.Attempts
                duration = if ($_.Duration) { $_.Duration.ToString() } else { $null }
            }
        }
    }

    $report | ConvertTo-Json -Depth 5 | Set-Content -Path $Script:ReportFile -Encoding UTF8

    # Sumário no console
    Write-Host ""
    Write-Host "=" * 60 -ForegroundColor Cyan
    Write-Host "  RELATÓRIO DE EXECUÇÃO" -ForegroundColor Cyan
    Write-Host "=" * 60 -ForegroundColor Cyan
    Write-Host "  Plano:     $($Metadata['plan_name'])"
    Write-Host "  Duração:   $($duration.ToString('hh\:mm\:ss'))"
    Write-Host "  Total:     $($report.summary.total) tarefas"
    Write-Host "  Sucesso:   $($report.summary.done)" -ForegroundColor Green
    Write-Host "  Falha:     $($report.summary.failed)" -ForegroundColor $(if ($report.summary.failed -gt 0) { "Red" } else { "White" })
    Write-Host "  Ignoradas: $($report.summary.skipped)" -ForegroundColor Yellow
    Write-Host "  Pendentes: $($report.summary.pending)"
    Write-Host "=" * 60 -ForegroundColor Cyan
    Write-Host "  Relatório: $Script:ReportFile"
    Write-Host "  Logs:      $LogDir"
    Write-Host "=" * 60 -ForegroundColor Cyan
}

# ============================================================
# EXECUÇÃO PRINCIPAL
# ============================================================

# Prepara diretório de logs
if (-not (Test-Path $LogDir)) {
    New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
}

$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$Script:LogFile = Join-Path $LogDir "execution-$timestamp.log"

Write-Log "Iniciando orquestrador de plano"
Write-Log "Arquivo do plano: $PlanFile"

# Lê e parseia o plano
$planContent = Get-Content -Path $PlanFile -Raw -Encoding UTF8
$metadata = Parse-PlanMetadata -Content $planContent
$tasks = Parse-Tasks -Content $planContent

if ($tasks.Count -eq 0) {
    Write-Log "Nenhuma tarefa encontrada no plano" "ERROR"
    exit 1
}

Write-Log "Plano: $($metadata['plan_name'])"
Write-Log "Tarefas encontradas: $($tasks.Count)"

# Resolve ordem de execução
$orderedTasks = Resolve-ExecutionOrder -Tasks $tasks
Write-Log "Ordem de execução: $(($orderedTasks | ForEach-Object { $_.Id }) -join ' → ')"

# Restaura checkpoint (apenas se StartFrom não foi especificado)
if ([string]::IsNullOrEmpty($StartFrom)) {
    $null = Load-Checkpoint -Tasks $orderedTasks
}

# Aplica StartFrom (pula tarefas anteriores)
$shouldExecute = [string]::IsNullOrEmpty($StartFrom)
foreach ($task in $orderedTasks) {
    if (-not $shouldExecute) {
        if ($task.Id -eq $StartFrom) {
            $shouldExecute = $true
        }
        else {
            $task.Status = "skipped"
            Write-Log "Pulando tarefa $($task.Id) (retomada a partir de $StartFrom)" "WARN"
        }
    }
}

# Dry run
if ($DryRun) {
    Write-Host "`n=== DRY RUN ===" -ForegroundColor Yellow
    foreach ($task in $orderedTasks) {
        $statusColor = switch ($task.Status) {
            "skipped" { "DarkGray" }
            default { "White" }
        }
        $deps = if (@($task.DependsOn).Count -gt 0) { " (deps: $($task.DependsOn -join ', '))" } else { "" }
        Write-Host "  [$($task.Status.ToUpper().PadRight(7))] $($task.Id) — $($task.Name)$deps" -ForegroundColor $statusColor
        if ($task.Status -ne "skipped" -and $task.Prompt) {
            Write-Host "           Prompt: $($task.Prompt.Substring(0, [Math]::Min(80, $task.Prompt.Length)))..." -ForegroundColor DarkGray
        }
    }
    Write-Host "`nTotal: $($orderedTasks.Count) tarefas ($( @($orderedTasks | Where-Object { $_.Status -eq 'skipped' }).Count ) serão puladas)`n"
    exit 0
}

# Execução das tarefas
$failedTasks = @()

foreach ($task in $orderedTasks) {
    if ($task.Status -eq "skipped") { continue }
    if ($task.Status -eq "done") {
        Write-Log "Tarefa $($task.Id) já concluída (checkpoint) — pulando" "OK"
        continue
    }

    # Verifica se dependências foram concluídas com sucesso
    $depsFailed = $false
    foreach ($dep in $task.DependsOn) {
        if ($dep -eq "*") { continue }
        $depTask = $orderedTasks | Where-Object { $_.Id -eq $dep }
        if ($depTask -and $depTask.Status -ne "done" -and $depTask.Status -ne "skipped") {
            Write-Log "Tarefa $($task.Id) não pode executar: dependência $dep está em status '$($depTask.Status)'" "ERROR"
            $depsFailed = $true
            break
        }
    }

    if ($depsFailed) {
        $task.Status = "failed"
        $failedTasks += $task.Id
        Save-Checkpoint -Tasks $orderedTasks
        continue
    }

    Write-Host ""
    Write-Log "━━━ Tarefa $($task.Id): $($task.Name) ━━━"

    # FINAL não tem prompt — apenas validação
    if ($task.Id -eq "FINAL") {
        Write-Log "Executando validação final..."
        $validationOk = Invoke-Validation -ValidationCommands $task.Validation -Metadata $metadata
        $task.Status = if ($validationOk) { "done" } else { "failed" }
        if (-not $validationOk) { $failedTasks += $task.Id }
        Save-Checkpoint -Tasks $orderedTasks
        Update-TaskStatusInPlan -TaskId $task.Id -NewStatus $task.Status
        continue
    }

    if ([string]::IsNullOrWhiteSpace($task.Prompt)) {
        Write-Log "Tarefa sem prompt — pulando" "WARN"
        $task.Status = "skipped"
        Save-Checkpoint -Tasks $orderedTasks
        Update-TaskStatusInPlan -TaskId $task.Id -NewStatus "skipped"
        continue
    }

    # Loop de tentativas
    $success = $false
    for ($attempt = 1; $attempt -le ($MaxRetries + 1); $attempt++) {
        $task.Attempts = $attempt
        $task.Status = "running"
        Save-Checkpoint -Tasks $orderedTasks

        if ($attempt -gt 1) {
            Write-Log "Tentativa $attempt/$($MaxRetries + 1)..." "WARN"
        }

        $taskStart = Get-Date

        # Executa via Claude Code
        $result = Invoke-ClaudeTask -Task $task -Metadata $metadata
        $task.Duration = (Get-Date) - $taskStart

        if (-not $result.Success) {
            Write-Log "Claude retornou erro na tarefa $($task.Id)" "ERROR"
            if ($attempt -le $MaxRetries) {
                Write-Log "Aguardando 5s antes de retry..." "WARN"
                Start-Sleep -Seconds 5
            }
            continue
        }

        Write-Log "Claude completou tarefa $($task.Id) em $($task.Duration.ToString('mm\:ss'))" "OK"

        # Validação pós-execução
        if (-not [string]::IsNullOrWhiteSpace($task.Validation)) {
            Write-Log "Executando validação..."
            $validationOk = Invoke-Validation -ValidationCommands $task.Validation -Metadata $metadata
            if (-not $validationOk) {
                Write-Log "Validação falhou para tarefa $($task.Id)" "ERROR"
                if ($attempt -le $MaxRetries) {
                    Write-Log "Aguardando 5s antes de retry..." "WARN"
                    Start-Sleep -Seconds 5
                }
                continue
            }
        }

        $success = $true
        break
    }

    $task.Status = if ($success) { "done" } else { "failed" }
    if ($success) {
        Write-Log "Tarefa $($task.Id) concluída com sucesso" "OK"
    }
    else {
        Write-Log "Tarefa $($task.Id) falhou após $($task.Attempts) tentativa(s)" "ERROR"
        $failedTasks += $task.Id
    }

    Save-Checkpoint -Tasks $orderedTasks
    Update-TaskStatusInPlan -TaskId $task.Id -NewStatus $task.Status
}

# Relatório final
Write-ExecutionReport -Tasks $orderedTasks -Metadata $metadata

# Exit code
if (@($failedTasks).Count -gt 0) {
    Write-Log "Execução finalizada com $(@($failedTasks).Count) falha(s): $($failedTasks -join ', ')" "ERROR"
    Write-Log "Para retomar: ./run-plan.ps1 -PlanFile $PlanFile -StartFrom '$($failedTasks[0])'" "WARN"
    exit 1
}
else {
    Write-Log "Todas as tarefas concluídas com sucesso!" "OK"
    exit 0
}

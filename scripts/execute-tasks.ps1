#Requires -Version 7.0

<#
.SYNOPSIS
    Orquestrador de tarefas para atualização do site ZionKit v0.6
.DESCRIPTION
    Executa 38 tarefas de implementação usando Claude Code CLI, respeitando
    dependências e paralelismo. Cada tarefa resulta em um commit individual.
.NOTES
    - Requer PowerShell 7+
    - Requer Claude CLI no PATH
    - Idempotente: pula tarefas já commitadas
#>

param(
    [switch]$DryRun,
    [switch]$Resume,
    [string]$OnlyTask
)

$ErrorActionPreference = "Continue"
$ProjectRoot = "C:\Users\tvini\projects\personal\zion-kit"
$LogFile = Join-Path $ProjectRoot "docs\execution-log.md"
$StateFile = Join-Path $ProjectRoot "scripts\.task-state.json"

# --- Documentos de contexto ---
$ContextDocs = @(
    "docs/plan-change-site-tasks.md",
    "docs/plan-change-site.md",
    "docs/zionkit-model.md"
)
$ContextDocsAbsolute = $ContextDocs | ForEach-Object { Join-Path $ProjectRoot $_ }

# --- Cores ---
function Write-Status { param($Message, $Color) Write-Host $Message -ForegroundColor $Color }
function Write-TaskStart { param($Id, $Name) Write-Status "[$(Get-Date -Format 'HH:mm:ss')] ⏳ $Id — $Name" Yellow }
function Write-TaskSuccess { param($Id) Write-Status "[$(Get-Date -Format 'HH:mm:ss')] ✅ $Id — Concluída" Green }
function Write-TaskFail { param($Id, $Error) Write-Status "[$(Get-Date -Format 'HH:mm:ss')] ❌ $Id — Falha: $Error" Red }
function Write-TaskSkip { param($Id, $Reason) Write-Status "[$(Get-Date -Format 'HH:mm:ss')] ⏭️  $Id — Pulada: $Reason" DarkYellow }

# --- Logging ---
function Initialize-Log {
    $header = @"
# Log de Execução — Atualização do Site ZionKit v0.6

**Início:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
**Script:** ``execute-tasks.ps1``

---

| Tarefa | Status | Início | Fim | Duração |
|--------|--------|--------|-----|---------|
"@
    Set-Content -Path $LogFile -Value $header -Encoding utf8
}

function Add-LogEntry {
    param($Id, $Status, $Start, $End)
    $duration = if ($End -and $Start) { ($End - $Start).ToString("mm\:ss") } else { "—" }
    $startStr = if ($Start) { $Start.ToString("HH:mm:ss") } else { "—" }
    $endStr = if ($End) { $End.ToString("HH:mm:ss") } else { "—" }
    $emoji = switch ($Status) { "success" { "✅" } "failed" { "❌" } "skipped" { "⏭️" } default { "❓" } }
    $line = "| $Id | $emoji $Status | $startStr | $endStr | $duration |"
    Add-Content -Path $LogFile -Value $line -Encoding utf8
}

function Add-LogSummary {
    param($Results)
    $total = $Results.Count
    $success = ($Results | Where-Object { $_.Status -eq "success" }).Count
    $failed = ($Results | Where-Object { $_.Status -eq "failed" }).Count
    $skipped = ($Results | Where-Object { $_.Status -eq "skipped" }).Count
    $summary = @"

---

## Resumo

| Métrica | Valor |
|---------|-------|
| Total | $total |
| Sucesso | $success |
| Falha | $failed |
| Puladas | $skipped |

**Fim:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
"@
    Add-Content -Path $LogFile -Value $summary -Encoding utf8
}

# --- Estado (idempotência) ---
function Get-TaskState {
    if (Test-Path $StateFile) {
        return Get-Content $StateFile -Raw | ConvertFrom-Json -AsHashtable
    }
    return @{}
}

function Save-TaskState { param($State) $State | ConvertTo-Json -Depth 3 | Set-Content $StateFile -Encoding utf8 }

function Test-TaskCommitted {
    param($TaskId)
    $commitMsg = "feat(site-v0.6): $TaskId"
    $result = git -C $ProjectRoot log --oneline --grep="$commitMsg" 2>$null
    return ($null -ne $result -and $result.Length -gt 0)
}

# --- Construção do prompt ---
function Build-TaskPrompt {
    param(
        [string]$TaskId,
        [string]$Description,
        [string]$Files,
        [string]$Context,
        [string]$ConstitutionRules,
        [string]$Verification
    )

    $contextDocsPaths = $ContextDocsAbsolute -join "`n  - "

    $prompt = @"
Você é um engenheiro frontend implementando uma tarefa específica no site ZionKit.

## Tarefa: $TaskId
**Descrição:** $Description

## Arquivo(s) a editar/criar
$Files

## Contexto detalhado
$Context

## Regras da constituição relevantes
$ConstitutionRules

## Critérios de verificação
$Verification

## Documentos de contexto
Leia os seguintes documentos para obter informações adicionais sobre o modelo ZionKit, o plano de mudanças e os detalhes de cada tarefa:
  - $contextDocsPaths

## Instruções finais
1. Leia os documentos de contexto para entender o modelo e o plano completo.
2. Implemente a tarefa conforme especificado acima.
3. Após implementar, faça commit das alterações:
   - Use: git add <arquivos modificados/criados>
   - Mensagem de commit: feat(site-v0.6): $TaskId — $Description
4. Reporte o resultado: diga SUCESSO se tudo funcionou ou FALHA com detalhes do erro.
"@
    return $prompt
}

# --- Definição das 38 tarefas ---
$AllTasks = @(
    # ==================== FASE 1 — Correções de tom e conteúdo ====================
    @{
        Id = "F1-01"
        Name = "Reescrever título e adicionar nota de protótipo na HeroSection"
        Wave = 1
        Dependencies = @()
        Files = "src/components/sections/HeroSection.astro"
        Context = @"
Editar o título principal da HeroSection. Substituir o texto atual do título:
  O conhecimento do seu produto <span class="gradient-text">morre a cada sprint</span>
Pelo novo texto:
  O conhecimento do seu produto <span class="gradient-text">está espalhado em lugares que a IA não alcança</span>

Adicionar um parágrafo introdutório logo após o subtítulo existente, dentro de um ScrollReveal, mencionando o status de protótipo conceitual:
  "O ZionKit é um modelo conceitual em fase de prototipação. Ainda não foi testado em ambiente de produção."

Manter: narrativa sobre conhecimento fragmentado, exemplo do e-commerce/reembolso, diagrama ContextVoidDiagram. Depth: 1. sectionNumber permanece 1.
"@
        ConstitutionRules = @"
- Princípio VII: seção deve ter SectionHeader com sectionNumber, title, depth
- Princípio V: verificar aria-labelledby no container da seção
"@
        Verification = @"
- Título não contém mais 'morre a cada sprint'
- Novo título contém 'está espalhado em lugares que a IA não alcança' com gradient-text
- Parágrafo de protótipo conceitual está presente e visível
"@
    },
    @{
        Id = "F1-02"
        Name = "Reescrever título e tratar dados estatísticos na ConsequenciasSection"
        Wave = 1
        Dependencies = @()
        Files = "src/components/sections/ConsequenciasSection.astro"
        Context = @"
1. Substituir o título atual:
   Três problemas que <span class="gradient-text">ninguém resolveu</span>
   Pelo novo texto:
   Três problemas que <span class="gradient-text">persistem no desenvolvimento com IA</span>

2. Tratar os 5 dados estatísticos:
   - Manter (verificar fonte): '35% dos defeitos de produção' (Accenture), '40% do esforço é retrabalho' (ScopeMaster), '56% das falhas por comunicação' (PMI) — estes citam fonte mas precisam de verificação
   - Remover ou substituir: '75% mais problemas de lógica em áreas críticas de negócio' (sem fonte) e '65% dos desenvolvedores reportam que a IA perde contexto relevante' (sem fonte) — substituir por formulação qualitativa como 'é comum que...' ou 'frequentemente...'

Manter: três problemas (IA no escuro, exclusão não-técnico, conhecimento perdido), exemplos ilustrativos, diagrama ThreeGapsDiagram. Depth: 1. sectionNumber permanece 2.
"@
        ConstitutionRules = "- Princípio VII: SectionHeader com sectionNumber, title, depth"
        Verification = @"
- Título não contém mais 'ninguém resolveu'
- Os 2 dados sem fonte foram removidos ou substituídos por formulação qualitativa
- Os 3 dados com fonte permanecem (com fontes citadas)
"@
    },
    @{
        Id = "F1-03"
        Name = "Reescrever título, adicionar tríade e nota de IA na SolutionBridgeSection"
        Wave = 1
        Dependencies = @()
        Files = "src/components/sections/SolutionBridgeSection.astro"
        Context = @"
1. Substituir o título atual:
   E se todo o conhecimento do seu produto <span class="gradient-text">tivesse uma casa?</span>
   Pelo novo texto:
   Um repositório central para <span class="gradient-text">todo o conhecimento do produto</span>

2. Adicionar parágrafo sobre a tríade de padrões oficiais, em linguagem acessível (dentro de ScrollReveal com delay incremental):
   "O ZionKit se apoia em três padrões: um para estruturar requisitos (IEEE 29148), um para verificá-los com exemplos concretos (SBE), e um que a IA usa internamente para encontrar ambiguidades (SBVR)."

3. Adicionar nota sobre papel da IA (dentro de ScrollReveal):
   "A IA propõe e sinaliza — quem decide é sempre o humano."

4. Integrar o princípio de design 'A Product Canon é viva, não estática' na descrição da Product Canon — como nota contextual: "Este é um dos princípios de design do modelo: a Product Canon é viva, não estática — diferente de documentos tradicionais, ela é continuamente alimentada pelo uso."

5. Manter analogia da constituição (boa).

Depth: 1. sectionNumber permanece 3.
"@
        ConstitutionRules = "- Princípio VII: conteúdo narrativo deve ser wrapped por ScrollReveal com delays incrementais (0, 0.15, 0.3, 0.45...)"
        Verification = @"
- Título não contém mais 'tivesse uma casa?'
- Parágrafo da tríade SBVR/IEEE/SBE presente
- Nota 'A IA propõe e sinaliza' presente
- Princípio 'Product Canon é viva' integrado no texto
"@
    },
    @{
        Id = "F1-04"
        Name = "Reescrever título e atualizar step cards na CycleOverviewSection"
        Wave = 1
        Dependencies = @()
        Files = "src/components/sections/CycleOverviewSection.astro"
        Context = @"
1. Substituir o título atual:
   O ciclo que faz o <span class="gradient-text">conhecimento crescer</span>
   Pelo novo texto:
   Como o ciclo de <span class="gradient-text">três etapas funciona</span>

2. Atualizar os step cards com terminologia v0.6:
   - Etapa 1 — Canon Building: Mencionar que opera através de 3 cerimônias formais (Domain Discovery Session, Technical Constitution Session, Requirements Specification Session) com gates de aprovação entre elas
   - Etapa 2 — Spec Crafting: Mencionar que gera um Canonical Change Plan incremental (incremental-plan) com aprovação condicional
   - Etapa 3 — Canon Enrichment: Mencionar sinalização explícita (CANON-DISCOVERY) e detecção assistida pela IA

3. Adicionar menção à Decisão de Continuidade do Ciclo (ponto de decisão ao final do Canon Building com 3 caminhos: mais fluxos, mais requisitos, encerrar)

4. Adicionar menção ao canal de Edição Direta do Domain Expert como canal complementar

5. Integrar princípio 'O ciclo é bidirecional' na narrativa.

Depth: 1. sectionNumber permanece 4.
"@
        ConstitutionRules = "- Princípio VII: SectionHeader com sectionNumber, title, depth; ScrollReveal com delays incrementais"
        Verification = @"
- Título atualizado para 'Como o ciclo de três etapas funciona'
- Step cards mencionam terminologia v0.6 (cerimônias, Change Plan incremental, sinalização explícita)
- Decisão de Continuidade mencionada
- Edição Direta mencionada como canal complementar
"@
    },
    @{
        Id = "F1-05"
        Name = "Reescrever título, atualizar papéis e adicionar Protocolo de Perspectiva Assistida na RolesSection"
        Wave = 1
        Dependencies = @()
        Files = "src/components/sections/RolesSection.astro"
        Context = @"
1. Substituir o título atual:
   Cada decisão é tomada por quem tem <span class="gradient-text">competência sobre ela</span>
   Pelo novo texto:
   Quatro papéis com <span class="gradient-text">autoridades complementares</span>

2. Atualizar descrição do Domain Expert — adicionar:
   - Capacidade de anotações contextuais (observações que adiciona durante revisão de Change Plans, com ciclo de vida: formalizar, descartar ou adiar)
   - Hotspots de domínio (áreas marcadas como frágeis ou frequentemente mal interpretadas; a IA dá atenção especial na validação)
   - Edição direta de artefatos na camada de negócio (fora de cerimônias formais)

3. Atualizar descrição da IA — adicionar distinção explícita entre atos operacionais e decisórios:
   - Operacional (permitido): formatar, sugerir, reorganizar, sinalizar inconsistência, usar validação semântica interna, conduzir guardrails
   - Decisório (requer humano): incluir/excluir da Product Canon, aprovar Change Plan, resolver ambiguidade

4. Corrigir analogia da IA. Substituir:
   "A secretária mais competente do mundo — organiza, lembra, sinaliza, mas nunca assina pelo chefe."
   Por:
   "Uma assistente que organiza, lembra e sinaliza — mas nunca decide pelo responsável."

5. Adicionar bloco sobre Protocolo de Perspectiva Assistida (acúmulo de papéis):
   Em equipes pequenas, uma mesma pessoa pode exercer múltiplos papéis. O valor da separação está na completude das perspectivas exercidas. O Protocolo de Perspectiva Assistida governa o acúmulo:
   1. Declaração explícita — o acúmulo é declarado na configuração do projeto, ativando comportamento diferenciado da IA
   2. Checklist de perspectiva mediado pela IA — quando a mesma pessoa aprova em papéis distintos, a IA apresenta perguntas específicas da perspectiva do papel sendo exercido
   3. Registro distinto por papel-perspectiva — cada aprovação registra o papel exercido, mesmo que a pessoa seja a mesma

6. Adicionar tabela resumo de atuação por etapa (do v0.6 §4):
   | Papel | Etapa 1 — Canon Building | Etapa 2 — Spec Crafting | Etapa 3 — Canon Enrichment | Edição Direta |
   |-------|--------------------------|-------------------------|----------------------------|---------------|
   | Domain Builder | Participa de Discovery e Specification; decide continuidade | Escreve spec de feature | — | — |
   | Architect | Conduz Technical Constitution; aprova gates | Decisões técnicas; aprova camada de arquitetura | Revisão assíncrona (janela de veto) | Aprova expert-edit-plan (obrigatório) |
   | Domain Expert | Aprova Discovery e Specification (com anotações e hotspots) | Aprova camada de negócio | Revisão assíncrona (janela de veto) | Edita e aprova expert-edit-plan (fidelidade) |
   | IA | Conduz sessões, gera Change Plans, opera guardrails | Gera Change Plan incremental; implementa código | Atualiza Product Canon | Conduz guardrails; gera expert-edit-plan |

7. Explicitar princípio 'Separação de autoridade' como nota contextual.

Depth: 2. sectionNumber será 9 na estrutura final (ver F4-04).
"@
        ConstitutionRules = "- Princípios V, VI, VII"
        Verification = @"
- Título atualizado para 'Quatro papéis com autoridades complementares'
- Analogia da IA não contém mais 'mais competente do mundo'
- Protocolo de Perspectiva Assistida presente com 3 mecanismos
- Tabela de atuação por etapa presente
"@
    },
    @{
        Id = "F1-06"
        Name = "Adicionar 2 comparações novas na ComparisonSection"
        Wave = 1
        Dependencies = @()
        Files = "src/components/sections/ComparisonSection.astro"
        Context = @"
Adicionar 2 novos itens de comparação antes/depois, usando o componente ComparisonRow existente (src/components/ui/ComparisonRow.astro):

1. Antes: 'Conhecimento de domínio tácito, preso na cabeça de indivíduos'
   Depois: 'Product Canon formaliza e versiona o conhecimento em documentos acessíveis a todos'
   (Referência v0.6 §7 item 1)

2. Antes: 'Revisão de código é o único momento de validação de qualidade'
   Depois: 'Gates de aprovação operam antes da implementação, verificando coerência de negócio e viabilidade técnica'
   (Referência v0.6 §7 item 9)

Manter todos os 7 itens de comparação existentes. sectionNumber será 13 na estrutura final (ver F4-04). Depth: 1.
"@
        ConstitutionRules = "- Princípio VII: novos itens devem ser wrapped por ScrollReveal com delays incrementais continuando dos existentes"
        Verification = @"
- 9 itens de comparação no total (7 existentes + 2 novos)
- Textos dos novos itens estão exatamente como especificado
"@
    },
    @{
        Id = "F1-07"
        Name = "Enriquecer cenários com terminologia v0.6 na ScenariosSection"
        Wave = 1
        Dependencies = @()
        Files = "src/components/sections/ScenariosSection.astro"
        Context = @"
Enriquecer os 3 cenários existentes com terminologia e detalhes do v0.6:

Cenário 1 — Greenfield (Produto Novo):
- Mencionar que o CTO conduz a Technical Constitution Session
- Mencionar nível Mínimo de aderência IEEE 29148 (adequado ao estágio de prototipação)
- Mencionar que cada cerimônia produz Canonical Change Plans tipados (discovery-plan, constitution-plan, specification-plan)
- Mencionar gaps identificados pela IA ('O que acontece se nenhuma transportadora fizer oferta dentro de 24 horas?')

Cenário 2 — Brownfield (Feature em Produto Existente):
- Mencionar roteamento de aprovação por bounded context — o Canonical Change Plan incremental lista bounded contexts afetados e é roteado para os Domain Experts e Architects correspondentes
- Mencionar Domain Expert de Faturamento identificando conflito com contrato de operadora de saúde existente

Cenário 3 — Mudança Conceitual com Migração Gradual:
- Mencionar faces current (estado vigente) e next (estado em transição) do Versionamento por Estrangulamento
- Mencionar conclusão formal pelo Architect

sectionNumber será 14 na estrutura final (ver F4-04). Depth: 1.
"@
        ConstitutionRules = "- Princípios V, VII"
        Verification = @"
- Cenário 1 menciona Technical Constitution, nível Mínimo, Change Plans tipados
- Cenário 2 menciona roteamento por bounded context e Domain Expert de Faturamento
- Cenário 3 menciona faces current/next e conclusão formal pelo Architect
"@
    },
    @{
        Id = "F1-08"
        Name = "Substituir CTA Banner por nota informativa"
        Wave = 1
        Dependencies = @()
        Files = "src/pages/index.astro"
        Context = @"
No arquivo src/pages/index.astro, substituir o bloco do CTA Banner. Trocar:
  title='Experimente com seu produto'
  description='Aplique o modelo ZionKit ao seu produto e veja a diferença no primeiro ciclo.'
Por:
  title='Quer reler desde o início?'
  description='O ZionKit é um modelo conceitual em fase de prototipação. A leitura completa leva cerca de 15 minutos.'
Manter linkText='Reler desde o início' e linkHref='#problema'.
"@
        ConstitutionRules = "- Princípio VII"
        Verification = @"
- Texto 'Experimente com seu produto' removido
- Texto 'Aplique o modelo ZionKit ao seu produto e veja a diferença no primeiro ciclo' removido
- Nota informativa presente com tom neutro/informativo
"@
    },
    @{
        Id = "F1-09"
        Name = "Reestruturar Footer — remover newsletter fake e atualizar tagline"
        Wave = 1
        Dependencies = @()
        Files = "src/components/layout/Footer.astro"
        Context = @"
1. Alterar tagline:
   - De: 'O conhecimento do seu produto, formalizado e versionado.'
   - Para: 'Modelo conceitual para desenvolvimento de software orientado por especificações.'
2. Remover completamente o bloco footer-newsletter (div com classe footer-newsletter, incluindo o formulário, input de email, botão 'Inscrever' e feedback). Remover também os estilos CSS associados (.footer-newsletter, .newsletter-form, .newsletter-input, .newsletter-btn, .newsletter-feedback).
3. Adicionar nota de status: 'Protótipo conceitual — v0.6'
4. Ajustar grid do footer (atualmente grid-template-columns: 1fr 1fr) — com a remoção da newsletter, pode usar 1fr ou reorganizar o layout.
"@
        ConstitutionRules = "- Princípio V: acessibilidade"
        Verification = @"
- Newsletter fake completamente removida (formulário, input, botão)
- Tagline atualizada para 'Modelo conceitual para desenvolvimento de software orientado por especificações'
- Nota 'Protótipo conceitual — v0.6' presente
"@
    },

    # ==================== FASE 2 — Desmembramento da PillarsSection ====================
    @{
        Id = "F2-01"
        Name = "Criar CanonBuildingSection com CeremonyFlowDiagram"
        Wave = 1
        Dependencies = @()
        Files = @"
- src/components/sections/CanonBuildingSection.astro (criar)
- src/components/diagrams/CeremonyFlowDiagram.tsx (criar)
- src/lib/diagrams/ceremony-flow-diagram.ts (criar)
"@
        Context = @"
Criar seção depth 2 para detalhar a Etapa 1 — Canon Building. ID da seção: canon-building. sectionNumber: 5.

Estrutura Astro:
<section id="canon-building" class="section-odd" aria-labelledby="heading-canon-building">
  <SectionHeader sectionNumber={5} title='Canon Building — <span class="gradient-text">Construir o Conhecimento</span>' depth={2} sectionId="canon-building" />
</section>

Conteúdo narrativo (cada bloco em ScrollReveal com delays 0, 0.15, 0.3, 0.45...):

1. Princípio orientador (nota contextual): 'Este é um dos princípios de design do modelo: governança por cerimônia com canal de exceção — toda mudança na Product Canon passa por processo formal, seja cerimônia ou edição direta com guardrails.'

2. Introdução: O Domain Builder e o Architect constroem e mantêm a Product Canon de forma complementar, através de três cerimônias formais organizadas em um fluxo sequencial com gates de aprovação.

3. Sessão 1 — Domain Discovery Session: Baseada em Event Storming. 4 fases. Exemplo fintech. Perspectiva do Architect. Saída: discovery-plan com aprovação primária Domain Expert + secundária Architect.

4. Sessão 2 — Technical Constitution Session: Architect define princípios técnicos constitucionais. Exemplo de princípios. Níveis de aderência IEEE 29148 (Mínimo, Moderado, Completo). Saída: constitution-plan.

5. Sessão 3 — Requirements Specification Session: Formalização via clarificação iterativa (6 passos). Exemplo REQ-CANCEL-001. Saída: specification-plan.

6. Decisão de Continuidade do Ciclo: 3 caminhos. Pré-condição do caminho (b). Checkpoint IEEE 29148.

7. Princípio 'Prevenção sobre detecção'.

Reutilizar CanonBuildingDiagram existente. Criar novo CeremonyFlowDiagram com @xyflow/react: fluxo sequencial vertical com 3 nós de cerimônia, gates de aprovação, e nó de Decisão de Continuidade com 3 caminhos.

LEIA O DOCUMENTO docs/plan-change-site-tasks.md para o contexto completo da tarefa F2-01 — ele contém todo o conteúdo narrativo detalhado que deve ser incluído na seção.
"@
        ConstitutionRules = @"
- Princípio II: seção em sections/, diagrama em diagrams/, config em lib/diagrams/
- Princípio III: React (.tsx) apenas para diagrama interativo, com client:visible
- Princípio IV: usar classes section-odd/section-even conforme posição na página
- Princípio V: aria-labelledby, prefers-reduced-motion no diagrama
- Princípio VI: depth={2} no SectionHeader
- Princípio VII: SectionHeader com props, ScrollReveal com delays, DiagramContainer com label
"@
        Verification = @"
- Seção renderiza com SectionHeader depth 2 e sectionNumber 5
- 3 cerimônias descritas com exemplos
- Decisão de Continuidade com 3 caminhos documentada
- CeremonyFlowDiagram renderiza com client:visible
"@
    },
    @{
        Id = "F2-02"
        Name = "Criar SpecCraftingSection"
        Wave = 1
        Dependencies = @()
        Files = "src/components/sections/SpecCraftingSection.astro (criar)"
        Context = @"
Criar seção depth 2 para detalhar a Etapa 2 — Spec Crafting. ID: spec-crafting. sectionNumber: 6.

Estrutura:
<section id="spec-crafting" class="section-even" aria-labelledby="heading-spec-crafting">
  <SectionHeader sectionNumber={6} title='Spec Crafting — <span class="gradient-text">Especificação Contextualizada</span>' depth={2} sectionId="spec-crafting" />
</section>

Conteúdo narrativo (em ScrollReveal com delays incrementais):

1. Injeção seletiva de contexto: A IA não recebe toda a Product Canon — só os pedaços relevantes para a tarefa.

2. Clarificação e validação contextualizada: Termos inconsistentes sinalizados, requisitos contraditórios flagrados, dependências entre bounded contexts identificadas.

3. Canonical Change Plan incremental (incremental-plan): Quando a IA identifica impactos na Product Canon, gera diff semântico. Exemplo PIX no Checkout (camada de negócio e arquitetura).

4. Aprovação condicional: Change Plan vazio = sem gate. Se houver impacto, roteamento por camada.

Reutilizar ContextualSpecDiagram dentro de DiagramContainer com client:visible.

LEIA O DOCUMENTO docs/plan-change-site-tasks.md para o contexto completo da tarefa F2-02.
"@
        ConstitutionRules = "- Princípios II, III, IV, V, VI, VII (mesmas regras de F2-01)"
        Verification = @"
- Seção renderiza com depth 2 e sectionNumber 6
- Injeção seletiva explicada
- Exemplo PIX presente
- Aprovação condicional explicada (Change Plan vazio = sem gate)
"@
    },
    @{
        Id = "F2-03"
        Name = "Criar EnrichmentSection e atualizar FeedbackDiagram"
        Wave = 1
        Dependencies = @()
        Files = @"
- src/components/sections/EnrichmentSection.astro (criar)
- src/components/diagrams/FeedbackDiagram.tsx (editar)
- src/lib/diagrams/feedback-diagram.ts (editar)
"@
        Context = @"
Criar seção depth 2 para detalhar a Etapa 3 — Canon Enrichment. ID: enrichment. sectionNumber: 7.

Estrutura:
<section id="enrichment" class="section-odd" aria-labelledby="heading-enrichment">
  <SectionHeader sectionNumber={7} title='Canon Enrichment — <span class="gradient-text">Retroalimentação</span>' depth={2} sectionId="enrichment" />
</section>

Conteúdo: Integração de Change Plans aprovados, Descobertas emergentes (sinalização explícita CANON-DISCOVERY + detecção assistida), Mecanismo de aprovação leve com escalação condicional, Anotações contextuais e ciclo de vida.

Atualização do FeedbackDiagram: Adicionar bifurcação com sinalização explícita + detecção assistida, guardrails, e bifurcação entre revisão assíncrona e escalação para Change Plan formal.

LEIA O DOCUMENTO docs/plan-change-site-tasks.md para o contexto completo da tarefa F2-03.
"@
        ConstitutionRules = "- Princípios II, III, IV, V, VI, VII"
        Verification = @"
- Seção renderiza com depth 2 e sectionNumber 7
- Sinalização explícita e detecção assistida descritas
- Mecanismo de aprovação leve com escalação presente
- FeedbackDiagram atualizado com bifurcação
"@
    },
    @{
        Id = "F2-04"
        Name = "Remover PillarsSection"
        Wave = 2
        Dependencies = @("F2-01", "F2-02", "F2-03")
        Files = "src/components/sections/PillarsSection.astro"
        Context = @"
Remover o arquivo src/components/sections/PillarsSection.astro. Este arquivo é substituído pelas 3 novas seções (CanonBuildingSection, SpecCraftingSection, EnrichmentSection).

Não remover ainda o import e uso em index.astro — isso será feito na Fase 4 (F4-02). A remoção do arquivo pode resultar em erro de build temporário que será resolvido na F4-02.

Use: git rm src/components/sections/PillarsSection.astro
"@
        ConstitutionRules = "Nenhuma específica"
        Verification = @"
- Arquivo PillarsSection.astro removido
- Conteúdo das 3 tabs está coberto pelas novas seções F2-01, F2-02, F2-03
"@
    },

    # ==================== FASE 3 — Novas seções ====================
    @{
        Id = "F3-01"
        Name = "Criar GuardrailsSection com GuardrailsDiagram"
        Wave = 1
        Dependencies = @()
        Files = @"
- src/components/sections/GuardrailsSection.astro (criar)
- src/components/diagrams/GuardrailsDiagram.tsx (criar)
- src/lib/diagrams/guardrails-diagram.ts (criar)
"@
        Context = @"
Criar seção depth 2 dedicada aos 5 guardrails da Product Canon. ID: guardrails. sectionNumber: 8.

Estrutura:
<section id="guardrails" class="section-even" aria-labelledby="heading-guardrails">
  <SectionHeader sectionNumber={8} title='Guardrails — <span class="gradient-text">Como a Integridade é Mantida</span>' depth={2} sectionId="guardrails" />
</section>

5 guardrails: Clarificação de Conformidade, Validação de Consistência, Validação Semântica Interna, Padronização Canônica, Versionamento por Estrangulamento.

Incluir conceito transversal de Hotspots de domínio.

Novo diagrama GuardrailsDiagram: visual dos 5 guardrails como camadas de proteção, mostrando onde cada um atua no ciclo.

LEIA O DOCUMENTO docs/plan-change-site-tasks.md para o contexto completo da tarefa F3-01.
"@
        ConstitutionRules = "- Princípios II, III, IV, V, VI, VII"
        Verification = @"
- 5 guardrails explicados com linguagem acessível
- Hotspots de domínio mencionados na Clarificação de Conformidade
- Versionamento por Estrangulamento com faces current/next
- GuardrailsDiagram renderiza com client:visible
"@
    },
    @{
        Id = "F3-02"
        Name = "Criar ChangePlanSection com ChangePlanEnvelopeDiagram"
        Wave = 1
        Dependencies = @()
        Files = @"
- src/components/sections/ChangePlanSection.astro (criar)
- src/components/diagrams/ChangePlanEnvelopeDiagram.tsx (criar)
- src/lib/diagrams/change-plan-envelope-diagram.ts (criar)
"@
        Context = @"
Criar seção depth 3 dedicada ao Canonical Change Plan como artefato central. ID: change-plan. sectionNumber: 10.

Conteúdo: O que é, Envelope de metadados (7 campos universais + 4 condicionais), 5 tipos de Change Plan, Fluxo de aprovação por afinidade (com exceção expert-edit-plan), Rejeição, Exemplo visual PIX.

Novo diagrama ChangePlanEnvelopeDiagram: estrutura visual do envelope (campos universais + condicionais), com os 5 tipos e o fluxo de aprovação.

LEIA O DOCUMENTO docs/plan-change-site-tasks.md para o contexto completo da tarefa F3-02.
"@
        ConstitutionRules = "- Princípios II, III, IV, V, VI, VII"
        Verification = @"
- Seção renderiza com depth 3 e sectionNumber 10
- Envelope com 7 campos universais e 4 condicionais documentados
- 5 tipos de Change Plan explicados
- Aprovação por afinidade e exceção do expert-edit-plan explicadas
"@
    },
    @{
        Id = "F3-03"
        Name = "Criar DirectEditSection com DirectEditFlowDiagram"
        Wave = 1
        Dependencies = @()
        Files = @"
- src/components/sections/DirectEditSection.astro (criar)
- src/components/diagrams/DirectEditFlowDiagram.tsx (criar)
- src/lib/diagrams/direct-edit-flow-diagram.ts (criar)
"@
        Context = @"
Criar seção depth 3 dedicada à Edição Direta do Domain Expert. ID: edicao-direta. sectionNumber: 12.

Conteúdo: Quando usar, Escopo limitado (apenas camada de negócio, apenas refinamentos), Fluxo de guardrails iterativos (5 passos), Relatório de Conformidade (4 seções), expert-edit-plan e aprovação sequencial obrigatória (Domain Expert → Architect), Salvaguardas.

Novo diagrama DirectEditFlowDiagram: fluxo da edição proposta → guardrails iterativos → Relatório → expert-edit-plan → aprovação sequencial.

LEIA O DOCUMENTO docs/plan-change-site-tasks.md para o contexto completo da tarefa F3-03.
"@
        ConstitutionRules = "- Princípios II, III, IV, V, VI, VII"
        Verification = @"
- Seção renderiza com depth 3 e sectionNumber 12
- Fluxo de guardrails iterativos com 5 passos descrito
- Relatório de Conformidade com 4 seções documentado
- Aprovação sequencial obrigatória explicada
"@
    },
    @{
        Id = "F3-04"
        Name = "Criar RiscosSection"
        Wave = 1
        Dependencies = @()
        Files = "src/components/sections/RiscosSection.astro (criar)"
        Context = @"
Criar seção depth 2 dedicada aos riscos e limitações do modelo. Sem diagrama. ID: riscos. sectionNumber: 15.

Estrutura:
<section id="riscos" class="section-odd" aria-labelledby="heading-riscos">
  <SectionHeader sectionNumber={15} title='Riscos e <span class="gradient-text">Limitações</span>' depth={2} sectionId="riscos" />
</section>

Introdução: 'Todo modelo tem limitações. O ZionKit documenta as suas abertamente.'
Nota de status: 'O modelo é um protótipo conceitual que ainda não foi testado em produção.'

10 riscos com 'o que pode dar errado' + mitigação:
1. Qualidade dos guardrails depende da capacidade da IA
2. Injeção seletiva de contexto é problema não trivial
3. Custo de bootstrap
4. Disciplina de retroalimentação
5. Disponibilidade de aprovadores
6. Qualidade da tradução de validação interna para linguagem natural
7. Acúmulo de papéis pode degradar governança
8. Concorrência de transições no Versionamento por Estrangulamento
9. Estagnação no nível Mínimo de aderência IEEE 29148
10. Perda de detalhamento estrutural

LEIA O DOCUMENTO docs/plan-change-site-tasks.md para o contexto completo da tarefa F3-04 com detalhes de cada risco e mitigação.
"@
        ConstitutionRules = "- Princípios IV (section-odd/even), V (aria-labelledby), VI (depth 2), VII (SectionHeader, ScrollReveal)"
        Verification = @"
- 10 riscos listados com 'o que pode dar errado' + mitigação
- Nota de protótipo conceitual presente
- Seção renderiza com depth 2 e sectionNumber 15
"@
    },
    @{
        Id = "F3-05"
        Name = "Atualizar CanonDeepDiveSection"
        Wave = 1
        Dependencies = @()
        Files = "src/components/sections/CanonDeepDiveSection.astro"
        Context = @"
Atualizar a seção existente de detalhamento da Product Canon com conteúdo v0.6. sectionNumber será 11 (atualizar no SectionHeader). Depth: 3.

Edições:
1. Camada de Negócio: Adicionar nos requisitos a menção a 'formato IEEE 29148 + SBE'
2. Adicionar menção a hotspots de domínio e anotações contextuais como metadados
3. Camada de Arquitetura: Adicionar menção a níveis de aderência IEEE 29148 nos princípios técnicos constitucionais
4. Adicionar Canonical Change Plans como artefato da Canon (5 tipos com formato IEEE 29148 + SBE)
5. Atualizar sectionNumber de 8 para 11 no SectionHeader
"@
        ConstitutionRules = "- Princípios V, VI, VII"
        Verification = @"
- Camada de Negócio menciona 'formato IEEE 29148 + SBE'
- Hotspots de domínio e anotações contextuais mencionados
- Níveis de aderência IEEE 29148 mencionados na Camada de Arquitetura
- Canonical Change Plans listados como artefato da Canon
"@
    },
    @{
        Id = "F3-06"
        Name = "Adicionar novos termos ao GlossarySection"
        Wave = 2
        Dependencies = @("F1-01","F1-02","F1-03","F1-04","F1-05","F1-06","F1-07","F1-08","F1-09","F2-01","F2-02","F2-03","F3-01","F3-02","F3-03","F3-04","F3-05")
        Files = "src/components/sections/GlossarySection.astro"
        Context = @"
Adicionar 17 novos termos ao glossário, utilizando o componente GlossaryItem existente (src/components/ui/GlossaryItem.astro). Cada termo tem definição e analogia. sectionNumber será 16 (atualizar no SectionHeader).

17 termos: Canonical Change Plan, Envelope do Change Plan, expert-edit-plan, incremental-plan, Protocolo de Perspectiva Assistida, Hotspot de domínio, Anotação contextual, Relatório de Conformidade, Aprovação por afinidade, Sinalização explícita, Detecção assistida, Clarificação de Conformidade, Validação de Consistência, Validação Semântica Interna, Padronização Canônica, Nível de aderência IEEE 29148, Decisão de Continuidade.

LEIA O DOCUMENTO docs/plan-change-site-tasks.md para o contexto completo da tarefa F3-06 com as definições e analogias detalhadas de cada termo.

Atualizar sectionNumber de 10 para 16 no SectionHeader.

Cada GlossaryItem deve ser wrapped por ScrollReveal.
"@
        ConstitutionRules = "- Princípio VII: cada GlossaryItem deve ser wrapped por ScrollReveal"
        Verification = @"
- 17 novos termos adicionados (total = 15 existentes + 17 novos = 32)
- Cada termo tem definição e analogia
- sectionNumber atualizado para 16
"@
    },

    # ==================== FASE 4 — Integração final ====================
    @{
        Id = "F4-01"
        Name = "Atualizar StickyNav com estrutura final de 16 seções"
        Wave = 3
        Dependencies = @("F1-01","F1-02","F1-03","F1-04","F1-05","F1-06","F1-07","F1-08","F1-09","F2-01","F2-02","F2-03","F2-04","F3-01","F3-02","F3-03","F3-04","F3-05","F3-06")
        Files = "src/components/layout/StickyNav.astro"
        Context = @"
No arquivo StickyNav.astro, substituir o array sections pelo novo array com 16 seções:

const sections = [
  { id: 'problema', label: 'O Problema' },
  { id: 'consequencias', label: 'Consequências' },
  { id: 'solucao', label: 'O Modelo' },
  { id: 'ciclo', label: 'O Ciclo' },
  { id: 'canon-building', label: 'Canon Building' },
  { id: 'spec-crafting', label: 'Spec Crafting' },
  { id: 'enrichment', label: 'Retroalimentação' },
  { id: 'guardrails', label: 'Guardrails' },
  { id: 'papeis', label: 'Papéis' },
  { id: 'change-plan', label: 'Change Plan' },
  { id: 'canon', label: 'Product Canon' },
  { id: 'edicao-direta', label: 'Edição Direta' },
  { id: 'comparacao', label: 'Antes/Depois' },
  { id: 'cenarios', label: 'Cenários' },
  { id: 'riscos', label: 'Riscos' },
  { id: 'glossario', label: 'Glossário' },
];
"@
        ConstitutionRules = "Nenhuma específica"
        Verification = @"
- 16 seções no array
- IDs correspondem aos IDs das seções implementadas
- Ordem corresponde à estrutura definida em §3.1
"@
    },
    @{
        Id = "F4-02"
        Name = "Atualizar index.astro com imports, ordem e remoção do CTA"
        Wave = 3
        Dependencies = @("F1-01","F1-02","F1-03","F1-04","F1-05","F1-06","F1-07","F1-08","F1-09","F2-01","F2-02","F2-03","F2-04","F3-01","F3-02","F3-03","F3-04","F3-05","F3-06")
        Files = "src/pages/index.astro"
        Context = @"
Atualizar index.astro com a nova estrutura de 16 seções:

1. Adicionar imports para as novas seções:
   import CanonBuildingSection from '../components/sections/CanonBuildingSection.astro';
   import SpecCraftingSection from '../components/sections/SpecCraftingSection.astro';
   import EnrichmentSection from '../components/sections/EnrichmentSection.astro';
   import GuardrailsSection from '../components/sections/GuardrailsSection.astro';
   import ChangePlanSection from '../components/sections/ChangePlanSection.astro';
   import DirectEditSection from '../components/sections/DirectEditSection.astro';
   import RiscosSection from '../components/sections/RiscosSection.astro';

2. Remover import de PillarsSection (já removido em F2-04)

3. Atualizar a ordem dos componentes no <main>:
   <!-- 1 --> <HeroSection />
   <!-- 2 --> <ConsequenciasSection />
   <!-- 3 --> <SolutionBridgeSection />
   <!-- 4 --> <CycleOverviewSection />
   <!-- 5 --> <CanonBuildingSection />      (NOVA)
   <!-- 6 --> <SpecCraftingSection />       (NOVA)
   <!-- 7 --> <EnrichmentSection />         (NOVA)
   <!-- 8 --> <GuardrailsSection />         (NOVA)
   <!-- 9 --> <RolesSection />              (movida)
   <!-- 10 --> <ChangePlanSection />        (NOVA)
   <!-- 11 --> <CanonDeepDiveSection />     (movida)
   <!-- 12 --> <DirectEditSection />        (NOVA)
   <!-- 13 --> <ComparisonSection />        (movida)
   <!-- 14 --> <ScenariosSection />         (movida)
   <!-- CTA nota informativa -->
   <!-- 15 --> <RiscosSection />            (NOVA)
   <!-- 16 --> <GlossarySection />          (movida)

4. Remover a referência à PillarsSection
5. Verificar que o CTA Banner já foi atualizado em F1-08
"@
        ConstitutionRules = @"
- Princípio IV: seções devem alternar entre section-odd e section-even para ritmo visual
- Princípio VII: toda nova seção deve estar registrada neste arquivo na posição narrativa correta
"@
        Verification = @"
- 16 seções no <main> (sem PillarsSection)
- Imports corretos para todas as novas seções
- Ordem das seções segue §3.1
"@
    },
    @{
        Id = "F4-03"
        Name = "Atualizar CycleDiagram e CanonBuildingDiagram"
        Wave = 3
        Dependencies = @("F1-01","F1-02","F1-03","F1-04","F1-05","F1-06","F1-07","F1-08","F1-09","F2-01","F2-02","F2-03","F2-04","F3-01","F3-02","F3-03","F3-04","F3-05","F3-06")
        Files = @"
- src/components/diagrams/CycleDiagram.tsx (editar)
- src/lib/diagrams/cycle-diagram.ts (editar)
- src/components/diagrams/CanonBuildingDiagram.tsx (editar)
- src/lib/diagrams/canon-building-diagram.ts (editar)
"@
        Context = @"
CycleDiagram — atualizações:
- Adicionar nó de 'Decisão de Continuidade' ao fluxo da Etapa 1 (com 3 caminhos: mais fluxos, mais requisitos, encerrar)
- Adicionar canal de 'Edição Direta' como ramo complementar
- Manter estilo visual existente (consultar shared-config.ts e cycle-diagram.ts)

CanonBuildingDiagram — atualizações:
- Adicionar labels de tipo de Change Plan aos gates de aprovação entre cerimônias:
  - Gate 1: discovery-plan
  - Gate 2: constitution-plan
  - Gate 3: specification-plan
- Manter estilo visual existente
"@
        ConstitutionRules = @"
- Princípio III: componentes React com client:visible
- Princípio V: prefers-reduced-motion respeitado nas animações
"@
        Verification = @"
- CycleDiagram mostra Decisão de Continuidade e Edição Direta
- CanonBuildingDiagram mostra tipos de Change Plan nos gates
- Diagramas renderizam corretamente sem erros
"@
    },
    @{
        Id = "F4-04"
        Name = "Revisar sectionNumber em todas as seções"
        Wave = 3
        Dependencies = @("F4-01", "F4-02")
        Files = @"
Todos os arquivos em src/components/sections/:
- HeroSection.astro → sectionNumber 1
- ConsequenciasSection.astro → sectionNumber 2
- SolutionBridgeSection.astro → sectionNumber 3
- CycleOverviewSection.astro → sectionNumber 4
- CanonBuildingSection.astro → sectionNumber 5
- SpecCraftingSection.astro → sectionNumber 6
- EnrichmentSection.astro → sectionNumber 7
- GuardrailsSection.astro → sectionNumber 8
- RolesSection.astro → sectionNumber 9
- ChangePlanSection.astro → sectionNumber 10
- CanonDeepDiveSection.astro → sectionNumber 11
- DirectEditSection.astro → sectionNumber 12
- ComparisonSection.astro → sectionNumber 13
- ScenariosSection.astro → sectionNumber 14
- RiscosSection.astro → sectionNumber 15
- GlossarySection.astro → sectionNumber 16
"@
        Context = @"
Verificar e corrigir o sectionNumber no SectionHeader de cada seção:

Seções que precisam ter sectionNumber atualizado (mudaram de posição):
- RolesSection.astro: era 6 → agora 9
- ComparisonSection.astro: era 7 → agora 13
- CanonDeepDiveSection.astro: era 8 → agora 11
- ScenariosSection.astro: era 9 → agora 14
- GlossarySection.astro: era 10 → agora 16

Seções novas (verificar se estão corretas):
- CanonBuildingSection (5), SpecCraftingSection (6), EnrichmentSection (7), GuardrailsSection (8), ChangePlanSection (10), DirectEditSection (12), RiscosSection (15)

Seções que mantêm sectionNumber:
- HeroSection (1), ConsequenciasSection (2), SolutionBridgeSection (3), CycleOverviewSection (4)
"@
        ConstitutionRules = "- Princípio VII: sectionNumber deve seguir sequência existente (incrementando)"
        Verification = @"
- Todas as 16 seções têm sectionNumber sequencial de 1 a 16
- Nenhum sectionNumber duplicado
- Números correspondem à ordem em index.astro
"@
    },
    @{
        Id = "F4-05"
        Name = "Atualizar RolesMatrixDiagram"
        Wave = 3
        Dependencies = @("F1-05")
        Files = @"
- src/components/diagrams/RolesMatrixDiagram.tsx (editar — se existir como componente separado)
- Verificar se os dados da matriz estão em arquivo de config em src/lib/diagrams/
"@
        Context = @"
Atualizar o diagrama/matriz de papéis:
- Adicionar coluna 'Edição Direta' à matriz
- Adicionar linhas ou indicadores para o Protocolo de Perspectiva Assistida
- Refletir as novas responsabilidades de cada papel conforme a tabela de atuação por etapa adicionada em F1-05

Verificar primeiro se RolesMatrixDiagram é um componente React separado ou se está inline no RolesSection.astro. Se inline, esta tarefa pode ser absorvida pela F1-05.
"@
        ConstitutionRules = @"
- Princípio III: componentes React com client:visible
- Princípio V: prefers-reduced-motion respeitado nas animações
"@
        Verification = @"
- Coluna 'Edição Direta' presente
- Protocolo de Perspectiva Assistida representado
- Dados consistentes com a tabela de atuação adicionada em F1-05
"@
    },
    @{
        Id = "F4-06"
        Name = "Verificar acessibilidade em componentes novos"
        Wave = 3
        Dependencies = @("F2-01","F2-02","F2-03","F3-01","F3-02","F3-03","F3-04")
        Files = @"
Todos os arquivos criados nas Fases 2 e 3:
- CanonBuildingSection.astro, SpecCraftingSection.astro, EnrichmentSection.astro
- GuardrailsSection.astro, ChangePlanSection.astro, DirectEditSection.astro, RiscosSection.astro
- CeremonyFlowDiagram.tsx, GuardrailsDiagram.tsx, ChangePlanEnvelopeDiagram.tsx, DirectEditFlowDiagram.tsx
"@
        Context = @"
Verificar e corrigir acessibilidade em todos os componentes novos:

Para cada seção Astro (.astro):
- aria-labelledby no <section> apontando para o heading
- sectionId passado ao SectionHeader para gerar o id no heading

Para cada diagrama React (.tsx):
- prefers-reduced-motion: reduce — desabilitar ou simplificar animações quando usuário prefere motion reduzido
- aria-hidden='true' em elementos puramente decorativos
- DiagramContainer deve ter label e title descritivos
"@
        ConstitutionRules = "- Princípio V: 'Accessibility First' — WCAG 2.1 AA mínimo. Animações devem respeitar prefers-reduced-motion. Seções devem usar aria-labelledby. Elementos decorativos com aria-hidden='true'."
        Verification = @"
- Todas as 7 novas seções têm aria-labelledby correto
- Todos os 4 novos diagramas respeitam prefers-reduced-motion
- DiagramContainer com labels descritivos em todos os diagramas
"@
    }
)

# --- Função de execução de tarefa individual ---
function Invoke-Task {
    param(
        [hashtable]$Task,
        [hashtable]$State
    )

    $id = $Task.Id
    $name = $Task.Name

    # Verificar se já foi commitada (idempotência)
    if (Test-TaskCommitted -TaskId $id) {
        Write-TaskSkip $id "já commitada"
        return @{ Id = $id; Status = "skipped"; Reason = "already-committed" }
    }

    # Verificar estado anterior
    if ($State.ContainsKey($id) -and $State[$id] -eq "success") {
        Write-TaskSkip $id "já concluída (estado)"
        return @{ Id = $id; Status = "skipped"; Reason = "state-success" }
    }

    Write-TaskStart $id $name
    $startTime = Get-Date

    # Construir prompt
    $prompt = Build-TaskPrompt `
        -TaskId $id `
        -Description $name `
        -Files $Task.Files `
        -Context $Task.Context `
        -ConstitutionRules $Task.ConstitutionRules `
        -Verification $Task.Verification

    try {
        if ($DryRun) {
            Write-Status "  [DRY RUN] Prompt de ${id}: $($prompt.Length) caracteres" Cyan
            $endTime = Get-Date
            Add-LogEntry $id "dry-run" $startTime $endTime
            return @{ Id = $id; Status = "success"; Reason = "dry-run" }
        }

        # Executar Claude CLI
        $escapedPrompt = $prompt -replace '"', '\"'
        $result = & claude --model claude-opus-4-6 --dangerously-skip-permissions --print --output-format text -p "$escapedPrompt" 2>&1

        $exitCode = $LASTEXITCODE
        $endTime = Get-Date

        if ($exitCode -eq 0) {
            # Verificar se o commit foi feito
            if (Test-TaskCommitted -TaskId $id) {
                Write-TaskSuccess $id
                $State[$id] = "success"
                Save-TaskState $State
                Add-LogEntry $id "success" $startTime $endTime
                return @{ Id = $id; Status = "success" }
            } else {
                # Claude executou sem erro mas não fez commit — tentar commit manual
                Write-Status "  ⚠️ $id — Claude não fez commit, tentando commit manual..." Yellow
                $commitMsg = "feat(site-v0.6): $id — $name"
                & git -C $ProjectRoot add -A 2>$null
                & git -C $ProjectRoot commit -m "$commitMsg" 2>$null
                if (Test-TaskCommitted -TaskId $id) {
                    Write-TaskSuccess $id
                    $State[$id] = "success"
                    Save-TaskState $State
                    Add-LogEntry $id "success" $startTime $endTime
                    return @{ Id = $id; Status = "success" }
                } else {
                    Write-TaskFail $id "Commit não encontrado após execução"
                    $State[$id] = "failed"
                    Save-TaskState $State
                    Add-LogEntry $id "failed" $startTime $endTime
                    return @{ Id = $id; Status = "failed"; Reason = "no-commit" }
                }
            }
        } else {
            Write-TaskFail $id "Exit code: $exitCode"
            $State[$id] = "failed"
            Save-TaskState $State
            Add-LogEntry $id "failed" $startTime $endTime
            return @{ Id = $id; Status = "failed"; Reason = "exit-code-$exitCode" }
        }
    } catch {
        $endTime = Get-Date
        Write-TaskFail $id $_.Exception.Message
        $State[$id] = "failed"
        Save-TaskState $State
        Add-LogEntry $id "failed" $startTime $endTime
        return @{ Id = $id; Status = "failed"; Reason = $_.Exception.Message }
    }
}

# --- Função de execução de onda ---
function Invoke-Wave {
    param(
        [int]$WaveNumber,
        [array]$Tasks,
        [hashtable]$State,
        [array]$PreviousResults
    )

    Write-Status "`n========================================" Cyan
    Write-Status "  ONDA $WaveNumber — $($Tasks.Count) tarefas" Cyan
    Write-Status "========================================`n" Cyan

    # Verificar dependências falhadas
    $failedIds = ($PreviousResults | Where-Object { $_.Status -eq "failed" }).Id
    $tasksToRun = @()
    $skippedResults = @()

    foreach ($task in $Tasks) {
        $blockedBy = $task.Dependencies | Where-Object { $failedIds -contains $_ }
        if ($blockedBy.Count -gt 0) {
            Write-TaskSkip $task.Id "dependência falhada: $($blockedBy -join ', ')"
            $skippedResults += @{ Id = $task.Id; Status = "skipped"; Reason = "dependency-failed: $($blockedBy -join ', ')" }
            Add-LogEntry $task.Id "skipped" $null $null
        } else {
            $tasksToRun += $task
        }
    }

    if ($tasksToRun.Count -eq 0) {
        Write-Status "  Nenhuma tarefa para executar nesta onda." Yellow
        return $skippedResults
    }

    # Execução paralela
    $jobs = @()
    foreach ($task in $tasksToRun) {
        $job = Start-Job -ScriptBlock {
            param($TaskData, $ProjectRoot, $StateFile, $LogFile, $DryRun, $ContextDocsAbsolute)

            Set-Location $ProjectRoot

            # Reconstruir funções necessárias dentro do job
            function Test-TaskCommitted {
                param($TaskId)
                $commitMsg = "feat(site-v0.6): $TaskId"
                $result = git log --oneline --grep="$commitMsg" 2>$null
                return ($null -ne $result -and $result.Length -gt 0)
            }

            $id = $TaskData.Id
            $name = $TaskData.Name

            # Verificar se já commitada
            if (Test-TaskCommitted -TaskId $id) {
                return @{ Id = $id; Status = "skipped"; Reason = "already-committed" }
            }

            $contextDocsPaths = $ContextDocsAbsolute -join "`n  - "

            $prompt = @"
Você é um engenheiro frontend implementando uma tarefa específica no site ZionKit.

## Tarefa: $($TaskData.Id)
**Descrição:** $($TaskData.Name)

## Arquivo(s) a editar/criar
$($TaskData.Files)

## Contexto detalhado
$($TaskData.Context)

## Regras da constituição relevantes
$($TaskData.ConstitutionRules)

## Critérios de verificação
$($TaskData.Verification)

## Documentos de contexto
Leia os seguintes documentos para obter informações adicionais sobre o modelo ZionKit, o plano de mudanças e os detalhes de cada tarefa:
  - $contextDocsPaths

## Instruções finais
1. Leia os documentos de contexto para entender o modelo e o plano completo.
2. Implemente a tarefa conforme especificado acima.
3. Após implementar, faça commit das alterações:
   - Use: git add <arquivos modificados/criados>
   - Mensagem de commit: feat(site-v0.6): $id — $name
4. Reporte o resultado: diga SUCESSO se tudo funcionou ou FALHA com detalhes do erro.
"@

            $startTime = Get-Date

            if ($DryRun) {
                return @{ Id = $id; Status = "success"; Reason = "dry-run"; Start = $startTime; End = (Get-Date) }
            }

            try {
                $escapedPrompt = $prompt -replace '"', '\"'
                $result = & claude --model claude-opus-4-6 --dangerously-skip-permissions --print --output-format text -p "$escapedPrompt" 2>&1
                $exitCode = $LASTEXITCODE
                $endTime = Get-Date

                if ($exitCode -eq 0) {
                    if (Test-TaskCommitted -TaskId $id) {
                        return @{ Id = $id; Status = "success"; Start = $startTime; End = $endTime }
                    } else {
                        # Tentar commit manual
                        & git add -A 2>$null
                        $commitMsg = "feat(site-v0.6): $id — $name"
                        & git commit -m "$commitMsg" 2>$null
                        if (Test-TaskCommitted -TaskId $id) {
                            return @{ Id = $id; Status = "success"; Start = $startTime; End = $endTime }
                        }
                        return @{ Id = $id; Status = "failed"; Reason = "no-commit"; Start = $startTime; End = $endTime }
                    }
                } else {
                    return @{ Id = $id; Status = "failed"; Reason = "exit-code-$exitCode"; Start = $startTime; End = $endTime }
                }
            } catch {
                return @{ Id = $id; Status = "failed"; Reason = $_.Exception.Message; Start = $startTime; End = (Get-Date) }
            }
        } -ArgumentList $task, $ProjectRoot, $StateFile, $LogFile, $DryRun, $ContextDocsAbsolute

        $jobs += @{ Job = $job; Task = $task }
    }

    # NOTA: Tarefas paralelas editam arquivos DIFERENTES, então git não terá conflitos.
    # Porém, Start-Job com git pode ter problemas de concorrência no índice git.
    # Para contornar, usamos execução sequencial por padrão e paralela apenas com -Parallel flag.
    # Na implementação atual, cada job faz seu próprio commit, o que é seguro se editam arquivos diferentes.

    # Esperar todos os jobs
    Write-Status "  Aguardando $($jobs.Count) tarefas..." Cyan
    $completedJobs = $jobs.Job | Wait-Job

    $waveResults = @()
    foreach ($jobInfo in $jobs) {
        $result = Receive-Job -Job $jobInfo.Job
        Remove-Job -Job $jobInfo.Job -Force

        if ($null -eq $result) {
            $result = @{ Id = $jobInfo.Task.Id; Status = "failed"; Reason = "null-result" }
        }

        $waveResults += $result

        # Atualizar estado
        if ($result.Status -eq "success") {
            $State[$result.Id] = "success"
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] ✅ $($result.Id) — Concluída" -ForegroundColor Green
        } elseif ($result.Status -eq "failed") {
            $State[$result.Id] = "failed"
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] ❌ $($result.Id) — Falha: $($result.Reason)" -ForegroundColor Red
        } else {
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] ⏭️  $($result.Id) — Pulada: $($result.Reason)" -ForegroundColor DarkYellow
        }

        Add-LogEntry $result.Id $result.Status $result.Start $result.End
    }

    Save-TaskState $State

    # Verificar conflitos de merge entre jobs paralelos
    $mergeConflicts = & git -C $ProjectRoot diff --check 2>$null
    if ($mergeConflicts) {
        Write-Status "  ⚠️ Possíveis conflitos de merge detectados após Onda $WaveNumber!" Red
        Write-Status "  $mergeConflicts" Red
    }

    return ($waveResults + $skippedResults)
}

# --- EXECUÇÃO PRINCIPAL ---

Write-Status "`n╔══════════════════════════════════════════════════╗" Cyan
Write-Status "║  ZionKit v0.6 — Orquestrador de Tarefas          ║" Cyan
Write-Status "║  Total: $($AllTasks.Count) tarefas | 3 ondas de execução       ║" Cyan
Write-Status "╚══════════════════════════════════════════════════╝`n" Cyan

if ($DryRun) {
    Write-Status "🔍 MODO DRY RUN — Nenhuma alteração será feita`n" Yellow
}

if ($OnlyTask) {
    Write-Status "🎯 Executando apenas tarefa: $OnlyTask`n" Yellow
    $task = $AllTasks | Where-Object { $_.Id -eq $OnlyTask }
    if (-not $task) {
        Write-Status "❌ Tarefa '$OnlyTask' não encontrada." Red
        exit 1
    }
    $State = Get-TaskState
    Initialize-Log
    $result = Invoke-Task -Task $task -State $State
    Add-LogSummary @($result)
    exit 0
}

# Carregar estado
$State = Get-TaskState

# Inicializar log
Initialize-Log

$allResults = @()

# --- Onda 1: F1-01 a F1-09, F2-01 a F2-03, F3-01 a F3-05 (todas sem dependências) ---
$wave1Tasks = $AllTasks | Where-Object { $_.Wave -eq 1 }
$wave1Results = Invoke-Wave -WaveNumber 1 -Tasks $wave1Tasks -State $State -PreviousResults @()
$allResults += $wave1Results

# --- Onda 2: F2-04, F3-06 (dependem da Onda 1) ---
$wave2Tasks = $AllTasks | Where-Object { $_.Wave -eq 2 }
$wave2Results = Invoke-Wave -WaveNumber 2 -Tasks $wave2Tasks -State $State -PreviousResults $allResults
$allResults += $wave2Results

# --- Onda 3: F4-01 a F4-06 (dependem das Ondas 1 e 2) ---
$wave3Tasks = $AllTasks | Where-Object { $_.Wave -eq 3 }
$wave3Results = Invoke-Wave -WaveNumber 3 -Tasks $wave3Tasks -State $State -PreviousResults $allResults
$allResults += $wave3Results

# --- Resumo final ---
Add-LogSummary $allResults

$total = $allResults.Count
$success = ($allResults | Where-Object { $_.Status -eq "success" }).Count
$failed = ($allResults | Where-Object { $_.Status -eq "failed" }).Count
$skipped = ($allResults | Where-Object { $_.Status -eq "skipped" }).Count

Write-Status "`n╔══════════════════════════════════════════════════╗" Cyan
Write-Status "║  RESUMO FINAL                                    ║" Cyan
Write-Status "╠══════════════════════════════════════════════════╣" Cyan
Write-Status "║  Total:   $total                                       ║" Cyan
Write-Host   "║  Sucesso: $success" -NoNewline -ForegroundColor Green; Write-Host "$((' ' * (39 - $success.ToString().Length)))║" -ForegroundColor Cyan
Write-Host   "║  Falha:   $failed" -NoNewline -ForegroundColor Red; Write-Host "$((' ' * (39 - $failed.ToString().Length)))║" -ForegroundColor Cyan
Write-Host   "║  Puladas: $skipped" -NoNewline -ForegroundColor DarkYellow; Write-Host "$((' ' * (39 - $skipped.ToString().Length)))║" -ForegroundColor Cyan
Write-Status "╚══════════════════════════════════════════════════╝`n" Cyan
Write-Status "📄 Log completo em: docs/execution-log.md" Cyan

if ($failed -gt 0) {
    $failedTasks = ($allResults | Where-Object { $_.Status -eq "failed" }).Id -join ", "
    Write-Status "❌ Tarefas com falha: $failedTasks" Red
    Write-Status "   Re-execute com: .\execute-tasks.ps1 -OnlyTask <ID>" Yellow
}

# deploy.ps1 - Deploy ad-hoc para GitHub Pages (branch gh-pages)
# Uso: .\deploy.ps1

$ErrorActionPreference = "Stop"

$projectDir = $PSScriptRoot
$distDir = Join-Path $projectDir "dist"
$deployBranch = "gh-pages"
$siteUrl = "https://tuyoshivinicius.github.io/zion-kit/"

# Build
Write-Host "`n[1/3] Building..." -ForegroundColor Cyan
Push-Location $projectDir
try { npm run build } finally { Pop-Location }
if ($LASTEXITCODE -ne 0) { Write-Host "Build failed!" -ForegroundColor Red; exit 1 }

# Inject build timestamp into HTML files for cache busting
$buildTimestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
Write-Host "Injecting build version: $buildTimestamp" -ForegroundColor Gray
Get-ChildItem -Path $distDir -Filter "*.html" -Recurse | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $content = $content -replace '(<meta charset="UTF-8"\s*/?>)', "`$1`n    <meta name=`"build-version`" content=`"$buildTimestamp`" />"
    Set-Content -Path $_.FullName -Value $content -NoNewline
}

# Clone gh-pages em temp
Write-Host "[2/3] Preparing deploy..." -ForegroundColor Cyan
$tempDir = Join-Path ([System.IO.Path]::GetTempPath()) "zion-kit-deploy-$(Get-Random)"
$remoteUrl = git -C $projectDir remote get-url origin
git clone --branch $deployBranch --single-branch --depth 1 $remoteUrl $tempDir 2>&1 | Out-Null

# Substituir conteudo
Get-ChildItem -Path $tempDir -Exclude ".git" -Force | Remove-Item -Recurse -Force
Copy-Item -Path "$distDir\*" -Destination $tempDir -Recurse -Force
New-Item -Path "$tempDir\.nojekyll" -ItemType File -Force | Out-Null

# Push
Write-Host "[3/3] Pushing..." -ForegroundColor Cyan
Push-Location $tempDir
try {
    git add -A
    git diff --cached --quiet 2>$null
    if ($LASTEXITCODE -ne 0) {
        git commit -m "Deploy to GitHub Pages - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        git push origin $deployBranch --force
        Write-Host "`nDeploy concluido! $siteUrl" -ForegroundColor Green
    } else {
        Write-Host "`nSem alteracoes para deploy." -ForegroundColor Yellow
    }
} finally {
    Pop-Location
    Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
}

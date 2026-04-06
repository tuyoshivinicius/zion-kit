# deploy.ps1 - Deploy ad-hoc do site para GitHub Pages
# Uso: .\deploy.ps1

$ErrorActionPreference = "Stop"

# Salvar branch atual
$currentBranch = git rev-parse --abbrev-ref HEAD

Write-Host "Building site..." -ForegroundColor Cyan
npm run build

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Deploying to GitHub Pages..." -ForegroundColor Cyan

# Copiar dist para pasta temporaria
$tempDir = Join-Path ([System.IO.Path]::GetTempPath()) "zion-kit-deploy-$(Get-Random)"
Copy-Item -Path "dist" -Destination $tempDir -Recurse

try {
    # Criar/resetar branch gh-pages como orfã
    git checkout --orphan gh-pages 2>$null
    if ($LASTEXITCODE -ne 0) {
        git checkout gh-pages
        git rm -rf .
    } else {
        git rm -rf .
    }

    # Copiar build output
    Copy-Item -Path "$tempDir\*" -Destination "." -Recurse -Force

    # Adicionar arquivo .nojekyll para evitar processamento Jekyll
    New-Item -Path ".nojekyll" -ItemType File -Force | Out-Null

    # Commit e push
    git add -A
    git commit -m "Deploy to GitHub Pages"
    git push origin gh-pages --force

    Write-Host "Deploy concluido com sucesso!" -ForegroundColor Green
    Write-Host "Site: https://tuyoshivinicius.github.io/zion-kit/" -ForegroundColor Green
}
finally {
    # Voltar para branch original
    git checkout $currentBranch 2>$null

    # Limpar temp
    if (Test-Path $tempDir) {
        Remove-Item -Path $tempDir -Recurse -Force
    }
}

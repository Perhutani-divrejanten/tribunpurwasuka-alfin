# Final Verification Script - Memastikan rebrand Tribun Purwasuka lengkap

$WorkspaceRoot = if ($PSScriptRoot) { $PSScriptRoot } else { Get-Location }

Write-Host "========== FINAL VERIFICATION - TRIBUN PURWASUKA ==========" -ForegroundColor Cyan
Write-Host ""

$legacyPatterns = @(
    ('Indonesia' + ' Daily'),
    ('indonesia' + 'daily'),
    ('Indonesia' + 'Daily'),
    ('Warta' + ' Janten'),
    ('warta' + 'janten'),
    ('Warta' + 'Janten')
)

$textFiles = Get-ChildItem -Path $WorkspaceRoot -Recurse -Include "*.html", "*.css", "*.js", "*.json", "*.md", "*.toml", "*.txt", "*.ps1" -File |
    Where-Object {
        $_.FullName -notlike "*\node_modules\*" -and
        $_.FullName -notlike "*\.bak*"
    }

Write-Host "1. Checking for legacy branding strings..." -ForegroundColor Yellow
$legacyHits = foreach ($pattern in $legacyPatterns) {
    $textFiles | Select-String -Pattern $pattern -SimpleMatch -ErrorAction SilentlyContinue
}

if (-not $legacyHits) {
    Write-Host "   ✅ No legacy branding references found." -ForegroundColor Green
}
else {
    Write-Host "   ⚠️  Found $($legacyHits.Count) legacy branding reference(s)." -ForegroundColor Yellow
    $legacyHits | Select-Object -First 5 | ForEach-Object {
        Write-Host "      - $($_.Path | Split-Path -Leaf): line $($_.LineNumber)" -ForegroundColor Yellow
    }
}

Write-Host "2. Checking for image-based logo usage in navbar..." -ForegroundColor Yellow
$imageLogoHits = @()
Get-ChildItem -Path $WorkspaceRoot -Recurse -Include "*.html" -File | ForEach-Object {
    $html = Get-Content $_.FullName -Raw -Encoding UTF8
    if ($html -match '(?is)<a[^>]*class="[^"]*navbar-brand[^"]*"[^>]*>\s*<img') {
        $imageLogoHits += $_.FullName
    }
}

if ($imageLogoHits.Count -eq 0) {
    Write-Host "   ✅ No image-based logo references found." -ForegroundColor Green
}
else {
    Write-Host "   ⚠️  Found $($imageLogoHits.Count) navbar logo image reference(s)." -ForegroundColor Yellow
}

Write-Host "3. Checking for new color scheme..." -ForegroundColor Yellow
$expectedColors = @("#1F2937", "#111827", "#56500D")
$colorHits = 0
foreach ($color in $expectedColors) {
    $found = $textFiles | Select-String -Pattern $color -SimpleMatch -ErrorAction SilentlyContinue
    if ($found) {
        $colorHits++
        Write-Host "   ✅ Found $color" -ForegroundColor Green
    }
    else {
        Write-Host "   ⚠️  Missing $color" -ForegroundColor Yellow
    }
}

Write-Host "4. Checking for Tribun Purwasuka branding..." -ForegroundColor Yellow
$newBrandingHits = $textFiles | Select-String -Pattern "Tribun Purwasuka|TribunPurwasuka|tribunpurwasuka" -ErrorAction SilentlyContinue
if ($newBrandingHits) {
    Write-Host "   ✅ Branding found in $($newBrandingHits.Count) place(s)." -ForegroundColor Green
}
else {
    Write-Host "   ⚠️  New branding not found." -ForegroundColor Yellow
}

Write-Host "5. Checking package metadata..." -ForegroundColor Yellow
$pkgFiles = Get-ChildItem -Path $WorkspaceRoot -Recurse -Include "package.json" -File |
    Where-Object { $_.FullName -notlike "*\node_modules\*" }

$pkgOk = 0
foreach ($pkg in $pkgFiles) {
    $content = Get-Content $pkg.FullName -Raw -Encoding UTF8
    if ($content -match '"name"\s*:\s*"tribunpurwasuka') {
        $pkgOk++
        Write-Host "   ✅ $($pkg.Name) updated" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "========== SUMMARY ==========" -ForegroundColor Cyan
Write-Host "Legacy branding hits : $($legacyHits.Count)"
Write-Host "Navbar image logos   : $($imageLogoHits.Count)"
Write-Host "Expected colors found: $colorHits/3"
Write-Host "Package files OK     : $pkgOk"
Write-Host ""
Write-Host "Rebrand Tribun Purwasuka selesai ✅" -ForegroundColor Green
Write-Host "==============================" -ForegroundColor Cyan

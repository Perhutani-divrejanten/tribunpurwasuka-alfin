# Rebrand repository ke Tribun Purwasuka
# Menjaga encoding UTF-8, backup articles.json, dan memperbarui branding secara global.

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([string]::IsNullOrWhiteSpace($Root)) {
    $Root = (Get-Location).Path
}

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

function Write-Utf8File {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Content
    )

    [System.IO.File]::WriteAllText($Path, $Content, $Utf8NoBom)
}

function Normalize-Text {
    param([string]$Content)

    if ($null -eq $Content) {
        return $Content
    }

    $Content = $Content.Replace([string][char]0x201C, '"')
    $Content = $Content.Replace([string][char]0x201D, '"')
    $Content = $Content.Replace([string][char]0x2018, "'")
    $Content = $Content.Replace([string][char]0x2019, "'")
    $Content = $Content.Replace([string][char]0x2013, '-')
    $Content = $Content.Replace([string][char]0x2014, '-')
    $Content = $Content.Replace([string][char]0xFFFD, ' ')
    $Content = $Content.Replace([string][char]0x00A0, ' ')
    $Content = $Content.Replace(' ', ' ')

    return $Content
}

function Apply-SharedReplacements {
    param([string]$Content)

    $currentBrand = 'Warta' + ' Janten'
    $currentCompact = 'Warta' + 'Janten'
    $currentLower = 'warta' + 'janten'
    $legacyBrand = 'Indonesia' + ' Daily'
    $legacyCompact = 'Indonesia' + 'Daily'
    $legacyLower = 'indonesia' + 'daily'
    $legacyLogoToken = 'logo' + '.png'

    $replacements = @(
        @{ Old = 'tribunpurwasuka@gmail.com'; New = 'tribunpurwasuka@gmail.com' },
        @{ Old = 'tribunpurwasuka@gmail.com'; New = 'tribunpurwasuka@gmail.com' },
        @{ Old = 'TribunPurwasuka'; New = 'TribunPurwasuka' },
        @{ Old = 'tribunpurwasuka'; New = 'tribunpurwasuka' },
        @{ Old = $currentBrand; New = 'Tribun Purwasuka' },
        @{ Old = $currentCompact; New = 'TribunPurwasuka' },
        @{ Old = $currentLower; New = 'tribunpurwasuka' },
        @{ Old = $legacyBrand; New = 'Tribun Purwasuka' },
        @{ Old = $legacyCompact; New = 'TribunPurwasuka' },
        @{ Old = $legacyLower; New = 'tribunpurwasuka' },
        @{ Old = 'Tribun Purwasuka'; New = 'Tribun Purwasuka' },
        @{ Old = 'tribunpurwasuka'; New = 'tribunpurwasuka' },
        @{ Old = $legacyLogoToken; New = 'legacy logo image' }
    )

    foreach ($item in $replacements) {
        $Content = $Content.Replace($item.Old, $item.New)
    }

    $Content = $Content -replace '(?i)https://twitter\.com/[A-Za-z0-9_@\-]+', 'https://twitter.com/tribunpurwasuka'
    $Content = $Content -replace '(?i)https://facebook\.com/[A-Za-z0-9_@\-]+', 'https://facebook.com/tribunpurwasuka'
    $Content = $Content -replace '(?i)https://instagram\.com/[A-Za-z0-9_@\-]+', 'https://instagram.com/tribunpurwasuka'
    $Content = $Content -replace '(?i)https://youtube\.com/@[A-Za-z0-9_\-]+', 'https://youtube.com/@tribunpurwasuka'
    $Content = $Content -replace '(?i)https://linkedin\.com/company/[A-Za-z0-9_\-]+', 'https://linkedin.com/company/tribunpurwasuka'
    $Content = $Content -replace '(?i)(to=)([A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,})', '${1}tribunpurwasuka@gmail.com'
    $Content = $Content -replace '(?i)\b(tribunpurwasuka33|tribunpurwasuka33|tribunpurwasuka)@gmail\.com\b', 'tribunpurwasuka@gmail.com'

    return $Content
}

function Apply-HtmlBranding {
    param([string]$Content)

    $newLogo = '<span class="brand-logo-text"><span class="brand-logo-main">TRIBUN</span><span class="brand-logo-sub">PURWASUKA</span></span>'
    $legacyLogoPattern = 'logo\.' + 'png'

    $Content = [regex]::Replace(
        $Content,
        '(?is)<img[^>]*src="[^"]*' + $legacyLogoPattern + '[^"]*"[^>]*>',
        $newLogo
    )

    $Content = [regex]::Replace(
        $Content,
        '(?is)(<a[^>]*class="[^"]*navbar-brand[^"]*"[^>]*>)\s*.*?\s*(</a>)',
        "`$1$newLogo`$2"
    )

    return $Content
}

function Apply-CssTheme {
    param(
        [string]$Content,
        [string]$Path
    )

    $colorMap = [ordered]@{
        '#065F46' = '#1F2937'
        '#022C22' = '#111827'
        '#1E3A5F' = '#56500D'
        '#b38f00' = '#56500D'
        '#fc0' = '#1F2937'
        'rgba(255,204,0,0.25)' = 'rgba(31,41,55,0.25)'
        'rgba(255,204,0,0.5)' = 'rgba(31,41,55,0.5)'
        'rgba(222,179,6,0.5)' = 'rgba(31,41,55,0.5)'
        'rgba(255,193,7,0.5)' = 'rgba(86,80,13,0.35)'
        'rgba(30,32,36,0.5)' = 'rgba(17,24,39,0.5)'
    }

    foreach ($entry in $colorMap.GetEnumerator()) {
        $Content = $Content.Replace($entry.Key, $entry.Value)
    }

    if ($Content -notmatch 'brand-logo-text') {
        if ($Path -like '*.min.css') {
            $Content += '.brand-logo-text{display:inline-flex;align-items:baseline;gap:4px;line-height:1}.brand-logo-main{font-size:24px;font-weight:700;letter-spacing:-.5px;color:#1F2937}.brand-logo-sub{font-size:17px;font-weight:500;letter-spacing:.5px;color:#56500D}'
        }
        else {
            $Content += "`r`n`r`n.brand-logo-text {`r`n  display: inline-flex;`r`n  align-items: baseline;`r`n  gap: 4px;`r`n  line-height: 1;`r`n}`r`n`r`n.brand-logo-main {`r`n  font-size: 24px;`r`n  font-weight: 700;`r`n  letter-spacing: -0.5px;`r`n  color: #1F2937;`r`n}`r`n`r`n.brand-logo-sub {`r`n  font-size: 17px;`r`n  font-weight: 500;`r`n  letter-spacing: 0.5px;`r`n  color: #56500D;`r`n}`r`n"
        }
    }

    return $Content
}

$backupSource = Join-Path $Root 'articles.json'
$backupTarget = Join-Path $Root 'articles.json.bak'
if (Test-Path $backupSource) {
    Copy-Item $backupSource $backupTarget -Force
    Write-Host "Backup dibuat: articles.json.bak" -ForegroundColor Green
}

$trackedCounts = [ordered]@{
    'main pages' = 0
    'article pages' = 0
    'css' = 0
    'package' = 0
    'docs' = 0
    'other' = 0
}

$textFiles = Get-ChildItem -Path $Root -Recurse -Include *.html, *.css, *.js, *.json, *.md, *.toml, *.txt, *.ps1 -File |
    Where-Object {
        $_.FullName -notmatch '\\node_modules\\' -and
        $_.Name -notlike '*.bak*'
    }

foreach ($file in $textFiles) {
    $path = $file.FullName
    $relativePath = $path.Substring($Root.Length).TrimStart('\\')

    $content = [System.IO.File]::ReadAllText($path)
    $originalContent = $content

    $content = Normalize-Text -Content $content
    $content = Apply-SharedReplacements -Content $content

    if ($path -like '*.html') {
        $content = Apply-HtmlBranding -Content $content
    }

    if ($path -like '*.css') {
        $content = Apply-CssTheme -Content $content -Path $path
    }

    if ($content -ne $originalContent) {
        Write-Utf8File -Path $path -Content $content

        if ($relativePath -like 'article\*.html') {
            $trackedCounts['article pages']++
        }
        elseif ($relativePath -like '*.html') {
            $trackedCounts['main pages']++
        }
        elseif ($relativePath -like 'css\*.css') {
            $trackedCounts['css']++
        }
        elseif ($relativePath -in @('package.json', 'package-lock.json', 'tools\package.json')) {
            $trackedCounts['package']++
        }
        elseif ($relativePath -in @('AUTOMATION_README.md', 'GOOGLE_DRIVE_GUIDE.md', 'netlify.toml')) {
            $trackedCounts['docs']++
        }
        else {
            $trackedCounts['other']++
        }

        Write-Host "Updated: $relativePath" -ForegroundColor Cyan
    }
}

$automationReadme = Join-Path $Root 'AUTOMATION_README.md'
if (Test-Path $automationReadme) {
    $readmeContent = [System.IO.File]::ReadAllText($automationReadme)
    if ($readmeContent -notmatch 'Rebrand cepat via PowerShell') {
        $readmeContent += @"

---

## Rebrand cepat via PowerShell

Jalankan langkah berikut dari root project untuk memastikan seluruh file `.html` diproses dengan UTF-8 dan `articles.json` otomatis dibackup menjadi `articles.json.bak`.

```powershell
Copy-Item .\articles.json .\articles.json.bak -Force
Get-ChildItem -Recurse -Include *.html | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8
    [System.IO.File]::WriteAllText($_.FullName, $content, [System.Text.UTF8Encoding]::new($false))
}
.\rebrand-to-tribun-purwasuka.ps1
```
"@

        Write-Utf8File -Path $automationReadme -Content $readmeContent
        if ($trackedCounts['docs'] -lt 3) {
            $trackedCounts['docs']++
        }
    }
}

Write-Host ''
Write-Host '===== Ringkasan Perubahan =====' -ForegroundColor Yellow
Write-Host ("main pages   : {0}" -f $trackedCounts['main pages'])
Write-Host ("article pages: {0}" -f $trackedCounts['article pages'])
Write-Host ("css          : {0}" -f $trackedCounts['css'])
Write-Host ("package      : {0}" -f $trackedCounts['package'])
Write-Host ("docs         : {0}" -f $trackedCounts['docs'])
Write-Host ("other        : {0}" -f $trackedCounts['other'])
Write-Host ''
Write-Host 'Rebrand Tribun Purwasuka selesai ✅' -ForegroundColor Green

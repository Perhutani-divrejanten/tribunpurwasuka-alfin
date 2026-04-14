# Script untuk memastikan semua navbar memakai logo teks Tribun Purwasuka

$WorkspaceRoot = if ($PSScriptRoot) { $PSScriptRoot } else { Get-Location }
$htmlFiles = Get-ChildItem -Path $WorkspaceRoot -Recurse -Include "*.html" -File

$textBasedLogo = '<span class="brand-logo-text"><span class="brand-logo-main">TRIBUN</span><span class="brand-logo-sub">PURWASUKA</span></span>'
$replaceCount = 0

foreach ($file in $htmlFiles) {
    try {
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        $updated = [regex]::Replace(
            $content,
            '(?is)(<a[^>]*class="[^"]*navbar-brand[^"]*"[^>]*>)\s*.*?\s*(</a>)',
            "`$1$textBasedLogo`$2"
        )

        if ($updated -ne $content) {
            Set-Content -Path $file.FullName -Value $updated -Encoding UTF8 -NoNewline
            $replaceCount++
            Write-Host "Updated logo in: $($file.Name)"
        }
    }
    catch {
        Write-Host "Error processing $($file.FullName): $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Logo replacement complete!"
Write-Host "Total files updated: $replaceCount"

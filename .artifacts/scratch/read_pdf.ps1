$filePath = "C:\Users\user\OneDrive\Documents\TP Composant\TP_8___Composant.pdf"
Write-Host "Reading file: $filePath"
if (Test-Path $filePath) {
    $bytes = [System.IO.File]::ReadAllBytes($filePath)
    $enc = [System.Text.Encoding]::GetEncoding("Latin1")
    $content = $enc.GetString($bytes)

    $matches = [System.Text.RegularExpressions.Regex]::Matches($content, '\((.*?)\)')
    foreach ($m in $matches) {
        $val = $m.Groups[1].Value
        [Console]::WriteLine($val)
    }
} else {
    Write-Host "File not found!"
}

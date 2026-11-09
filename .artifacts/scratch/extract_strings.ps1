$filePath = "C:\Users\user\OneDrive\Documents\TP Composant\TP_8___Composant.pdf"
$bytes = [System.IO.File]::ReadAllBytes($filePath)
$text = [System.Text.Encoding]::GetEncoding("Latin1").GetString($bytes)

$sb = New-Object System.Text.StringBuilder
for ($i = 0; $i -lt $text.Length; $i++) {
    $c = $text[$i]
    if (($c -ge ' ' -and $c -le '~') -or ($c -eq "`n") -or ($c -eq "`r")) {
        [void]$sb.Append($c)
    } else {
        [void]$sb.Append(' ')
    }
}
$clean = $sb.ToString()
$words = $clean -split '\s+' | Where-Object { $_.Length -gt 3 }
foreach ($w in $words) {
    [Console]::WriteLine($w)
}

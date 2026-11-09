$filePath = "C:\Users\user\OneDrive\Documents\TP Composant\TP_8___Composant.pdf"
$enc = [System.Text.Encoding]::GetEncoding("Latin1")
$text = [System.IO.File]::ReadAllText($filePath, $enc)

Write-Host "Searching for BT...ET blocks:"
$matches = [System.Text.RegularExpressions.Regex]::Matches($text, 'BT(.*?)ET', [System.Text.RegularExpressions.RegexOptions]::Singleline)
foreach ($m in $matches) {
    $block = $m.Groups[1].Value
    $strings = [System.Text.RegularExpressions.Regex]::Matches($block, '\((.*?)\)')
    foreach ($s in $strings) {
        [Console]::WriteLine($s.Groups[1].Value)
    }
    Write-Host "---"
}

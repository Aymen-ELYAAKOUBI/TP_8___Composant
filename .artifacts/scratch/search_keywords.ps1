$filePath = "C:\Users\user\OneDrive\Documents\TP Composant\TP_8___Composant.pdf"
$bytes = [System.IO.File]::ReadAllBytes($filePath)
$text = [System.Text.Encoding]::GetEncoding("Latin1").GetString($bytes)

$matches = [System.Text.RegularExpressions.Regex]::Matches($text, '[A-Za-z0-9_\-\.\,\;\:\!\?\(\)\s]{4,}')
foreach ($m in $matches) {
    $val = $m.Value.Trim()
    if ($val -match 'TP|Composant|Activit|Intent|Layout|Bouton|Exercice|Android|Service|Broadcast|Fragment|Vue|Interface|Main') {
        [Console]::WriteLine($val)
    }
}

$filePath = "C:\Users\user\OneDrive\Documents\TP Composant\S’initier aux composants et modèle d’une application Android .pdf"
if (!(Test-Path $filePath)) {
    # try without apostrophe or find matching file
    $filePath = Get-ChildItem "C:\Users\user\OneDrive\Documents\TP Composant" -Filter "*S*initier*" | Select-Object -ExpandProperty FullName
}
Write-Host "Path: $filePath"
if ($filePath -and (Test-Path $filePath)) {
    $bytes = [System.IO.File]::ReadAllBytes($filePath)
    $text = [System.Text.Encoding]::GetEncoding("Latin1").GetString($bytes)
    $matches = [System.Text.RegularExpressions.Regex]::Matches($text, '[A-Za-z0-9_\-\.\,\;\:\!\?\(\)\s]{4,}')
    foreach ($m in $matches) {
        $val = $m.Value.Trim()
        if ($val -match 'TP|Composant|Activit|Intent|Layout|Bouton|Exercice|Android|Service|Broadcast|Fragment|Vue|Interface|Main|Activité') {
            [Console]::WriteLine($val)
        }
    }
}

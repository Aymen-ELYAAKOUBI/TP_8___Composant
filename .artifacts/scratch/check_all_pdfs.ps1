$dir = "C:\Users\user\OneDrive\Documents\TP Composant"
Get-ChildItem $dir -Filter "*.pdf" | ForEach-Object {
    $path = $_.FullName
    $bytes = [System.IO.File]::ReadAllBytes($path)
    $text = [System.Text.Encoding]::GetEncoding("Latin1").GetString($bytes)
    # count occurrences of words like "TP", "Exercice", "Activité"
    $matches = [System.Text.RegularExpressions.Regex]::Matches($text, 'TP|Exercice|Activité|Composant|Intent|Layout', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    Write-Host "$($_.Name): matches count = $($matches.Count)"
}

$filePath = "C:\Users\user\OneDrive\Documents\TP Composant\TP_8___Composant.pdf"
$bytes = [System.IO.File]::ReadAllBytes($filePath)
$text = [System.Text.Encoding]::GetEncoding("Latin1").GetString($bytes)

# Extract strings in parentheses or Tj/TJ operators
$matches = [System.Text.RegularExpressions.Regex]::Matches($text, '\(([^()\\]|\\.)*\)')
foreach ($m in $matches) {
    $val = $m.Value
    if ($val.Length -gt 2) {
        $clean = $val.Substring(1, $val.Length - 2)
        [Console]::WriteLine($clean)
    }
}

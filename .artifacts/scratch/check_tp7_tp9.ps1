$dir = "C:\Users\user\OneDrive\Documents\TP Composant"
foreach ($name in @("TP_7___Composant.pdf", "TP_9___Composant.pdf", "TP_1___Composant.pdf")) {
    $path = Join-Path $dir $name
    if (Test-Path $path) {
        $bytes = [System.IO.File]::ReadAllBytes($path)
        $text = [System.Text.Encoding]::GetEncoding("Latin1").GetString($bytes)
        Write-Host "=== $name ==="
        $matches = [System.Text.RegularExpressions.Regex]::Matches($text, '\(([^()\\]|\\.)*\)')
        foreach ($m in $matches) {
            $val = $m.Value
            if ($val.Length -gt 4) {
                $clean = $val.Substring(1, $val.Length - 2)
                if ($clean -match '[A-Za-zÀ-ÿ]{3,}') {
                    [Console]::WriteLine($clean)
                }
            }
        }
    }
}

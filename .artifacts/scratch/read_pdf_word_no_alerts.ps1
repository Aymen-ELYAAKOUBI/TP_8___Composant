$filePath = "C:\Users\user\OneDrive\Documents\TP Composant\TP_8___Composant.pdf"
Write-Host "Reading PDF via Word COM (no alerts): $filePath"
try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false
    $word.DisplayAlerts = 0 # wdAlertsNone
    $doc = $word.Documents.Open($filePath, $false, $true)
    $text = $doc.Content.Text
    $doc.Close(0) # wdDoNotSaveChanges
    $word.Quit()
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    [Console]::WriteLine("=== PDF TEXT START ===")
    [Console]::WriteLine($text)
    [Console]::WriteLine("=== PDF TEXT END ===")
} catch {
    Write-Host "Error: $_"
}

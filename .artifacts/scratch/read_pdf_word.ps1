$filePath = "C:\Users\user\OneDrive\Documents\TP Composant\TP_8___Composant.pdf"
Write-Host "Reading PDF via Word COM: $filePath"
try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false
    $doc = $word.Documents.Open($filePath, $false, $true) # ReadOnly, ConfirmConversion
    $text = $doc.Content.Text
    $doc.Close([Microsoft.Office.Interop.Word.WdSaveOptions]::wdDoNotSaveChanges)
    $word.Quit()
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    [Console]::WriteLine($text)
} catch {
    Write-Host "Error: $_"
}

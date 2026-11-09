# Enable WinRT types
[Windows.Storage.StorageFile, Windows.Storage, ContentType=WindowsRuntime] | Out-Null

$pdfPath = "C:\Users\user\OneDrive\Documents\TP Composant\TP_8___Composant.pdf"
Write-Host "Loading PDF: $pdfPath"
$fileTask = [Windows.Storage.StorageFile]::GetFileFromPathAsync($pdfPath)
$file = $fileTask.AsTask().GetAwaiter().GetResult()

$pdfTask = [Windows.Data.Pdf.PdfDocument]::LoadFromFileAsync($file)
$pdfDoc = $pdfTask.AsTask().GetAwaiter().GetResult()

Write-Host "Page count: $($pdfDoc.PageCount)"

# Setup OCR engine
$ocrEngine = [Windows.Media.Ocr.OcrEngine]::TryCreateFromUserProfileLanguages()
if (-not $ocrEngine) {
    $ocrEngine = [Windows.Media.Ocr.OcrEngine]::TryCreateFromLanguage([Windows.Globalization.Language]::new("fr"))
}
if (-not $ocrEngine) {
    $ocrEngine = [Windows.Media.Ocr.OcrEngine]::TryCreateFromLanguage([Windows.Globalization.Language]::new("en"))
}

for ($i = 0; $i -lt $pdfDoc.PageCount; $i++) {
    $page = $pdfDoc.GetPage($i)
    $stream = New-Object Windows.Storage.Streams.InMemoryRandomAccessStream
    $page.RenderToStreamAsync($stream).AsTask().GetResults()

    $decoderTask = [Windows.Graphics.Imaging.BitmapDecoder]::CreateAsync($stream)
    $decoder = $decoderTask.AsTask().GetResults()

    $softwareBitmapTask = $decoder.GetSoftwareBitmapAsync()
    $softwareBitmap = $softwareBitmapTask.AsTask().GetResults()

    if ($ocrEngine) {
        $ocrTask = $ocrEngine.RecognizeAsync($softwareBitmap)
        $ocrResult = $ocrTask.AsTask().GetResults()
        Write-Host "=== PAGE $($i+1) ==="
        foreach ($line in $ocrResult.Lines) {
            [Console]::WriteLine($line.Text)
        }
    }
    $page.Dispose()
    $stream.Dispose()
}

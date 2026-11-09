$pdfPath = "C:\Users\user\OneDrive\Documents\TP Composant\TP_8___Composant.pdf"
$file = [Windows.Storage.StorageFile,Windows.Storage,ContentType=Windows.Storage]::GetFileFromPathAsync($pdfPath).GetResults()
$pdfDoc = [Windows.Data.Pdf.PdfDocument,Windows.Data.Pdf,ContentType=Windows.WinRT]::LoadFromFileAsync($file).GetResults()

Write-Host "PDF Page Count: $($pdfDoc.PageCount)"
for ($i = 0; $i -lt $pdfDoc.PageCount; $i++) {
    $page = $pdfDoc.GetPage($i)
    $stream = New-Object Windows.Storage.Streams.InMemoryRandomAccessStream
    $page.RenderToStreamAsync($stream).GetResults()

    $folder = [Windows.Storage.StorageFolder,Windows.Storage,ContentType=Windows.Storage]::GetFolderFromPathAsync("C:\Users\user\AndroidStudioProjects\TP_8___Composant\.artifacts\scratch").GetResults()
    $outFile = $folder.CreateFileAsync("page_$i.png", [Windows.Storage.CreationCollisionOption]::ReplaceExisting).GetResults()
    $outStream = $outFile.OpenAsync([Windows.Storage.FileAccessMode]::ReadWrite).GetResults()

    [Windows.Storage.Streams.RandomAccessStream]::CopyAsync($stream, $outStream).GetResults()
    $outStream.FlushAsync().GetResults()
    $outStream.Dispose()
    $stream.Dispose()
    $page.Dispose()
    Write-Host "Saved page_$i.png"
}

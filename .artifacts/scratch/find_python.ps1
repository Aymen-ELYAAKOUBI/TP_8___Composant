$pythonPaths = @(
    "C:\Python312\python.exe",
    "C:\Python311\python.exe",
    "C:\Python310\python.exe",
    "C:\Users\user\AppData\Local\Programs\Python\Python312\python.exe",
    "C:\Users\user\AppData\Local\Programs\Python\Python311\python.exe",
    "C:\Users\user\AppData\Local\Programs\Python\Python310\python.exe",
    "python",
    "py"
)
foreach ($p in $pythonPaths) {
    try {
        $ver = & $p --version 2>&1
        Write-Host "Found python at: $p -> $ver"
    } catch {
        # ignore
    }
}

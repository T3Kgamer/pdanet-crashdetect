$programExePath = "C:\Program Files (x86)\PdaNet for Android\PdaNetPC.exe"
$programWindowTitle = "PdaNetPC.exe"

while ($true) {
    $programProcess = Get-Process | Where-Object { $_.Path -eq $programExePath }
    $programWindow = Get-Process | Where-Object { $_.MainWindowTitle -eq $programWindowTitle }

    if ($null -eq $programProcess) {
        Write-Host "PDANet is not running"
        Start-Process -FilePath $programExePath -NoNewWindow
    }
    else {
        Write-Host "PDANet is running."
    }

    if ($null -eq $programWindow) {
        Write-Host "PDANet is Responding."
    }
    else {
        Write-Host "PDANet has crashed. Killing process..."
        $programWindow | ForEach-Object { Stop-Process -Id $_.Id }
        Write-Host "Starting PDANet..."
        Start-Process -FilePath $programExePath -NoNewWindow
    }

    # Sleep for a while before checking again (adjust the duration as needed)
    Start-Sleep -Seconds 60
}
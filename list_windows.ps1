Get-Process | Where-Object {$_.MainWindowTitle -ne ""} | Select-Object MainWindowTitle

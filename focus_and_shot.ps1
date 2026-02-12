$wshell = New-Object -ComObject WScript.Shell
$success = $wshell.AppActivate("BrainrotAscension - Roblox Studio")
if ($success) {
    Start-Sleep -m 1000
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait("%{PRTSC}")
    Start-Sleep -m 500
    $img = [System.Windows.Forms.Clipboard]::GetImage()
    $img.Save("C:\Users\Boss\clawd\screenshot.png", [System.Drawing.Imaging.ImageFormat]::Png)
    Write-Host "Focused and Screenshot Saved."
} else {
    Write-Host "Failed to focus."
}

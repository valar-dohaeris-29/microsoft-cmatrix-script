# Check if running as admin, if not, re-launch as admin
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Set paths for files and backup
$hostsPath = "C:\Windows\System32\drivers\etc\hosts"
$focusPath = "C:\Users\Deuel\Documents\Blocker script\Focus"
$plebPath = "C:\Users\Deuel\Documents\Blocker script\Pleb"
$backupPath = "$hostsPath.bak"

# Check if backup file exists, if not, create one
if (-not (Test-Path -LiteralPath $backupPath)) {
    Copy-Item -LiteralPath $hostsPath -Destination $backupPath
}

# Check current hosts file and swap with either Focus or Pleb
$currentFile = Get-Content -LiteralPath $hostsPath -Raw
if ($currentFile -eq (Get-Content -LiteralPath $focusPath -Raw)) {
    Copy-Item -LiteralPath $plebPath -Destination $hostsPath -Force
} else {
    Copy-Item -LiteralPath $focusPath -Destination $hostsPath -Force
}

# Notify user of update
Write-Output "Woohoo Hosts file has been updated"
pause
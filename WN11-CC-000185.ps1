#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Prevents autorun commands from executing when removable media
    is connected, in compliance with DISA Windows 11 STIG v2r6.

.DESCRIPTION
    Sets NoAutorun to 1 under the Windows Explorer policy registry key.
    Autorun commands allow removable media to silently execute programs
    the moment they are inserted into a system. This behavior has been
    weaponized by malware for decades and remains a relevant threat
    vector. This setting blocks automatic command execution while
    preserving the user's ability to access the media manually.

.NOTES
    Author          : Destiny Furlong
    LinkedIn        : https://www.linkedin.com/in/destiny-f-79a2441b7
    GitHub          : https://github.com/Zaia-Blog/STIGS/blob/main/WN11-CC-000185.ps1
    Date Created    : 2026-03-18
    Last Modified   : 2026-03-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000185

.TESTED ON
    Date(s) Tested  : 2026-03-18
    Tested By       : Destiny Furlong
    Systems Tested  : Windows 11 Pro 64-bit Gen 2
    PowerShell Ver. : 5.1.26100.7920

.USAGE
    Run as Administrator.
    PS C:\> .\WN11-CC-000185.ps1
#>

Write-Host "Applying WN11-CC-000185 - Disabling autorun commands..." -ForegroundColor Yellow

$explorerPolicyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"

if (-not (Test-Path $explorerPolicyPath)) { New-Item -Path $explorerPolicyPath -Force | Out-Null }

Set-ItemProperty -Path $explorerPolicyPath -Name "NoAutorun" -Value 1 -Type DWord -Force

Write-Host "Done. Autorun command execution blocked on this system." -ForegroundColor Green

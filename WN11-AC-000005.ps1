#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Configures locked accounts to remain locked for a minimum of
    15 minutes, in compliance with DISA Windows 11 STIG v2r6.

.DESCRIPTION
    Applies the account lockout duration using the net accounts command.
    A short lockout window allows attackers to resume guessing passwords
    almost immediately after being locked out. Setting the duration to
    15 minutes forces a meaningful delay between attack attempts and
    reduces the effectiveness of automated password attacks.

.NOTES
    Author          : Destiny Furlong
    LinkedIn        : https://www.linkedin.com/in/destiny-f-79a2441b7
    GitHub          : https://github.com/Zaia-Blog/STIGS/blob/main/WN11-AC-000005.ps1
    Date Created    : 2026-03-18
    Last Modified   : 2026-03-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000005

.TESTED ON
    Date(s) Tested  : 2026-03-18
    Tested By       : Destiny Furlong
    Systems Tested  : Windows 11 Pro 64-bit Gen 2
    PowerShell Ver. : 5.1.26100.7920

.USAGE
    Run as Administrator.
    PS C:\> .\WN11-AC-000005.ps1
#>

Write-Host "Applying WN11-AC-000005 - Setting account lockout duration..." -ForegroundColor Yellow

$lockoutDuration = 15
net accounts /lockoutduration:$lockoutDuration | Out-Null

Write-Host "Done. Account lockout duration configured to $lockoutDuration minutes." -ForegroundColor Green

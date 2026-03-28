#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Enforces a maximum of 3 invalid logon attempts before account
    lockout, in compliance with DISA Windows 11 STIG v2r6.

.DESCRIPTION
    Applies the account lockout threshold using the net accounts command.
    Allowing unlimited login attempts gives attackers the ability to
    repeatedly guess passwords without consequence. Restricting this
    to 3 attempts ensures that accounts are locked before a brute-force
    attack can succeed.

.NOTES
    Author          : Destiny Furlong
    LinkedIn        : https://www.linkedin.com/in/destiny-f-79a2441b7
    GitHub          : https://github.com/Zaia-Blog/STIGS/blob/main/WN11-AC-000010.ps1
    Date Created    : 2026-03-18
    Last Modified   : 2026-03-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000010

.TESTED ON
    Date(s) Tested  : 2026-03-18
    Tested By       : Destiny Furlong
    Systems Tested  : Windows 11 Pro 64-bit Gen 2
    PowerShell Ver. : 5.1.26100.7920

.USAGE
    Run as Administrator.
    PS C:\> .\WN11-AC-000010.ps1
#>

Write-Host "Applying WN11-AC-000010 - Setting account lockout threshold..." -ForegroundColor Yellow

$accountLockoutThreshold = 3
net accounts /lockoutthreshold:$accountLockoutThreshold | Out-Null

Write-Host "Done. Account lockout threshold is now set to $accountLockoutThreshold attempts." -ForegroundColor Green

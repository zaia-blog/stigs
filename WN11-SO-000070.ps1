#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Configures Windows to lock the screen after 15 minutes of
    inactivity, in compliance with DISA Windows 11 STIG v2r6.

.DESCRIPTION
    Writes the InactivityTimeoutSecs value to the System policy
    registry key and sets it to 900 seconds (15 minutes). An unlocked,
    unattended workstation is an open door for anyone with physical
    access to the machine. Automatically locking the screen after a
    period of inactivity ensures that systems are not left exposed
    when a user steps away.

.NOTES
    Author          : Destiny Furlong
    LinkedIn        : linkedin.com/in/
    GitHub          : github.com/
    Date Created    : 2026-03-18
    Last Modified   : 2026-03-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000070

.TESTED ON
    Date(s) Tested  : 2026-03-18
    Tested By       : Destiny Furlong
    Systems Tested  : Windows 11 Pro 64-bit Gen 2
    PowerShell Ver. : 5.1.26100.7920

.USAGE
    Run as Administrator.
    PS C:\> .\WN11-SO-000070.ps1
#>

Write-Host "`n[STIG] WN11-SO-000070 - Machine Inactivity Screen Lock" -ForegroundColor Cyan

$inactivityPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

if (-not (Test-Path $inactivityPath)) {
    New-Item -Path $inactivityPath -Force | Out-Null
}

Set-ItemProperty -Path $inactivityPath -Name "InactivityTimeoutSecs" -Value 900 -Type DWord -Force

Write-Host "[PASS] Inactivity timeout set to 900 seconds (15 minutes)" -ForegroundColor Green

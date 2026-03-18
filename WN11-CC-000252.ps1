#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Disables the Xbox Game DVR screen recording and broadcasting
    feature, in compliance with DISA Windows 11 STIG v2r6.

.DESCRIPTION
    Sets AllowGameDVR to 0 under the GameDVR policy registry key.
    Although the Game Bar is marketed as a gaming tool, its screen
    capture capabilities are not limited to games. On a secure
    workstation, this feature introduces the risk of sensitive on-screen
    content being recorded or broadcast. Disabling it removes this
    exposure entirely.

.NOTES
    Author          : Destiny Furlong
    LinkedIn        : linkedin.com/in/
    GitHub          : github.com/
    Date Created    : 2026-03-18
    Last Modified   : 2026-03-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000252

.TESTED ON
    Date(s) Tested  : 2026-03-18
    Tested By       : Destiny Furlong
    Systems Tested  : Windows 11 Pro 64-bit Gen 2
    PowerShell Ver. : 5.1.26100.7920

.USAGE
    Run as Administrator.
    PS C:\> .\WN11-CC-000252.ps1
#>

Write-Host "`n[STIG] WN11-CC-000252 - Disable Windows Game Recording (GameDVR)" -ForegroundColor Cyan

$gameDVRPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"

if (-not (Test-Path $gameDVRPath)) { New-Item -Path $gameDVRPath -Force | Out-Null }

Set-ItemProperty -Path $gameDVRPath -Name "AllowGameDVR" -Value 0 -Type DWord -Force

Write-Host "[PASS] Xbox Game DVR recording and broadcasting has been disabled" -ForegroundColor Green

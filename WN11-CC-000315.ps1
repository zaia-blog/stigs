#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Disables the ability for non-administrative users to install
    software with elevated privileges, in compliance with DISA
    Windows 11 STIG v2r6.

.DESCRIPTION
    Sets AlwaysInstallElevated to 0 in both the HKLM and HKCU registry
    hives. When this setting is left enabled, standard users can install
    software as though they have administrator rights, which is a known
    privilege escalation vulnerability. Both hives must be explicitly
    set to 0 for the system to be considered compliant.

.NOTES
    Author          : Destiny Furlong
    LinkedIn        : linkedin.com/in/
    GitHub          : github.com/
    Date Created    : 2026-03-18
    Last Modified   : 2026-03-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315

.TESTED ON
    Date(s) Tested  : 2026-03-18
    Tested By       : Destiny Furlong
    Systems Tested  : Windows 11 Pro 64-bit Gen 2
    PowerShell Ver. : 5.1.26100.7920

.USAGE
    Run as Administrator.
    PS C:\> .\WN11-CC-000315.ps1
#>

Write-Host "`n[STIG] WN11-CC-000315 - Disable Always Install with Elevated Privileges" -ForegroundColor Cyan

$installerPathHKLM = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$installerPathHKCU = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer"

if (-not (Test-Path $installerPathHKLM)) { New-Item -Path $installerPathHKLM -Force | Out-Null }
Set-ItemProperty -Path $installerPathHKLM -Name "AlwaysInstallElevated" -Value 0 -Type DWord -Force

if (-not (Test-Path $installerPathHKCU)) { New-Item -Path $installerPathHKCU -Force | Out-Null }
Set-ItemProperty -Path $installerPathHKCU -Name "AlwaysInstallElevated" -Value 0 -Type DWord -Force

Write-Host "[PASS] AlwaysInstallElevated set to 0 in both HKLM and HKCU" -ForegroundColor Green

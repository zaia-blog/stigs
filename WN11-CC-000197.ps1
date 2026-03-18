#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Prevents Windows from displaying consumer-oriented content such
    as app suggestions and promotional material, in compliance with
    DISA Windows 11 STIG v2r6.

.DESCRIPTION
    Sets DisableWindowsConsumerFeatures to 1 under the CloudContent
    policy registry key. Consumer experience features are designed for
    personal home use and have no place on government or enterprise
    systems. Beyond being a distraction, these features can send
    telemetry and usage data to Microsoft servers, which conflicts
    with data handling requirements in secure environments.

.NOTES
    Author          : Destiny Furlong
    LinkedIn        : linkedin.com/in/
    GitHub          : github.com/
    Date Created    : 2026-03-18
    Last Modified   : 2026-03-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000197

.TESTED ON
    Date(s) Tested  : 2026-03-18
    Tested By       : Destiny Furlong
    Systems Tested  : Windows 11 Pro 64-bit Gen 2
    PowerShell Ver. : 5.1.26100.7920

.USAGE
    Run as Administrator.
    PS C:\> .\WN11-CC-000197.ps1
#>

Write-Host "`n[STIG] WN11-CC-000197 - Disable Microsoft Consumer Experiences" -ForegroundColor Cyan

$cloudContentPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"

if (-not (Test-Path $cloudContentPath)) { New-Item -Path $cloudContentPath -Force | Out-Null }

Set-ItemProperty -Path $cloudContentPath -Name "DisableWindowsConsumerFeatures" -Value 1 -Type DWord -Force

Write-Host "[PASS] Windows consumer features and app suggestions disabled" -ForegroundColor Green

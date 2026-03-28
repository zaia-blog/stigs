#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Ensures Windows uses granular audit subcategory settings rather
    than the legacy category-based audit system, in compliance with
    DISA Windows 11 STIG v2r6.

.DESCRIPTION
    Sets SCENoApplyLegacyAuditPolicy to 1 under the LSA registry key.
    Windows supports two audit configuration models. The legacy model
    uses broad on/off categories, while the modern model allows precise
    control at the subcategory level. Without this registry value in
    place, Windows may fall back to the legacy model and ignore the
    subcategory settings applied by auditpol, such as those configured
    in WN11-AU-000050.

.NOTES
    Author          : Destiny Furlong
    LinkedIn        : https://www.linkedin.com/in/destiny-f-79a2441b7
    GitHub          : https://github.com/Zaia-Blog/STIGS/blob/main/WN11-SO-000030.ps1
    Date Created    : 2026-03-18
    Last Modified   : 2026-03-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000030

.TESTED ON
    Date(s) Tested  : 2026-03-18
    Tested By       : Destiny Furlong
    Systems Tested  : Windows 11 Pro 64-bit Gen 2
    PowerShell Ver. : 5.1.26100.7920

.USAGE
    Run as Administrator.
    PS C:\> .\WN11-SO-000030.ps1
#>

Write-Host "Applying WN11-SO-000030 - Forcing audit subcategory policy..." -ForegroundColor Yellow

$lsaPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"

if (-not (Test-Path $lsaPath)) { New-Item -Path $lsaPath -Force | Out-Null }

Set-ItemProperty -Path $lsaPath -Name "SCENoApplyLegacyAuditPolicy" -Value 1 -Type DWord -Force

Write-Host "Done. Legacy audit policy override disabled, subcategory policy is now enforced." -ForegroundColor Green

#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Enables Windows Security event logging for successful process
    creation events, in compliance with DISA Windows 11 STIG v2r6.

.DESCRIPTION
    Uses the auditpol command to configure success auditing for the
    Process Creation subcategory under Detailed Tracking. Each time
    a process starts on the system, a corresponding entry will be
    written to the Security event log. This log data is foundational
    for incident response and forensic analysis, providing a record
    of every executable that ran and when it ran.

.NOTES
    Author          : Destiny Furlong
    LinkedIn        : linkedin.com/in/
    GitHub          : github.com/
    Date Created    : 2026-03-18
    Last Modified   : 2026-03-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000050

.TESTED ON
    Date(s) Tested  : 2026-03-18
    Tested By       : Destiny Furlong
    Systems Tested  : Windows 11 Pro 64-bit Gen 2
    PowerShell Ver. : 5.1.26100.7920

.USAGE
    Run as Administrator.
    PS C:\> .\WN11-AU-000050.ps1
#>

Write-Host "`n[STIG] WN11-AU-000050 - Enable Process Creation Auditing" -ForegroundColor Cyan

$auditResult = auditpol /set /subcategory:"Process Creation" /success:enable /failure:disable 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "[PASS] Process Creation success auditing is now active" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Failed to configure Process Creation auditing - Error: $auditResult" -ForegroundColor Red
}

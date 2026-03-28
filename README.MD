# 🛡️ DISA Windows 11 STIG v2r6 — PowerShell Remediation Scripts 🛡️

---

## What Is This?

This repository contains PowerShell remediation scripts for the DISA (Defense Information Systems Agency) Windows 11 STIG (Security Technical Implementation Guide) Version 2, Release 6.

A STIG is a checklist of security rules that the U.S. Department of Defense requires on all government and government-adjacent computer systems. When a system is scanned and a rule comes back as Failed, it means a specific security setting is either missing or configured incorrectly. These scripts fix those failures automatically by applying the correct settings through PowerShell.

Each script targets one specific STIG control, is self-contained, and can be run on its own without needing to run any of the others first.

---

## Environment

| Field | Details |
|---|---|
| Operating System | Windows 11 Pro 64-bit Gen 2 |
| PowerShell Version | 5.1.26100.7920 |
| STIG Benchmark | DISA Microsoft Windows 11 STIG v2r6 |
| Benchmark Reference | [Download from DoD Cyber Exchange](https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_MS_Windows_11_V2R6_STIG.zip) |

---

## Requirements

All scripts must be run as Administrator. Each script is written for Windows 11, so do not run these on other operating system versions without reviewing the registry paths first. If the machine is domain joined, some settings may be overridden by Group Policy pushed from the domain controller. Check with your domain admin if a setting reverts after running. Always test in a non-production environment before deploying at scale.

---

## How To Run a Script

1. Right-click **PowerShell** in the Start menu.
2. Select **Run as Administrator.**
3. Navigate to the folder where the scripts are saved:
   ```powershell
   cd C:\path\to\scripts
   ```
4. Run the script by name:
   ```powershell
   .\WN11-AC-000010.ps1
   ```
5. Read the output. Yellow means the script is applying the change and green means it succeeded.

---

## Scripts Included

### 1. [WN11-AC-000010.ps1](https://github.com/Zaia-Blog/STIGS/blob/main/WN11-AC-000010.ps1) — Account Lockout Threshold

**What it fixes:** Sets the maximum number of failed login attempts to 3 before an account locks out.

**Why it matters:** Without a lockout limit, an attacker can guess passwords as many times as they want. Limiting attempts to 3 stops brute force attacks before they can get anywhere. Think of it the same way an ATM locks after 3 wrong PINs.

**How it works:** Uses the `net accounts` command to apply the lockout threshold policy.

---

### 2. [WN11-AC-000005.ps1](https://github.com/Zaia-Blog/STIGS/blob/main/WN11-AC-000005.ps1) — Account Lockout Duration

**What it fixes:** Configures locked accounts to stay locked for a minimum of 15 minutes.

**Why it matters:** A short lockout window allows attackers to resume guessing passwords almost immediately after being locked out. Setting the duration to 15 minutes forces a meaningful delay between attack attempts and reduces the effectiveness of automated password attacks.

**How it works:** Uses the `net accounts` command to apply the lockout duration policy.

---

### 3. [WN11-SO-000070.ps1](https://github.com/Zaia-Blog/STIGS/blob/main/WN11-SO-000070.ps1) — Machine Inactivity Screen Lock

**What it fixes:** Configures Windows to lock the screen after 15 minutes of no activity.

**Why it matters:** An unlocked, unattended workstation is an open door for anyone with physical access to the machine. Automatically locking the screen after a period of inactivity ensures systems are not left exposed when a user steps away.

**How it works:** Sets `InactivityTimeoutSecs` to 900 in the `System` policy registry key.

---

### 4. [WN11-CC-000315.ps1](https://github.com/Zaia-Blog/STIGS/blob/main/WN11-CC-000315.ps1) — Disable Always Install with Elevated Privileges

**What it fixes:** Prevents standard users from installing software with administrator level privileges.

**Why it matters:** When this setting is left enabled, standard users can install software as though they have administrator rights, which is a known privilege escalation vulnerability. Both the HKLM and HKCU registry hives must be set to 0 for the system to be fully compliant.

**How it works:** Sets `AlwaysInstallElevated` to 0 in both the `HKLM` and `HKCU` Installer policy registry keys.

---

### 5. [WN11-CC-000197.ps1](https://github.com/Zaia-Blog/STIGS/blob/main/WN11-CC-000197.ps1) — Disable Microsoft Consumer Experiences

**What it fixes:** Prevents Windows from displaying app suggestions, promotional content, and consumer oriented features.

**Why it matters:** Consumer experience features are designed for personal home use and have no place on government or enterprise systems. Beyond being a distraction, these features can send telemetry and usage data to Microsoft servers, which conflicts with data handling requirements in secure environments.

**How it works:** Sets `DisableWindowsConsumerFeatures` to 1 in the `CloudContent` policy registry key.

---

### 6. [WN11-CC-000252.ps1](https://github.com/Zaia-Blog/STIGS/blob/main/WN11-CC-000252.ps1) — Disable Windows Game Recording and Broadcasting

**What it fixes:** Disables the Xbox Game DVR screen recording and broadcasting feature.

**Why it matters:** Although the Game Bar is marketed as a gaming tool, its screen capture capabilities are not limited to games. On a secure workstation this feature introduces the risk of sensitive on-screen content being recorded or broadcast without the user realizing it.

**How it works:** Sets `AllowGameDVR` to 0 in the `GameDVR` policy registry key.

---

### 7. [WN11-CC-000185.ps1](https://github.com/Zaia-Blog/STIGS/blob/main/WN11-CC-000185.ps1) — Disable Autorun Commands

**What it fixes:** Prevents autorun commands from executing automatically when removable media is connected.

**Why it matters:** Autorun commands allow removable media to silently execute programs the moment they are inserted into a system. This behavior has been used to spread malware for decades and remains a relevant threat vector today. This setting blocks automatic execution while still letting users manually open and use the media.

**How it works:** Sets `NoAutorun` to 1 in the `Explorer` policy registry key.

---

### 8. [WN11-CC-000190.ps1](https://github.com/Zaia-Blog/STIGS/blob/main/WN11-CC-000190.ps1) — Disable Autoplay for All Drives

**What it fixes:** Disables the Autoplay prompt for every drive type connected to the system.

**Why it matters:** Disabling Autoplay eliminates the dialog prompt that can be used to trick users into running malicious content from an inserted drive. The value 255 covers every drive type Windows recognizes including removable, fixed, optical, and network drives.

**How it works:** Sets `NoDriveTypeAutoRun` to 255 in the `Explorer` policy registry key.

---

### 9. [WN11-AU-000050.ps1](https://github.com/Zaia-Blog/STIGS/blob/main/WN11-AU-000050.ps1) — Enable Process Creation Auditing

**What it fixes:** Enables Windows to write a Security event log entry every time a new process starts.

**Why it matters:** This audit trail is critical for forensic investigations, allowing analysts to see exactly what ran on a system and when it ran. Without it, there is no record of malicious executables that may have been run on the machine.

**How it works:** Uses the `auditpol` command to enable success auditing for the Process Creation subcategory under Detailed Tracking.

---

### 10. [WN11-SO-000030.ps1](https://github.com/Zaia-Blog/STIGS/blob/main/WN11-SO-000030.ps1) — Force Audit Subcategory Policy

**What it fixes:** Ensures Windows uses the modern granular audit subcategory system rather than the older category based system.

**Why it matters:** Without this setting in place, Windows may fall back to the legacy audit model and ignore subcategory settings configured by auditpol, including the Process Creation auditing set up in WN11-AU-000050. This setting is what makes those audit configurations actually take effect.

**How it works:** Sets `SCENoApplyLegacyAuditPolicy` to 1 in the `LSA` registry key.

---

## How To Verify a Script Worked

After running a script you can manually verify the registry value was applied. Press `Windows + R`, type `regedit`, and navigate to the key listed in each script's description. Confirm the value matches what the script was supposed to set.

You can also re-run your STIG scanner such as Tenable Nessus or the SCAP Compliance Checker against the machine to confirm the control now shows as Passed.

---

## Notes

Scripts that modify HKLM (HKEY_LOCAL_MACHINE) apply machine wide and affect all users on the system. A system reboot is not required for most of these changes but is recommended after running multiple scripts to make sure all policies take effect cleanly. These scripts only fix local policy settings. Domain Group Policy will always take precedence on domain joined systems, so if a setting keeps reverting, the fix needs to happen at the domain controller level rather than on the workstation.


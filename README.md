# AD User Export

A simple PowerShell script that exports all Active Directory user accounts to a CSV file, using standard AD attributes.

## What it does

- Queries all **enabled** AD user accounts
- Exports the following fields:
  - Name
  - Email
  - Standort (Office/Location)
  - Abteilung (Department)
  - Initials
- Saves the result as a semicolon-delimited `.csv` file (Excel-friendly, regardless of regional settings)

## Requirements

- Windows PowerShell 5.1+ (or PowerShell 7+ with the AD module)
- **ActiveDirectory PowerShell module** (part of RSAT - Remote Server Administration Tools)
  - Install via: `Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0`
- Must be run on a domain-joined machine with permission to query AD (read-only)

## Usage

```powershell
# Run with default output path (Desktop)
.\Export-ADUsers.ps1
```

## Output example

| Name       | Email             | Standort | Abteilung | Initials |
|------------|-------------------|----------|-----------|----------|
| John Doe   | john.doe@x.com    | Berlin   | IT        | JD       |

## Notes

- Only **enabled** accounts are included (disabled/deactivated users are filtered out).
- The script performs a **read-only** query — no changes are made to AD.
- Field names (`Standort`, `Abteilung`) are in German but can be renamed as needed in the `Select-Object` block.

## License

Feel free to use, modify, and share :) Parnia

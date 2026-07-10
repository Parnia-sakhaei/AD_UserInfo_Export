# Config
$OutputPath = "ADD YOUR OUTPUT PATH HERE"
$Delimiter  = ";"

# Ensure output folder exists
$OutputFolder = Split-Path -Path $OutputPath -Parent
if (-not (Test-Path -Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder -Force | Out-Null
}

# Load AD module (check only, no auto-install - install RSAT once manually if missing)
try {
    Import-Module ActiveDirectory -ErrorAction Stop
}
catch {
    Write-Error "ActiveDirectory module not installed."
    exit 1
}

# Query enabled AD users (read-only) and map fields
$Filter = "Enabled -eq 'True'"

$Users = Get-ADUser -Filter $Filter -Properties mail, physicalDeliveryOfficeName, Department, Initials |
    Select-Object `
        @{Name = "Name"; Expression = { $_.name } },
        @{Name = "Email"; Expression = { $_.mail } },
        @{Name = "Standort"; Expression = { $_.physicalDeliveryOfficeName } },
        @{Name = "Abteilung"; Expression = { $_.department } },
        @{Name = "Initials"; Expression = { $_.initials } }

# Export to CSV ("sep=;" line makes Excel use ; regardless of regional settings)
$CsvLines = $Users | ConvertTo-Csv -NoTypeInformation -Delimiter $Delimiter
@("sep=$Delimiter") + $CsvLines | Out-File -FilePath $OutputPath -Encoding UTF8

Write-Host "Export completed: $OutputPath ($($Users.Count) users)" -ForegroundColor Green
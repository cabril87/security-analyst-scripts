<#
.SYNOPSIS
    Lists all installed software by checking common registry paths.

.DESCRIPTION
    Reads the 'Uninstall' registry keys from both 64-bit and 32-bit hives 
    to produce a combined list of installed programs. Displays the publisher, 
    install date, and version where available.

.EXAMPLE
    .\List-InstalledSoftware.ps1
#>

Function Get-InstalledSoftware {
    # 64-bit and 32-bit registry paths
    $paths = @(
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )

    foreach ($path in $paths) {
        Get-ItemProperty $path -ErrorAction SilentlyContinue | ForEach-Object {
            [PSCustomObject]@{
                Name        = $_.DisplayName
                Publisher   = $_.Publisher
                InstallDate = $_.InstallDate
                Version     = $_.DisplayVersion
                UninstallID = $_.PSChildName
                RegistryKey = $path
            }
        }
    }
}

Write-Host "=== Installed Software ==="
$softwareList = Get-InstalledSoftware | Where-Object { $_.Name } | Sort-Object Name
$softwareList | Format-Table Name, Publisher, Version, InstallDate -AutoSize

Write-Host "`nTotal programs found: " $softwareList.Count

#Run with .\List-InstalledSoftware.ps1
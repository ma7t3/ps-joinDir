# Source and target base folders – adjust as needed
$sourceRoot = "<SOURCE PATH>"                  # Can be anywhere
$targetRoot = "<DESTINATION PATH>"             # Can be within or outside source

# Prevent processing the target inside the source
if ($targetRoot.StartsWith($sourceRoot)) {
    Write-Host "Warning: Target is inside source. Skipping any target folder files during scan."
}

# Get path of this script to avoid copying itself
$thisScript = $MyInvocation.MyCommand.Path

# Create target root if needed
New-Item -ItemType Directory -Path $targetRoot -Force | Out-Null

# Iterate over all top-level folders inside the source
Get-ChildItem -Path $sourceRoot -Directory | ForEach-Object {
    $currentFolder = $_.FullName

    # Copy files directly in the current folder
    Get-ChildItem -Path $currentFolder -File | ForEach-Object {
        $destFile = Join-Path -Path $targetRoot -ChildPath $_.Name
        if ($_.FullName -ne $thisScript) {
            Copy-Item -Path $_.FullName -Destination $destFile -Force
        }
    }

    # Copy each subfolder (e.g., "model", "texture") into corresponding subfolder in target
    Get-ChildItem -Path $currentFolder -Directory | ForEach-Object {
        $subfolderName = $_.Name
        $subfolderPath = $_.FullName
        $targetSubfolder = Join-Path $targetRoot $subfolderName
        New-Item -ItemType Directory -Path $targetSubfolder -Force | Out-Null

        Get-ChildItem -Path $subfolderPath -File | ForEach-Object {
            $destFile = Join-Path $targetSubfolder $_.Name
            if ($_.FullName -ne $thisScript) {
                Copy-Item -Path $_.FullName -Destination $destFile -Force
            }
        }
    }
}

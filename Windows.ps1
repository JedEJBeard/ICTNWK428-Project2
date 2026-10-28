# Student Number: S4228356
# Student Full Name: Jed Ernest John Beard
#
# Windows.ps1 - Searches a directory for files of a given type
# and displays the results in a table.

# Ask the user for the directory and the file type to search for
$dir = Read-Host "Enter the directory to search (e.g. C:\)"
$type = Read-Host "Enter the file type to search for (e.g. *.ps1)"

# Check the directory exists before searching it
if (Test-Path -Path $dir) {
    # Search the directory and all sub-folders, then show the file name and location in a table
    Get-ChildItem -Path $dir -Filter $type -Recurse -ErrorAction SilentlyContinue | Select-Object Name,Directory | Format-Table -AutoSize
}
else {
    Write-Host "Directory not found"
}

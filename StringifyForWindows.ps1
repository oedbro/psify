param (
   [Parameter(Position=1)][string]$file = ""
   )


function psify {
    # Ensure there are exactly one parameter, otherwise show usage.
    if ($args.Count -ne 1) {
        return 'usage "StringifyForWindows Filepath"'
    }
    
    $filePath = $args[0]
    $fileName = [regex]::match($filePath, '([a-zA-Z.0-9]+)$').Groups[1].Value

    # Read the content of the file 
    $fileContent = Get-Content -encoding byte $filePath

    $encoded = [Convert]::ToBase64String( $fileContent )

    $newFilePath = $filePath + ".ps1"

    # If the file exists remove it
    if (Test-Path $newFilePath) 
    {
        Remove-Item $newFilePath
    }

    # Save the encoded file as a variable
    $scriptContent = "`$b64 = ""$encoded""`n" 
    # Add row to decode the file
    $scriptContent += "`$bytes = [System.Convert]::FromBase64String(`$b64)`n"
    $scriptContent += "[io.file]::WriteAllBytes('$fileName', `$bytes)`n"
    # Write the new script to a file 
    $scriptContent | Out-File $newFilePath
}


if ($file -ne "") 
{
    psify $file
}

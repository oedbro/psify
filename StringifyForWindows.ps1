param (
   [Parameter(Position=1)][string]$file = ""
   )

function base64Encode {
    # Ensure there are exactly one parameter, otherwise show usage.
    if ($args.Count -ne 1) {
        throw 'invalid variable passed to base64Encode'
    }

    # Convert to bytes
    # $bytes = $args[0] # [System.Text.Encoding]::Ascii.GetBytes($args[0])

    # base64Encode the content
    # $EncodedText =[Convert]::ToBase64String($bytes)

    $EncodedText = [Convert]::ToBase64String($args[0])

    return $EncodedText
}

function base64Decode {
    if ($args.Count -ne 1) {
        throw 'invalid variable passed to base64Deccode'
    }

    $DecodedText = [System.Convert]::FromBase64String($args[0])
    return $DecodedText
}

function psify {
    # Ensure there are exactly one parameter, otherwise show usage.
    if ($args.Count -ne 1) {
        return 'usage "StringifyForWindows Filepath"'
    }
    
    $filePath = $args[0]
    $fileName = [regex]::match($filePath, '([a-zA-Z.0-9]+)$').Groups[1].Value
    # Read the content of the file 
    $fileContent = Get-Content -encoding byte $filePath
    # [byte[]] $fileContent = [io.file]::ReadAllBytes($filePath)

    $encoded = base64Encode $fileContent

    $newFilePath = $filePath + ".ps1"

    # If the file exists remove it
    if (Test-Path $newFilePath) 
    {
        Remove-Item $newFilePath
    }

    # Save the encoded file as a variable
    $scriptContent = "`$b64 = ""$encoded""`n" 
    # Add row to decode the file
    #$scriptContent += "`$DecodedText = [System.Text.Encoding]::Ascii.GetString([System.Convert]::FromBase64String(`$bytes))`n"
    # $scriptContent += "`$DecodedText = [System.Convert]::FromBase64String(`$bytes)`n"
    # Write the file to disk
    #$scriptContent += "`$DecodedText | Out-File $fileName`n"
    $scriptContent += "`$bytes = [System.Convert]::FromBase64String(`$b64)`n"
    $scriptContent += "[io.file]::WriteAllBytes('$fileName', `$bytes)`n"
    # Write the new script to a file 
    $scriptContent | Out-File $newFilePath
}


if ($file -ne "") 
{
    psify $file
}

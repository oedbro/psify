    # param (
    #    [string]$server = "http://defaultserver",
    #    [Parameter(Mandatory=$true)][string]$username,
    #    [string]$password = $( Read-Host "Input password, please" )
    # )

    function base64Encode {
        # Ensure there are exactly one parameter, otherwise show usage.
        if ($args.Count -ne 1) {
            throw 'invalid variable passed to base64Encode'
        }

        # Convert to bytes
        $bytes = [System.Text.Encoding]::Ascii.GetBytes($args[0])

        # base64Encode the content
        $EncodedText =[Convert]::ToBase64String($bytes)

        return $EncodedText
    }

    function base64Decode {
        if ($args.Count -ne 1) {
            throw 'invalid variable passed to base64Deccode'
        }

        $DecodedText = [System.Text.Encoding]::Ascii.GetString([System.Convert]::FromBase64String($args[0]))
        return $DecodedText
    }

    function main {
        # Ensure there are exactly one parameter, otherwise show usage.
        if ($args.Count -ne 1) {
            return 'usage "StringifyForWindows Filepath"'
        }
        
        $filePath = $args[0]
        
        $fileContent = $filePath

        $bytes = [System.Text.Encoding]::Unicode.GetBytes($fileContent)

        $EncodedText =[Convert]::ToBase64String($bytes)
    }


    #main "Secret text to test"

    $test = base64Encode "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent at risus nec enim tincidunt accumsan nec ut mi. Suspendisse ut viverra velit. Donec vitae maximus augue. Donec iaculis tincidunt interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod ut ante eget laoreet. Suspendisse pellentesque tempor justo sed scelerisque. Suspendisse ut felis aliquet, condimentum elit eget, dictum nisl. Aliquam non nisl a tortor molestie condimentum. Sed a magna leo. "
    $test
    base64Decode $test

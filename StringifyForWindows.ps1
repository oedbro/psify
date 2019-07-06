# param (
#    [string]$server = "http://defaultserver",
#    [Parameter(Mandatory=$true)][string]$username,
#    [string]$password = $( Read-Host "Input password, please" )
# )

function main {
    # Ensure there are exactly one parameter, otherwise show usage.
    if ($args.Count -ne 1) {
        return 'usage "StringifyForWindows Filepath"'
    }
    
    $filePath = $args[0]
    


    
}


main $args

# psify

psify is a powershell script that can convert any file to a powershell script. This can be used to easaliy copy files between environments, for example *citrix*, where you can only copy text. by pasting the generated script into the powershell interperter the original file is recreated.

## Usage

There are two ways to use this script. 
1. To import the psify function to the interperter use `. .\psify.ps1`. By importing the script like this you can use `psify <path>` in that instance of powershell.

2. To run the script directly on a file, use `.\psify <path>`
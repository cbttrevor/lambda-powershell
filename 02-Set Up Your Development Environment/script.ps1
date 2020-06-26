# Install PowerShell github.com/powershell/powershell
# Install .NET SDK
# Install Visual Studio Code
# Install the PowerShell extension for Visual Studio Code
# Set up your AWS credentials

# Install using Scoop package manager on Windows (scoop.sh)
# The new Winget package manager preview is another good choice
scoop install vscode dotnet-sdk pwsh

# If you forget the name of the AWS Lambda module, you can search for it
Find-Module -Name *lambda*

# Install the Lambda module
Install-Module -Name AWSLambdaPSCore -Scope CurrentUser -Force

# Import the module (not always required, due to module auto-loading)
Import-Module -Name AWSLambdaPSCore

# Examine the commands in the module
Get-Command -Module AWSLambdaPSCore


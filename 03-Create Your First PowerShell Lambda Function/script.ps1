# Get help for initializing a new PowerShell Lambda function
# Get-Help -Name New-AWSPowerShellLambda

# Examine the blueprints built into the module
Get-AWSPowerShellLambdaTemplate

# Find an IAM Role that can be used to execute the Lambda function
Get-IAMRoleList | Where-Object -FilterScript { $PSItem.AssumeRolePolicyDocument -match 'lambda' } | Select-Object -Property Arn

# Publish the script to AWS Lambda
Publish-AWSPowerShellLambda -ScriptPath $PSScriptRoot/cbttest/cbttest.ps1 -Name cbtnuggets0333 -IAMRoleArn arn:aws:iam::665453315198:role/cbtnuggets03

# Invoke the function
$LMResult = Invoke-LMFunction -FunctionName cbtnuggets0333

# StatusCode = 200 doesn't mean the Lambda function succesfully executed!

# Read the results of the Lambda execution
[System.IO.StreamReader]::new($LMResult.Payload).ReadToEnd()
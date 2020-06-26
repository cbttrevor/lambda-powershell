# https://aws.amazon.com/blogs/developer/creating-a-powershell-rest-api/

# Install the AWS CLI
scoop install aws

# Create a new project if it doesn't exist
(Test-Path -Path $PSScriptRoot/EC2Shutdown) ? $null : (New-AWSPowerShellLambda -WithProject -Template Basic -Directory $PSScriptRoot/EC2Shutdown)

# Find an IAM Role to use for Lambda execution
Get-IAMRoleList | Where-Object -FilterScript { $PSItem.AssumeRolePolicyDocument -match 'lambda' } | Select-Object -Property Arn

# Create the local AWS PowerShell Lambda package
New-AWSPowerShellLambdaPackage -ProjectDirectory $PSScriptRoot/EC2Shutdown -OutputPackage $PSScriptRoot/EC2Shutdown.zip

# Transform and deploy the package to an S3 Bucket
aws cloudformation package --template-file $PSScriptRoot/template.ec2shutdown.yml --s3-bucket trevorcbt-usw2 --output-template-file $PSScriptRoot/template.ec2shutdown.modified.yml --profile cbt

# Deploy the Lambda package
aws cloudformation deploy --template-file $PSScriptRoot/template.ec2shutdown.modified.yml --stack-name EC2Shutdowner --capabilities CAPABILITY_IAM --profile cbt

# Examine AWS CloudFormation stacks
Get-CfnStack

# Clean up local items
# Remove-Item -Path $PSScriptRoot/template.ec2shutdown.modified.yml, $PSScriptRoot/*zip

$ApiEndpoint = (Get-CFNStack -StackName EC2Shutdowner).Outputs[0].OutputValue
$ApiEndpoint
Invoke-RestMethod -Uri $ApiEndpoint/ec2 -Method Post -Body @('i-07de4a0d32b8a14d3')
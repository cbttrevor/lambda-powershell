# Objective: Clean up AWS account resources with PowerShell

# Search for the module that you're looking for
Find-Module -Name aws*formation*

# Install the AWS CloudFormation module
Install-Module -Name AWS.Tools.CloudFormation -Scope CurrentUser -Force

# Shows commands exported by CloudFormation module
Get-Command -Module AWS.Tools.CloudFormation

# Retrieve CloudFormation stacks and remove them
Get-CFNStack | Remove-CFNStack -Force -StackName $PSItem.StackName

# Clean up IAM roles

Find-Module -Name aws*id*

Install-Module -Name AWS.Tools.IdentityManagement -Scope CurrentUser -Force

Get-Command -Module AWS.Tools.IdentityManagement -Name *role*

Get-IAMRoleList | Sort-Object -Property CreateDate

Remove-IAMRole -RoleName cbtnuggets03 -Force

Get-Command -Module AWS.Tools.IdentityManagement -Name *pol*


Get-IAMRolePolicyList -RoleName cbtnuggets03

Get-IAMAttachedRolePolicyList -RoleName cbtnuggets03 | % {
    Unregister-IAMRolePolicy -RoleName cbtnuggets03 -PolicyArn $PSItem.PolicyArn
}

Remove-IAMRole -RoleName cbtnuggets03 -Force
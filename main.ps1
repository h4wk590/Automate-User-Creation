Import-Module ActiveDirectory
Install-Module ImportExcel

# ITAS 280 Project 2 
# Aidan Brown
# This script will take columns from Excel file
# Adds 5 OUs to AD with Users from the Excel file in batches of 50
# Each User will get a U: home drive
# Each User will have to change their password on next login
# Login names for users will be first initial last name (abrown)


clear
# Reading the .xlxs file and creating headers in the file
$users = Import-Excel C:\project\Users.xlsx -HeaderName "firstName", "lastName"
# Creating username variable to be used as login and samaccount names


# Declare global variables for counting rows and groups to increment
$i = 0
$gi = 1

foreach ($user in $users) {
# Adding first name and last names of users from the Excel file.
$firstName = $($user."firstName")
$lastName = $($user."lastName")
# if the lastName cell is empty don't include the user.
if([string]::IsNullorEmpty($lastName)) {

Write-Host -ForegroundColor Red "User: $user has no lastname! `n"

} else {

# Setting variables in the loop
$fullName = "$firstName $lastName"
$firstinit = $firstName[0]
$sam = "$firstinit$lastName"
$sam = $sam.ToLower()
$group = "Group$gi"


    # Creating array with 'New-ADUser' fields
    # Utilizing concatination of variables
    $userParams = @{
        DisplayName =  "$firstName" 
        GivenName = "$firstName"
        Surname = "$lastName"
        Name = "$sam"
        UserPrincipalName = "$sam"
        Path =  "OU=$group,OU=project,DC=THESHIRE,DC=com"
        SamAccountName = "$sam"
        AccountPassword = ConvertTo-SecureString "Password01" -AsPlainText -Force
        Enabled = $true
        ChangePasswordAtLogon = $true
    }
# Add the new users from the array.
New-ADUser @userParams 

write-host "Adding $fullName to $group"

# Setting variables for user share location and drive letter
$share = "\\SCRIPTDC\share\"
$homeDir = "\\SCRIPTDC\share\{0}" -f $sam
$driveLetter = "U:\"

# Creating new Directory for users via SamAccountName
New-Item -Path "$share" -Name $sam -ItemType Directory -Force -ea stop 

# New array for User share and directory details using the Set-ADUser
$driveParams = @{
    Identity = "$sam"
    HomeDirectory = "$homeDir"
    HomeDrive = "$driveLetter"
    }
# Setting the new user share and directory
Set-ADUser @driveParams


    #$acl = Get-Acl "\\SCRIPTDC\share\$sam"

    #$acl.SetAccessRuleProtection($True,$False)
    #$UserRule = New-Object System.Security.AccessControl.FileSystemAccessRule("\\SCRIPTDC\Users","FullControl","ContainerInherit,ObjectInherit","None","Allow")
    #$acl.SetAccessRule($UserRule)
    #$AdminRule = New-Object System.Security.AccessControl.FileSystemAccessRule("\\SCRIPTDC\Administrators","FullControl","ContainerInherit,ObjectInherit","None","Allow")
    #$acl.SetAccessRule($AdminRule)
    #$acl | Set-Acl "\\SCRIPTDC\share\$sam"

    #Write-Host $acl

# If rows in csv is equal to 50 increment the group and add next set of 50 users.    
    $i++ 
if($i -eq 50) {
    $i=0
    $gi++
        }

    }

}

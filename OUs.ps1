# Reading the .xlxs file and creating headers in the file
$users = Import-Excel C:\project\Users.xlsx -HeaderName "firstName", "lastName"
# Creating username variable to be used as login and samaccount names
$username = "$firstName[0,1]$lastName"
$firstName = $users.firstName
$lastName = $users.lastName


$i = $users.Count

$g1 = "OU=project,OU=Group1,DC=THESHIRE,DC=com"
$g2 = "OU=project,OU=Group2,DC=THESHIRE,DC=com"
$g3 = "OU=project,OU=Group3,DC=THESHIRE,DC=com"
$g4 = "OU=project,OU=Group4,DC=THESHIRE,DC=com"
$g5 = "OU=project,OU=Group5,DC=THESHIRE,DC=com"
$g6 = "OU=project,OU=Group1,DC=THESHIRE,DC=com"

if ([string]::IsNullorEmpty($lastName)) {

Write-Host "user has no lastname! `n"

}Else{

forEach ($username in $users) {

New-ADUser 
-DisplayName: "$sam"
-GivenName: "$firstName"
-Surname: "$lastName"
-Name: "$firstName"
-Path: "OU=project,OU=Group1,DC=THESHIRE,DC=com" 
-SamAccountName: "$sam"
-Server: "SCRIPTDC.THESHIRE.com" 
-Type: "user" 
-UserPrincipalName: "$username@THESHIRE.com"
-AccountPassword: (ConvertTo-SecureString "Password01") -AsPlainText -Force

    
}

}

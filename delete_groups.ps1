# Cleanup OUs for testing script
 
Get-ADOrganizationalUnit -Filter 'Name -like "Group*"' | Set-ADObject -ProtectedFromAccidentalDeletion:$false -passthru | Remove-ADOrganizationalUnit -Confirm:$false -Recursive

Write-Host  -Background Red "Groups Deleted!"

Remove-Item -Recurse -Force U:\share\*

Write-Host -BackgroundColor red "U drives deleted!"

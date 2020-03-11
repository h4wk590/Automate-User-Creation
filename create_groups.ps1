#create 6 groups in Active Directory

    # Array containing the group names
    $groupNames = "Group1", "Group2", "Group3", "Group4", "Group5", "Group6"

    # Loop through the array and create a new OU per array object
    foreach ($OU in $groupNames)
    {
        New-ADOrganizationalUnit -Name $OU -Path "OU=project,DC=THESHIRE,DC=COM"
    }
                     
        write-host "Creating OUs for $groupNames"
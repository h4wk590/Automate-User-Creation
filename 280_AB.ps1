Import-Module ActiveDirectory

# ITAS 280 Project 2 
# Aidan Brown
# 14 Feb 2020

# This script will convert .xlsx file to csv
# Adds 5 OUs to AD with Users from the csv file in batches of 50
# Each User will get a U: home drive
# Each User will have to change their password on next login
# Login names for users will be first initial last name (abrown)


Function ExcelCSV ($File)
{
    # Find the location of the .xlxs file
    $excelFile = "c:\project\" + $File + ".xlsx"
    # Put Excel Application into object
    $Excel = New-Object -ComObject Excel.Application
    # Log output
    Write-Output "Opening Excel to view the file."
    # Make excel silently open
    $Excel.Visible = $false
    # Don't display alerts from Excel
    $Excel.DisplayAlerts = $false
    $wb = $Excel.Workbooks.Open($excelFile)
    # For each 
    foreach ($ws in $wb.Worksheets)
    {
        $ws.SaveAs("c:\project" + $File + ".csv", 6)
    }
    $Excel.Quit()
}
$FileName = "Users"
ExcelCSV -File "$FileName"



# This function creates 6 groups in Active Directory
Function createGroups
{
    # Array containing the group names
    $groupNames = "Group1", "Group2", "Group3", "Group4", "Group5", "Group6"

    # Loop through the array and create a new OU per array object
    foreach ($OU in $groupNames)
    {
        New-ADOrganizationalUnit -Name $OU -Path "OU=groups,DC=THESHIRE,DC=COM"
    }
                     
        write-host "Creating OUs for $groupNames"
}


Function addUsers

{
    # Import .csv to store in variable
    $adUsers = Import-Csv -Delimiter "," -Path "C:\*.csv"
    # set user info from csv
    foreach ($user in $adUsers)
{
    $userFirstname = $user.Firstname
    $userLastname = $user.Lastname
    $userfirstInit = $user.Firstname[1]
    $samAccountName = $userfirstInit + $userLastname 
      
    Write-Host Test
} if ($userLastname = null)
    
{
    
}

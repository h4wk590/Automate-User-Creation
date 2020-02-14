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
    
    $excelFile = "c:\project\" + $File + ".xlsx"
    $Excel = New-Object -ComObject Excel.Application
    Write-Output "Opening Excel to view the file."
    $Excel.Visible = $false
    $Excel.DisplayAlerts = $false
    $wb = $Excel.Workbooks.Open($excelFile)
    foreach ($ws in $wb.Worksheets)
    {
        $ws.SaveAs("c:\project" + $File + ".csv", 6)
    }
    $Excel.Quit()
}
$FileName = "Users"
ExcelCSV -File "$FileName"
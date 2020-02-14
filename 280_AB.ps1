Import-Module ActiveDirectory

Function ExcelCSV ($File)
{
 
    $excelFile = "c:\project\" + $File + ".xlsx"
    $Excel = New-Object -ComObject Excel.Application
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
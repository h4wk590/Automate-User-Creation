$share = "\\SCRIPTDC\share\"
$homeDir = "\\SCRIPTDC\share\{0} -f $sam"
$drive = "U:"

New-Item -Path "$share" -Name $sam -ItemType Directory -Force -ea stop 
$driveParams = @{

    Identity = "$sam"
    HomeDirectory = "$homeDir"
    HomeDrive = "$drive"

    }
Set-ADUser @driveParams

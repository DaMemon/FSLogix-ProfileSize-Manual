
$UNCPathProfile = "\\wch-app01\fslogixprofiles"
$Omitfolders = "\\wch-app01\fslogixprofiles\old"
$ProfileMaxSizeGB = "1"

$UNCPathO365 = "\\wch-app01\fslogixo365containers"
$ExcludeFolders = "\\wch-app01\fslogixo365containers\old"
$O365MaxSizeGB = "2"

$UNCPathCC = "\\wch-sqltest\cloudcacheprofilesbackup"
$ExemptFolders = "\\wch-sqltest\cloudcacheprofilesbackup\old"
$CCMaxSizeGB = "4"

function ProfileSize()
{
    Write-Host "Profile Folders List - $UNCPathProfile " -ForegroundColor DarkBlue -BackgroundColor Gray
    $LargeProfiles = Get-FolderSize -BasePath $UNCPathProfile -OmitFolders $Omitfolders | Where-Object 'Size(GB)' -GE $ProfileMaxSizeGB | Sort-Object 'Size(GB)'
    #$LargeProfiles | Out-GridView -Title " "
    $LargeProfiles | Format-Table 'FolderName' ,'Size(GB)'
   
}

function O365ProfileSize()
{
    Write-Host "O365 Profile Folders List - $UNCPathO365 " -ForegroundColor Green -BackgroundColor Black
    $LargeO365Profiles = Get-FolderSize -BasePath $UNCPathO365 -OmitFolders $ExcludeFolders | Where-Object 'Size(GB)' -GE $O365MaxSizeGB | Sort-Object 'Size(GB)'
    #$LargeO365Profiles |Out-GridView -Title " "
    $LargeO365Profiles | Format-Table 'FolderName' ,'Size(GB)'
    
}

function CloudCacheProfileSize()
{
    Write-Host "CloudCache Folders List - $UNCPathCC " -ForegroundColor Red -BackgroundColor Yellow
    $FolderTotalSize = Get-FolderSize -BasePath $UNCPathCC -OmitFolders $ExemptFolders | Where-Object 'Size(GB)' -GE $CCMaxSizeGB | Sort-Object 'Size(GB)'
    $FolderTotalSize | Format-Table 'FolderName' ,'Size(GB)'
}

ProfileSize
O365ProfileSize
CloudCacheProfileSize

#----------- End of the Script ----------#

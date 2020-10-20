#requires -module PSFolderSize

<#
.SYNOPSIS
   Measure the size of the Profile Folders and O365 Container and print nicely in PowerShell.

.Description
  Gets information about the FSLogix Profile Container and O365 Containers if the Max Size(in GB) is larger than the value provided.
      This is manual process where an IT person run the command to check folder size. You can automate it with Task Scheduler
          Exclude Folder is Optional
            You can use GRID-VIEW as well if you like.
		
.EXAMPLE
	.NormalOutputFolderSizeVHDX.ps1
	    
.NOTES
  - UNCPathProfile = Either folder on the server or network location
  - Omitfolders (Optional) = Either folder on the server or network location 
  - ProfileMaxSizeGB = required size or warning limit
  - UNCPathO365 = Either folder on the server or network location
  - O365MaxSizeGB = required size or warning limit
	
    Author: Fahad Tabani
#>

$UNCPathProfile = "Folder name"
$Omitfolders = "optional"
$ProfileMaxSizeGB = "5"

$UNCPathO365 = "Folder name"
$ExcludeFolders = "Optional"
$O365MaxSizeGB = "12"


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

ProfileSize
O365ProfileSize


<#----------- End of the Script ----------Written by: Fahad Tabani #>

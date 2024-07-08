## 
#
#  Assign Groups
# Author Maarten Camps
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # 



Connect-MgGraph -Scopes "User.Read.All", "Group.Read.All", "Device.Read.All"

$users = Import-Csv C:\temp\users.csv   #'.\MG Groups\Users.csv'
$LicenseGroupID = 
$ItemInsightsGroupID = 
$OfficeUpgradeGroupID = 

foreach ($User in $users) {
    $UPN = $User.UPN
    $UserID = get-MGuser -UserId $UPN | Select ID 
    $ID = $UserID.Id

    # Assign user to License Group
    Write-Output "Add $UPN to Copilot License Group"
    New-MgGroupMember -GroupId $LicenseGroupID -DirectoryObjectId $ID

    #Enable Item insights for the Specific User 

    Write-Output "Enable Iteminsights for $upn" 
    Remove-MgGroupMemberByRef -GroupId $ItemInsightsGroupID -DirectoryObjectId $ID

    #Get User Device info

    $Devices = Get-MgUserRegisteredDevice -UserId $ID
    foreach ($D in $devices){
        $Device = Get-MgDevice -DeviceId $D.id
        if ($Device.DisplayName -match "AEDW10-"){
            $deviceID = $D.Id
            Write-Output "upgrade office for $device."DisplayName""
            New-MgGroupMember -GroupId $OfficeUpgradeGroupID -DirectoryObjectId $deviceId
            
        }
    
    }

}
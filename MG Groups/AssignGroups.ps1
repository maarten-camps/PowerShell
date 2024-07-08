## 
#
#  Assign Groups
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # 

Connect-MgGraph -Scopes "User.Read.All", "Group.Read.All", "Device.Read.All"

$users = Import-Csv C:\temp\users.csv   #'.\MG Groups\Users.csv'
$LicenseGroupID = "" # Add ID of License Security Group
$ItemInsightsGroupID = "" # Add ID of Group to enable ItemInsights
$OfficeUpgradeGroupID = "" #Add ID of group for OfficeUpgrade
$DeviceNameStart = "" #Enter Device name to filter

foreach ($User in $users) {
    $UPN = $User.UPN
    $UserID = get-MGuser -UserId $UPN | Select ID
    $ID = $UserID.Id

    # Assign user to License Group
    Write-Output "Add $UPN to Copilot License Group"
    New-MgGroupMember -GroupId $LicenseGroupID -DirectoryObjectId $ID

    #Enable Item insights for the Specific User, Item Insights is disable fro a specific group os user , Enabling requires to remove those users from the group.

    Write-Output "Enable Iteminsights for $upn" 
    Remove-MgGroupMemberByRef -GroupId $ItemInsightsGroupID -DirectoryObjectId $ID

    #Get User Device info and add device to specific group

    $Devices = Get-MgUserRegisteredDevice -UserId $ID
    foreach ($D in $devices){
        $Device = Get-MgDevice -DeviceId $D.id
        if ($Device.DisplayName -match $DeviceNameStart){
            $deviceID = $D.Id
            Write-Output "upgrade office for $device."DisplayName""
            New-MgGroupMember -GroupId $OfficeUpgradeGroupID -DirectoryObjectId $deviceId
            
        }
    
    }

}
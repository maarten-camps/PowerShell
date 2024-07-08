## 
#
#  Assign Groups
# Author Maarten Camps
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # 



#Connect-MgGraph -Scopes "User.Read.All", "Group.Read.All"

$users = Import-Csv C:\temp\users.csv   #'.\MG Groups\Users.csv'
$LicenseGroupID = 
$ItemInsightsGroupID = 
$OfficeUpgradeGroupID = 

foreach ($User in $users) {
    $UPN = $User.UPN
    $UserID = get-MGuser -UserId $UPN | Select ID 
    $ID = $UserID.Id

    # Assign user to License Group
    New-MgGroupMember -GroupId $LicenseGroupID -DirectoryObjectId $ID

    #Enable Item insights for the Specific User 

    Remove-MgGroupMemberByRef -GroupId $ItemInsightsGroupID -DirectoryObjectId $ID

    #Get User Device info

    #Add device to Secrity Group
    
}

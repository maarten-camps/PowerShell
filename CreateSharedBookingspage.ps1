
Select-MgProfile beta
Connect-MgGraph -Scopes "User.Read.All", "Bookings.Manage.All", "Bookings.Read.All", "Bookings.ReadWrite.All", "BookingsAppointment.ReadWrite.All" | Out-null

#Variables
$Role = "administrator" #defines role for Bookingpage staff member
$BusinessName = Read-Host "Please enter the Name of the bookingspage" #Name of the shared bookingspage must be entered NO SPECIALCHARACTERS
$BusinessIDName = $BusinessName.Replace(" ","")
$BusinessID = "$BusinessIDName@domain.onmicrosoft.com" #BusinessID is created based on name
$Admin1 = read-host "please eneter UPN of ADMin 1" #UPN for the 1st Booking admin must be entered
$entraAdmin1 = get-mguser -UserId $Admin1 #Get all userinfo from admin 1
$Admin2 = read-Host "Please enter UPN of Admin 2" #UPN for the 2nd Booking admin must be entered
$entraAdmin2 = get-mguser -UserId $Admin2 #Get all userinfo from admin 2

#Create the Shared Bookingspage
Write-Host "Shared Bookingspage $BusinessName is created"
$NewBookingspage = New-MgBookingBusiness -DisplayName $BusinessName -DefaultCurrencyIso "eur" -Email $BusinessID
#Wait one minute 
Start-Sleep -Seconds 60
#Add the Admins
Write-Host "$entraAdmin1.DisplayName will be assigned admin to $BusinessName"
New-MgBookingBusinessStaffMember -BookingBusinessId $newbookingspage.Id -EmailAddress $entraAdmin1.UserPrincipalName -Role $Role -DisplayName $entraAdmin1.DisplayName
write-host "$entraAdmin2.DisplayName will be assigned admin to $BusinessName"
New-MgBookingBusinessStaffMember -BookingBusinessId $newbookingspage.Id -EmailAddress $entraAdmin2.UserPrincipalName -Role $Role -DisplayName $entraAdmin2.DisplayName

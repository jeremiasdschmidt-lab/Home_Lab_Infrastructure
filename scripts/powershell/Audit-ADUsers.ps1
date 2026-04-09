# Audit Inactive Users in Active Directory
$DaysInactive = 90
$InactiveDate = (Get-Date).AddDays(-$DaysInactive)

Write-Host "Searching for users inactive since $InactiveDate..." -ForegroundColor Yellow

$Users = Get-ADUser -Filter {LastLogonDate -lt $InactiveDate -and Enabled -eq $true} -Properties LastLogonDate

if ($Users) {
    foreach ($User in $Users) {
        Write-Host "Inactive User Found: $($User.SamAccountName) - Last Logon: $($User.LastLogonDate)" -ForegroundColor Red
    }
} else {
    Write-Host "No inactive users found." -ForegroundColor Green
}

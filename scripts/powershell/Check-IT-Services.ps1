# Command-Line argument for specifying Gateway
param(
	[Parameter(Mandatory=$true, HelpMessage="Please provide a valid Gateway IP address. Common ones ares: 192.168.1.1, 192.168.0.1, 10.0.0.1")]
	[string]$Gateway
)

# Check Status of Critical IT Services
$Services = @("DNS", "ADWS", "ntds") # DNS, AD Web Services, and Active Directory Domain Services

Write-Host "--- IT Infrastructure Health Check ---" -ForegroundColor Cyan

foreach ($Service in $Services) {
    $Status = Get-Service -Name $Service -ErrorAction SilentlyContinue
    
    if ($Status.Status -eq "Running") {
        Write-Host "[PASS] Service '$Service' is running." -ForegroundColor Green
    } else {
        Write-Host "[FAIL] Service '$Service' is STOPPED!" -ForegroundColor Red
    }
}

# Simple connectivity test to the Gateway
if (Test-Connection -ComputerName $Gateway -Count 1 -Quiet) {
    Write-Host "[PASS] Network Gateway is reachable." -ForegroundColor Green
} else {
    Write-Host "[FAIL] Network Gateway is unreachable!" -ForegroundColor Red
}

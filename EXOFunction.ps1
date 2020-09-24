# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format
$currentUTCtime = (Get-Date).ToUniversalTime()

# The 'IsPastDue' porperty is 'true' when the current function invocation is later than scheduled.
if ($Timer.IsPastDue) {
    Write-Host "PowerShell timer is running late!"
}

# Write an information log with the current time.
Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"

$certhumbprint = $env:AuthCertThumbprint
$clientid  = $env:ClientID
$tenant = $env:TenantName
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -CertificateThumbprint $certhumbprint -AppId $clientid -Organization $tenant -InformationAction Ignore


#Loop through each mailbox and disable IMAP
$imapmbx = Get-CasMailbox -Filter {IMAPEnabled -eq $True -and Name -notlike "DiscoverySearchMailbox*"} 
Write-Output "Found $imapmbx.count mailboxes with IMAP enabled"
foreach($mbx in $imapmbx)
{
    try{
        Write-Output "Attempting to disable IMAP for $($mbx.Identity)"
        Set-CasMailbox -Identity $mbx.ExternalDirectoryObjectId -IMAPEnabled $False -ErrorAction Stop
    }
    catch{
        Write-Error "Failed to disable IMAP for $($mbx.Identity)"
    }
}
# FindNetworkDrives
## Short Summary
A function that searches the registry hive on a domain computer to find a domain user's network drives.

## Requirements
You will need to know the username of the user. 
Therefore the Active Directory module must be installed and accessible.
HKEY_USERS requires mapping in PSDrives. A process completed in the function, and removes itself thereafter.

## Process
The process searches Active Directory for the requested username and converts it to the SID value.
The console will also create a temporary PS Drive for HKEY_USERS. 
The console will navigate to the location 'HKU:\SID\Network' and return the network drives listed under the SID key relating to the user.
After the data is returned, the drive is removed, and the original working directory is set.

## Some Other RegEdit Notes
### Container creation
New-Item -Path 'HKLM:\software\classes\http\shell\open\command' -Type container
### Key creation
The below sets the default application for http to Firefox:
Set-ItemProperty -Path 'HKLM:\software\classes\http\shell\open\command'  -Name '(default)' -Value '"C:\Program Files\Mozilla Firefox\firefox.exe" %1'
### List containers/keys in a given container
Get-Item HKLM:\software\classes\http\shell\open
Get-Item HKLM:\software\classes\http\shell\open\command
### Remove keys
Remove-ItemProperty -Path 'HKLM:\software\classes\http\shell\open\command'  -Name DelegateExecute
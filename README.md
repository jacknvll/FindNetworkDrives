# FindNetworkDrives
## Short Summary
A function that searches the registry hive on a domain computer to find a domain user's network drives.

## Business Case
The reason I was interested in creating this function came from an environment I once reviewed. 

I know there are batch files you can run to export drive mappings to a txt file, and have this running from a logon script. But what if your AD User already had a logon script in place? And there was no way to modify due to decades of crappy coding already within... 

In the experienced environment, Group Policy was enabled, and yet so were logon scripts. The logon script was convoluted with  out-of-date actions, and was managed by another team. Hence, it was time to create a function I could run remotely using only PowerShell code.

## Requirements
You will need to know the username of the user. 
Therefore the Active Directory module must be installed and accessible.
HKEY_USERS requires mapping in PSDrives. A process completed in the function, and removes itself thereafter.

## Process
The process searches Active Directory for the requested username and converts it to the SID value.
The console will also create a temporary PS Drive for HKEY_USERS. 
The console will navigate to the location 'HKU:\SID\Network' and return the network drives listed under the SID key relating to the user.
After the data is returned, the drive is removed, and the original working directory is set.

## Other Functions
To neaten up the main function, there are three functions that are called upon.
### TestHiveExistance.ps1
Checks existing PS Drives for Registry types and creates a drive otherwise. In the main function, we specify check for a drive targeting HKEY_USERS, and create if non-existant.
### TestModuleReady.ps1
Checks validity of the Active Directory module installed on the running computer. The function will import module if found, or provide an error if not.
### TestDomainConnection.ps1
To gain the SID of a domain user from Active Directory the running computer must be able to communicate to a Domain Controller in the network. This function will confirm a valid connection.
## Potential Upgrades:
### Domain/Local
Specify wheter you are looking for information on a domain or a local user. If local, there is no need to call upon Active Directory. Instead you may be using WMIC or 'net user' commands.
### Remote Computer
The endgame is to be able to run the function remotely on another computer. The power of this function really becomes known as the capability will save everyone's time. Simply by typing Find-NetworkDrives -ComputerName comp01 -Identity tom.smith
### Multiple Remote Computers
The ComputerName parameter would need to have the ability to pipe multiple values. Similar with the Identity. You may have a CSV that contains computer names and usernames, and you want to find the details.
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
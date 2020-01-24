# FindNetworkDrives
 A script to find network drives from the registry hive
To find what network drives are installed, you will need to know the SID of the user
Then you can check the registry hive HKU. but this is not accessible by powershell by default. you would need to create a new ps drive
Having stored ther AD User's SID into a variable, you can then set the location to the network drives in:
HKU:\SID\Network

Other important commands:
Container creation
New-Item -Path 'HKLM:\software\classes\http\shell\open\command' -Type container
Key creation
Set-ItemProperty -Path 'HKLM:\software\classes\http\shell\open\command'  -Name '(default)' -Value '"C:\Program Files\Mozilla Firefox\firefox.exe" %1'

List containers/keys in a given container:
Get-Item HKLM:\software\classes\http\shell\open
Get-Item HKLM:\software\classes\http\shell\open\command

Remove keys:
Remove-ItemProperty -Path 'HKLM:\software\classes\http\shell\open\command'  -Name DelegateExecute
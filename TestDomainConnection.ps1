#Test you have a stable connection to the DC when searching for a domain account.
function Test-DomainConnectivity
{
    try {
        $Connectivity = (Test-Connection 'fme.ads.fresenius.com' -Count 4 -ErrorAction SilentlyContinue | Measure-Object).Count
    }
    catch {Continue}

    if ($Connectivity -eq 4){return $true}
    else {return $false}
}
cls

$gitURL = "https://raw.github.com/patrickmcclory/RightScalePowerShell/master/getRSPosh"
$dplyRSPosh 	= "deployrsps.ps1"
$dplyRSPoshManifest = "manifest.rsposh.xml"

$srcDply		= $gitURL + "/" + $dplyRSPosh
$srcDplyManifest	= $gitURL + "/" + $dplyRSPoshManifest

$destFolder 	= "c:\RSTools\RSPSShell"

$destDplyFile 		= "$destFolder\$dplyRSPSShell"
$destMfstFile 		= "$destFolder\$dplyRSPSShellManifest"


if(!(Test-Path $destFolder)){New-Item -Path $destFolder -ItemType directory -Force}

$webclient = New-Object system.Net.WebClient

try
{
	write-host "GETRSPOSH`: Downloading file - $dplyRSPSShell"
    write-host "GETRSPOSH`: Src path - $srcDply"
	$webclient.downloadfile($srcDply,$destDplyFile)
}
catch [System.Net.WebException]
{
		if($_.Exception.InnerException)
		{
			Write-Host "GETRSPOSH`: Error downloading source - $($_.exception.innerexception.message)"
		}
		else
		{
			Write-Host "GETRSPOSH`: Error downloading source - $_"
		}
	
}

try
{
		write-host "GETRSPOSH`: Downloading file - $dplyRSPSShellManifest"
                write-host "GETRSPOSH`: Src path - $dplyRSPSShellManifest"

		$webclient.downloadfile($srcDplyManifest,$destMfstFile)
}
catch [System.Net.WebException]
{
		if($_.Exception.InnerException)
		{
			Write-Host "GETRSPOSH`: Error downloading source - $($_.exception.innerexception.message)"
		}
		else
		{
			Write-Host "GETRSPOSH`: Error downloading source - $_"
		}
	
}


set-location $destFolder
. .\$dplyRSPosh
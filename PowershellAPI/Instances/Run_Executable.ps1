$cloud_id=""
$instance_id="" #Instance ID

$postURL = "https://my.rightscale.com/api/clouds/$cloud_id/instances/$instance_id/run_executable.xml"
$stringToPost = 'recipe_name=sys_firewall::setup_rule&'+
'inputs[][name]=sys_firewall/rule/enable&inputs[][value]=text:enable&' +
'inputs[][name]=sys_firewall/rule/ip_address&inputs[][value]=text:any&inputs[][name]=sys_firewall/rule/port&'+
'inputs[][value]=text:22&inputs[][name]=sys_firewall/rule&inputs[][value]=text:tcp'
$bytesToPost = [System.Text.Encoding]::UTF8.GetBytes($stringToPost)
$webRequest.CookieContainer = $cookieContainer

$webRequest = [System.Net.WebRequest]::Create($postURL)
$webRequest.Method = "POST"
$webRequest.Headers.Add("X_API_VERSION","1.5")
$webRequest.CookieContainer = $cookieContainer # recieved from authentication.ps1

$requestStream = $webRequest.GetRequestStream()
$requestStream.Write($bytesToPost, 0, $bytesToPost.Length)
$requestStream.Close()

[System.Net.WebResponse]$response = $webRequest.GetResponse()
$responseStream = $response.GetResponseStream()
$responseStreamReader = New-Object System.IO.StreamReader -ArgumentList $responseStream
[string]$responseString = $responseStreamReader.ReadToEnd()



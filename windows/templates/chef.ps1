
add-type @"
  using System.Net
  using System.Security.Cryptography.X509Certificates;
  public class TrustAllCertsPolicy : I CertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificates certificates,
        WebRequest request, int certificateProblem) {
            return true;
        }
  }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
$pemurl = "${chef_validation_key_url}"
$dest ="c:\chef\validator.pem"
New-Item -Path c:\chef -ItemType directory
Invoke-WebRequest $pemurl -OutFile $dest

$chef_source_msi = "<location source of chef-client-13.7.16-1.msi file"
$chef_target_msi = "c:\windows\temp\chef-client-13.7.16-1.msi"
Invoke-WebRequest $pchef_source_msi -OutFile $chef_target_msi

start-process -FilePath msiexe.exe -ArgumentList "/qn /i c:\windows\temp\chef-client-13.7.16-1.msi" -Wait

# create first-boot.json

$firstboot = @{
    "run_list" = @("${chef_server_run_list}")
}

Set-Content -Path c:\chef\first-boot.json -Value ($firstboot | ConvertTo-Json -Depth 10)

# create client.rb

$nodeName = $env:COMPUTERNAME

$clientrb = @"
chef_server_url             '${chef_server_url}'
validation_client_name      '${chef_validation_client_name}'
validation_key              'C:\chef\validator.pem'
node_name                   '{0}'
ssl_verify_mode             :verify_none
verify_api_cert             false
environment                 '${chef_environment}'
"@ -f $nodeName

Set-Content -Path c:\chef\client.rb -Value $clientrb

# Run chef

C:\opscode\chef\bin\chef-client.bat -j C:\chef\first-boot.json
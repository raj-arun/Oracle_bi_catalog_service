
##Invoke the Web Service
[Net.ServicePointManager]::SecurityProtocol = "tls12"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('SOAPAction','')
Invoke-WebRequest https://<url to oracle cloud instance>.oraclecloud.com/xmlpserver/services/v2/CatalogService?wsdl `
-Method Post -ContentType "text/xml;charset=utf-8" -Headers $headers `
-InFile soap.xml -OutFile output.xml

##Load the XML
[xml]$xml = Get-Content 'output.xml'
$reports = $xml.SelectNodes('//*')

##Loop through the XML and print the report details
foreach ($report in $reports.Body.getFolderContentsResponse.getFolderContentsReturn.catalogContents.item) {
  if ($report.type -eq "Report"){
        Write-Output "Report Name : $($report.displayName)"
        Write-Output "Report Path : $($report.absolutePath)"
    }
}
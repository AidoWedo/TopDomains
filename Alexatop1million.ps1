# Author AidoWedo
# Powershell Script to Pull down top 1 million Alex Domains and select the top 10000 only
# Replace c:\file\path\ with something that makes sense to you

Invoke-WebRequest -Uri "http://s3.amazonaws.com/alexa-static/top-1m.csv.zip" -OutFile "C:\file\path\Output\alexatop1mill.csv.zip"

Expand-Archive -Force -Path "C:\file\path\Output\alexatop1mill.csv.zip" -DestinationPath "C:\file\path\Output\alexatop1mill"

$csv = Import-Csv "C:\file\path\Output\alexatop1mill\top-1m.csv" -Header Rank,Domain | select -First 10000 domain | Export-Csv  "C:\file\path\Output\alexatop10000.csv"

# Skip the top 2 lines which seems to be PSObject and Headers

$content = Get-Content "C:\file\path\Output\alexatop10000.csv" | Select-Object -Skip 2

# Replace "aroundcontent" with nothing and output

$newcontent = $content -replace '"', ''| Out-File "C:\file\path\Output\alexatop10000.txt" -Encoding utf8

# Wait to make sure the file is created

while (!(Test-Path "C:\file\path\Documents\Output\alexatop1mill\top-1m.csv")) { Start-Sleep 10 }


# Move this file to C:\Program Files\LogRhythm\LogRhythm Job Manager\config\list_import the default location on a LogRhythm Enterprise SIEM XM or PM for auto import
# List Manager must have this as the name of the file to import and this needs to be a general value and you must have selected Domain impacted and Origin

Move-Item -Path "C:\file\path\alexatop10000.txt" -Destination "C:\Program Files\LogRhythm\LogRhythm Job Manager\config\list_import\alexatop10000.txt"
$uris = Import-CSV .\settings.csv

$destination = "C:\Users\kourf\Pictures\Backgrounds"

IF(!(Test-Path $destination)) {New-Item -Path $destination -ItemType Directory -Force | Out-Null}

foreach ($uri in $uris){
    Invoke-RestMethod $uri.URI -Method Get -Body @{limit=$uri.Limit} | %{$_.data.children.data.url} | ?{ $_ -match "\.jpg$" } | Foreach {Start-BitsTransfer -Source $_ -Destination $destination }
}
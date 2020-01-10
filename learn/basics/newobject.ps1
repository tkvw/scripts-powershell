

# Create Webclient with CachePolicy property set
(New-Object System.Net.WebClient -Property @{CachePolicy=(New-Object System.Net.Cache.RequestCachePolicy -ArgumentList BypassCache)}).DownloadString("https://www.nu.nl/rss/Algemeen")


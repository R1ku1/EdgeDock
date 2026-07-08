param(
    [double]$lat,
    [double]$lon,
    [string]$unit = "celsius"
)

# Fetch current weather
$url = "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&temperature_unit=$unit"
try {
    $data = Invoke-RestMethod -Uri $url -TimeoutSec 15 -UserAgent "Rainmeter/1.0"
} catch {
    # If the request fails, write a fallback
    "0" | Out-File -FilePath $PSScriptRoot\weather.txt -Encoding utf8
    "3200" | Out-File -FilePath $PSScriptRoot\weather.txt -Encoding utf8 -Append
    exit
}

$temp = [math]::Round($data.current_weather.temperature)
$code = $data.current_weather.weathercode

# Map weather code to classic icon number (same as your Substitute table)
$iconMap = @{
    0  = 32; 1  = 34; 2  = 30; 3  = 26
    45 = 20; 48 = 20; 51 = 9;  53 = 9;  55 = 9
    56 = 8;  57 = 8;  61 = 11; 63 = 12; 65 = 40
    66 = 10; 67 = 10; 71 = 13; 73 = 16; 75 = 41
    77 = 13; 80 = 39; 81 = 40; 82 = 4;  85 = 42
    86 = 43; 95 = 4;  96 = 3;  99 = 3
}
$icon = if ($iconMap.ContainsKey($code)) { $iconMap[$code] } else { 3200 }

# Write to the text file
"$temp" | Out-File -FilePath $PSScriptRoot\weather.txt -Encoding utf8
"$icon" | Out-File -FilePath $PSScriptRoot\weather.txt -Encoding utf8 -Append
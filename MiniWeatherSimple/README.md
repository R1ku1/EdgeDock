# MiniWeatherSimple

A lightweight, robust Rainmeter weather skin that displays the current temperature and a matching weather icon for any city. It uses Open-Meteo for weather data and a tiny PowerShell script for fetching.

## ✨ Features

- **Clean display** – icon + temperature, nothing else.
- **Automatic geocoding** – just type the city name, no latitude/longitude needed.
- **Reliable data** – uses a PowerShell script to fetch weather, bypassing Rainmeter’s sometimes flaky native HTTP requests.
- **Monochrome / colour toggle** – switch between full-colour icons and a tinted white look via right-click.
- **Proportional scaling** – change one variable (`IconScale`) to resize the whole widget (icon + text) while keeping everything perfectly aligned.
- **Auto-refresh** – updates every 30 minutes, light on your API calls.
- **Fallback icon** – displays a placeholder icon (`3200.png`) while data loads, so you never see an error.

## 📥 Installation

1. Make sure [Rainmeter](https://www.rainmeter.net/) is installed.
2. Download or copy the `MiniWeatherSimple` folder into your Rainmeter Skins folder, usually:

```bash
Documents\Rainmeter\Skins\
```

3. **Set PowerShell execution policy** (one-time only). Open PowerShell as Administrator and run:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

This allows the `GetWeather.ps1` script to run.

4. Right-click the Rainmeter system tray icon → **Skins → MiniWeatherSimple → MiniWeatherSimple.ini** to load the skin.

## 🖱️ Usage

Once loaded, you’ll see the current temperature and weather icon for the default city (Sydney).

- **Change city** – right-click the skin, choose **Edit Location / Settings**, and modify the `WeatherLocation` variable. Use `+` for spaces (e.g., `New+York`).
- **Switch between °C / °F** – right-click → **Use Celsius** or **Use Fahrenheit**.
- **Toggle icon style** – right-click → **Monochrome White Icon** or **Full Colour Icon**.
- **Resize the widget** – edit the `IconScale` variable (see below).

## ⚙️ Customisation

Edit `MiniWeatherSimple.ini` (right-click → **Edit Location / Settings**) and change the variables under `[Variables]`:

| Variable | Default | What it does |
| --- | --- | --- |
| `WeatherLocation` | Sydney | City name (no country code, spaces as `+`). Example: `Los+Angeles` |
| `WeatherUnit` | celsius | `celsius` or `fahrenheit` (can also be toggled via right-click) |
| `IconScale` | 1 | Multiplier for the whole widget size. `1.5` = 50% larger. |
| `FontBaseSize` | 36 | Base font size of the temperature (scaled by `IconScale`). Adjust to balance text vs icon. |
| `Gap` | 5 | Space (pixels) between the icon and the temperature text. |
| `IconGreyscale` | 0 | `1` = monochrome (white tint), `0` = full colour. |
| `IconTint` | 255,255,255 | RGB colour when `IconGreyscale=1`. Set to e.g. `255,200,100` for a warm tint. |

After changing a variable, refresh the skin (**right-click → Refresh skin**).

## 🖼️ Icon set

The skin expects numbered PNG icons (e.g., `32.png`, `34.png`) inside the `WeatherIcons` subfolder.

It uses the classic `0-47` icon numbering. If you downloaded a compatible icon pack, just place the files there.

The fallback icon `3200.png` is shown when no data is yet available. You can replace it with your own generic weather icon.

## 🔧 How it works

### Geocoding

Rainmeter’s WebParser asks Open-Meteo for coordinates of the city you set.

### Fetching weather

Once coordinates are known, a small PowerShell script (`GetWeather.ps1`) calls the Open-Meteo API and writes temperature + icon code to `weather.txt`.

### Display

Rainmeter reads `weather.txt`, maps the weather code to an icon number, and shows the image + temperature.

The whole process is triggered automatically on skin load and every 30 minutes thereafter.

All network requests are done by PowerShell, which uses the same networking stack as your browser – no more random timeouts.

## 🐛 Troubleshooting

### The skin shows `3200.png` and no temperature?

Wait a few seconds. If it doesn’t update, refresh the skin manually.

Check that:

- `GetWeather.ps1` is in the same folder.
- PowerShell execution policy is set to `RemoteSigned`.

### "Unable to open … WeatherIcons\ .png"?

This can appear for a split second on first load – it’s harmless and disappears as soon as data arrives.

If it persists:

- Verify that the `WeatherIcons` folder exists.
- Ensure it contains numbered PNG files (at least `3200.png`).

### Temperature shows `Â°`?

The skin uses `[\x00B0]` for the degree sign, which avoids encoding issues.

If you still see garbage:

- Ensure your `.ini` file is saved as UTF-8 with BOM or ANSI.
- The built-in `[\x00B0]` should prevent this entirely.

### PowerShell script won’t run?

Try running it manually once:

```powershell
.\GetWeather.ps1 -lat -33.87 -lon 151.21 -unit celsius
```

If you get an execution policy error, re-run:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

as Administrator.

## 📜 License & Credits

Weather data by Open-Meteo, free for non-commercial use.

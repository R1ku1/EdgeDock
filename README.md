# EdgeDock

A minimal, auto-hiding icon dock for [Rainmeter](https://www.rainmeter.net/), built to stay
completely out of the way until you need it.

Move your cursor to the left edge of the screen, and a small vertical dock of
app/game icons fades and slides into view. Hover an icon and it grows,
reveals its name, and gently pushes the icons below it out of the way to
make room. Move away, and it disappears again.

## Features

- **Auto-hide** — invisible until the cursor nears the screen edge
- **Smooth animation** — fade + slide reveal, and eased grow/shrink on
  hover (no instant snapping), driven by small Lua tween scripts
- **Dock-style magnification** — hovering an icon grows it and displaces
  the icons below proportionally, blending smoothly even between
  overlapping hovers
- **Monochrome by default** — icons sit desaturated at rest, and reveal
  full color on hover
- **Config-driven** — icons are defined in a single `games.json` manifest;
  a Python script regenerates the whole skin from it, so adding, removing,
  or reordering icons never requires hand-editing Rainmeter's `.ini` syntax

## Requirements

- [Rainmeter](https://www.rainmeter.net/) (4.0+, for the `Greyscale` meter option)
- Python 3.7+ (only needed if you want to regenerate the dock — the
  generated `Icons.ini` runs standalone without Python installed)

## Folder structure

```bash
EdgeDock/
├── Icons.ini          <- generated; do not hand-edit
├── games.json          <- edit this to add/remove/reorder icons
├── generate_dock.py    <- regenerates Icons.ini from games.json
├── assets/              <- icon .png files live here
└── Scripts/
    ├── Fade.lua         <- dock-wide reveal/hide animation
    └── Tween.lua        <- per-icon grow/shrink animation
```

## Setup

1. Clone/copy this folder into your Rainmeter `Skins` directory.
2. Extract icons for whatever you want in the dock. From PowerShell:

   ```powershell
   Add-Type -AssemblyName System.Drawing
   $icon = [System.Drawing.Icon]::ExtractAssociatedIcon("C:\Path\To\App.exe")
   $bitmap = $icon.ToBitmap()
   $bitmap.Save("assets\myapp.png", [System.Drawing.Imaging.ImageFormat]::Png)
   ```

3. Add an entry to `games.json`:

   ```json
   {
     "id": "MyApp",
     "name": "My App",
     "image": "myapp.png",
     "shortcut": "C:\\Users\\you\\Desktop\\My App.lnk"
   }
   ```

4. Run the generator:

   ```bash
   python generate_dock.py
   ```

   It will warn you if `games.json` and `assets/` are out of sync (missing
   images, or images with no manifest entry), then regenerate `Icons.ini`.

5. In Rainmeter: right-click the skin → **Refresh Skin**.

## Tuning

- Animation speed: edit the `speed` value in `Scripts/Fade.lua` (dock
  reveal) or `Scripts/Tween.lua` (icon grow/shrink)
- Layout (icon size, hover size, spacing, hotspot size): edit the
  constants at the top of `generate_dock.py`, then re-run it

## Credits

Originally based on the *Verticons* Rainmeter skin template by
Irfan Fadilah (WTFPL). Since heavily reworked with an auto-hide hotspot,
Lua-driven animation, magnification cascade, and a Python config
generator.

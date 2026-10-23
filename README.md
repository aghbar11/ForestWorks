# Dungeons & Forests

A short pixel-art adventure made with Godot. Your grandfather sends you into the woods to bring back the Elixir of Life from his evil twin. On the way you go through the forest and a dark dungeon, collect coins, fight zombies, and stay alive with healing mushrooms.

**Play it in your browser on itch.io:** https://amoor11.itch.io/dungeonsandforests

## Controls

| Key | Action |
| --- | --- |
| W A S D | Move |
| E | Equip or put away the bow |
| Left mouse | Shoot an arrow (bow equipped) |
| F | Interact (pick up items, read the letter, eat mushrooms) |

## Running from source

1. Install [Godot 4.4](https://godotengine.org/download) (the project uses the Compatibility renderer).
2. Clone this repository and open `project.godot` in Godot.
3. Press F5 to run.

The `Web` export preset builds the HTML5 version that is uploaded to itch.io.

### Cloning on Windows

Some asset paths are longer than Windows allows by default, so checkout can fail with `Filename too long`. Turn on long paths before cloning:

```
git config --global core.longpaths true
```

## Project layout

- `Scenes/` – levels, characters, UI and dialogue scenes
- `Scripts/` – GDScript for the player, enemies, items and level logic
- `Dialogue/` – dialogue lines as JSON
- `Assests/` – sprites, tilesets and Tiled maps
- `music/` – music and sound effects

## Credits

Made by amoor11 and rami-alaghbari. Art includes the Legacy-Fantasy High Forest pack and the Pixel Crawler free pack.

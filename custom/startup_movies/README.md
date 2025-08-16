# Steam Deck Startup Movies Installer

A simple script to deploy custom startup movies on the Steam Deck.  
It copies `.webm` and `.jpg` files from the script folder into Steam’s UI overrides folder.

- `.webm` → the actual startup movie that plays on startup.  
- `.jpg` → a clean thumbnail that appears in Steam’s options menu.  

Can add additional files and rerun to update.

---

## 📂 How It Works

- **Source folder:** The same folder as the script itself.  
- **Target folder:** `~/.steam/steam/config/uioverrides/movies/`  
- **Behavior:**  
  - Creates the target folder if it doesn’t exist.  
  - Copies `.webm` and `.jpg` files.  
  - Skips files that already exist (won’t overwrite).  

---

## 🚀 Installation

1. Place `install-startup-movies.sh` in a folder with your `.webm` and `.jpg` files.  
2. Make the script executable:
```bash
chmod +x install-startup-movies.sh
```
3. Run the script:
```bash
./install-startup-movies.sh
```
4. Go to Customisation in Steam and take your pick.

---
# Neofetch Installer for Steam Deck

A simple **user-space installer** for [Neofetch](https://github.com/dylanaraps/neofetch), made for the Steam Deck.  
This script installs Neofetch into your **home directory** (`~/.local/bin`) so you don’t have to touch SteamOS’s **read-only root filesystem**.  

---

## 🚀 Features
- ✅ Safe: doesn’t require disabling SteamOS read-only mode  
- ✅ Works per-user (no `sudo`)  
- ✅ Easy updates (`--update`)  
- ✅ Clean removal (`--remove`)  
- ✅ Optional auto-run when you open a terminal (`--autorun` / `--no-autorun`)  

---

## 📥 Installation

Clone this repo:
```bash
git clone https://github.com/fisherthepious/steam-deck.git
cd steam-deck/install/neofetch
```
Make the script executable (only once):
```bash
chmod +x install-neofetch.sh
```

Run the installer:
```bash
./install-neofetch.sh
```

After installation, you can run:
```bash
neofetch
```

---

## ⚙️ Usage

| Command                              | What it does                                          |
| ------------------------------------ | ----------------------------------------------------- |
| `./install-neofetch.sh`              | Installs Neofetch (manual run only)                   |
| `./install-neofetch.sh --autorun`    | Enable auto-run (runs every time you open a terminal) |
| `./install-neofetch.sh --no-autorun` | Disable auto-run                                      |
| `./install-neofetch.sh --update`     | Update Neofetch to the latest version                 |
| `./install-neofetch.sh --remove`     | Remove Neofetch completely                            |

---

## 🛠️ Notes

- Neofetch will be installed to: ~/.local/bin/neofetch
- Your ~/.bashrc will be updated to ensure ~/.local/bin is in your PATH (if not already).
- Autorun is off by default — you must enable it with --autorun.

---

## 🔄 Quick Install via cURL

If you don’t want to clone the repo, you can run the script directly:
```bash
curl -fsSL https://raw.githubusercontent.com/fisherthepious/steam-deck/master/install/neofetch/install-neofetch.sh | bash
```
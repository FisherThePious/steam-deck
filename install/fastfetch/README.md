# Fastfetch Installer for Steam Deck

A simple **user-space installer** for [Fastfetch](https://github.com/fastfetch-cli/fastfetch), made for the Steam Deck.  
This script installs Fastfetch into your **home directory** (`~/.local/bin`) so you don’t have to touch SteamOS’s **read-only root filesystem**.  

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
cd steam-deck/install/fastfetch
```
Make the script executable (only once):
```bash
chmod +x install-fastfetch.sh
```

Run the installer:
```bash
./install-fastfetch.sh
```

After installation, you can run:
```bash
fastfetch
```

---

## ⚙️ Usage

| Command                              | What it does                                          |
| ------------------------------------ | ----------------------------------------------------- |
| `./install-fastfetch.sh`              | Installs Fastfetch (manual run only)                   |
| `./install-fastfetch.sh --autorun`    | Enable auto-run (runs every time you open a terminal) |
| `./install-fastfetch.sh --no-autorun` | Disable auto-run                                      |
| `./install-fastfetch.sh --update`     | Update Fastfetch to the latest version                 |
| `./install-fastfetch.sh --remove`     | Remove Fastfetch completely                            |

---

## 🛠️ Notes

- Fastfetch will be installed to: ~/.local/bin/fastfetch
- Your ~/.bashrc will be updated to ensure ~/.local/bin is in your PATH (if not already).
- Autorun is off by default — you must enable it with --autorun.

---

## 🔄 Quick Install via cURL

If you don’t want to clone the repo, you can run the script directly:
```bash
curl -fsSL https://raw.githubusercontent.com/fisherthepious/steam-deck/master/install/fastfetch/install-fastfetch.sh | bash
```
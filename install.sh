#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TARGET="$HOME/.config/gtk-4.0"
BACKUP="$TARGET/gtk.css.backup"

# Catppuccin Mocha palette (ANSI 256 approximations)
MAUVE='\033[38;5;183m'
PINK='\033[38;5;218m'
FLAMINGO='\033[38;5;217m'
BLUE='\033[38;5;111m'
GREEN='\033[38;5;151m'
YELLOW='\033[38;5;223m'
SUBTEXT='\033[38;5;145m'
RED='\033[38;5;210m'
BOLD='\033[1m'
RESET='\033[0m'

clear
echo -e "${MAUVE}"
cat << "EOF"
   ██████╗ █████╗ ████████╗██████╗ ██████╗ ██╗   ██╗ ██████╗ ██████╗██╗███╗   ██╗
  ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██║   ██║██╔════╝██╔════╝██║████╗  ██║
  ██║     ███████║   ██║   ██████╔╝██████╔╝██║   ██║██║     ██║     ██║██╔██╗ ██║
  ██║     ██╔══██║   ██║   ██╔═══╝ ██╔═══╝ ██║   ██║██║     ██║     ██║██║╚██╗██║
  ╚██████╗██║  ██║   ██║   ██║     ██║     ╚██████╔╝╚██████╗╚██████╗██║██║ ╚████║
   ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝      ╚═════╝  ╚═════╝ ╚═════╝╚═╝╚═╝  ╚═══╝
EOF
echo -e "${RESET}"
echo -e "${SUBTEXT}                     ── ${PINK}${BOLD}Nautilus Theme Installer${RESET}${SUBTEXT} ──${RESET}"
echo -e "${SUBTEXT}  ╭──────────────────────────────────────────────────────────────╮${RESET}"
echo -e "${SUBTEXT}  ╰──────────────────────────────────────────────────────────────╯${RESET}"
echo

echo -e "  ${BOLD}Choose a flavor:${RESET}"
echo
echo -e "    ${BLUE}1)${RESET} 🌙  ${BOLD}Mocha${RESET}      ${SUBTEXT}— dark, rich, full contrast${RESET}"
echo -e "    ${MAUVE}2)${RESET} 🌺  ${BOLD}Macchiato${RESET}  ${SUBTEXT}— dark, medium contrast${RESET}"
echo -e "    ${FLAMINGO}3)${RESET} 🌸  ${BOLD}Frappé${RESET}     ${SUBTEXT}— dark, soft contrast${RESET}"
echo -e "    ${YELLOW}4)${RESET} 🌿  ${BOLD}Latte${RESET}      ${SUBTEXT}— light, warm${RESET}"
echo -e "    ${SUBTEXT}5)  🚪  Exit${RESET}"
echo

read -rp "$(echo -e "  ${BOLD}${GREEN}❯${RESET} Enter your choice [1-5]: ")" choice

case "$choice" in
    1) THEME="Mocha" ;;
    2) THEME="Macchiato" ;;
    3) THEME="Frappe" ;;
    4) THEME="Latte" ;;
    5) echo -e "\n  ${SUBTEXT}Goodbye! 👋${RESET}\n"; exit 0 ;;
    *) echo -e "\n  ${RED}✗ Invalid choice.${RESET}\n"; exit 1 ;;
esac

echo
mkdir -p "$TARGET"

if [ -f "$TARGET/gtk.css" ]; then
    cp "$TARGET/gtk.css" "$BACKUP"
    echo -e "  ${GREEN}✓${RESET} Existing gtk.css backed up."
fi

SOURCE="$SCRIPT_DIR/$THEME/gtk.css"

if [ ! -f "$SOURCE" ]; then
    echo
    echo -e "  ${RED}✗ Error: Theme file not found.${RESET}"
    echo -e "  ${SUBTEXT}$SOURCE${RESET}"
    exit 1
fi

cp "$SOURCE" "$TARGET/gtk.css"

nautilus -q >/dev/null 2>&1 || true

echo
echo -e "  ${GREEN}${BOLD}✓ Installed Catppuccin $THEME successfully!${RESET} 🎉"
echo

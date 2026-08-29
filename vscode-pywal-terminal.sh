#!/bin/bash
# PYWAL16 → VS Code (terminal + sintaxe) — seguro e estável

CACHE="$HOME/.cache/wal/colors.json"
SETTINGS="$HOME/.config/Code/User/settings.json"
TMP_JSON="/tmp/pywal-vscode-safe.json"

command -v jq >/dev/null || { echo "Erro: jq não instalado"; exit 1; }
[ ! -f "$CACHE" ] && { echo "Erro: rode 'wal' primeiro"; exit 1; }

mkdir -p "$(dirname "$SETTINGS")"
[ ! -f "$SETTINGS" ] && echo "{}" > "$SETTINGS"

cp -f "$SETTINGS" "$SETTINGS.bak_$(date +%s)"

BG=$(jq -r '.special.background' "$CACHE")
FG=$(jq -r '.special.foreground' "$CACHE")
CURSOR=$(jq -r '.special.cursor' "$CACHE")

for i in {0..15}; do
  eval C$i=$(jq -r ".colors.color$i" "$CACHE")
done

cat > "$TMP_JSON" << EOF
{
  "editor.tokenColorCustomizations": {
    "comments": "$C8",
    "keywords": "$C1",
    "strings": "$C2",
    "numbers": "$C3",
    "functions": "$C4",
    "variables": "$C5",
    "operators": "$C6",
    "types": "$C7",
    "brackets": "$C9",
    "tags": "$C13",
    "attributes": "$C14",
    "properties": "$C15"
  },
  "workbench.colorCustomizations": {
    "terminal.background": "$BG",
    "terminal.foreground": "$FG",
    "terminal.cursor.background": "$CURSOR",
    "terminal.cursor.foreground": "$CURSOR",
    "terminal.ansiBlack": "$C0",
    "terminal.ansiRed": "$C1",
    "terminal.ansiGreen": "$C2",
    "terminal.ansiYellow": "$C3",
    "terminal.ansiBlue": "$C4",
    "terminal.ansiMagenta": "$C5",
    "terminal.ansiCyan": "$C6",
    "terminal.ansiWhite": "$C7",
    "terminal.ansiBrightBlack": "$C8",
    "terminal.ansiBrightRed": "$C9",
    "terminal.ansiBrightGreen": "$C10",
    "terminal.ansiBrightYellow": "$C11",
    "terminal.ansiBrightBlue": "$C12",
    "terminal.ansiBrightMagenta": "$C13",
    "terminal.ansiBrightCyan": "$C14",
    "terminal.ansiBrightWhite": "$C15"
  }
}
EOF

jq -s '
  .[0] *
  {
    "editor.tokenColorCustomizations":
      (.[0].editor.tokenColorCustomizations // {} + .[1].editor.tokenColorCustomizations),
    "workbench.colorCustomizations":
      (.[0].workbench.colorCustomizations // {} + .[1].workbench.colorCustomizations)
  }
' "$SETTINGS" "$TMP_JSON" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"

rm -f "$TMP_JSON"


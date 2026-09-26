#!/usr/bin/env bash
# Re-provision the Zerodha bounty workspace on a fresh Kali box.
# Assumes user 'kali' and path /home/kali/zerodha (keeps Claude memory slug matching).
set -e
cd "$(dirname "$0")"

echo "[*] Restoring Claude Code memory..."
MEM="$HOME/.claude/projects/-home-kali-zerodha/memory"
mkdir -p "$MEM"
cp -a claude-state/memory/. "$MEM"/
echo "    -> $MEM"

echo "[*] Installing mobile static-analysis tooling (no root needed)..."
mkdir -p tools && cd tools
if [ ! -x jadx/bin/jadx ]; then
  curl -sL -o jadx.zip "https://github.com/skylot/jadx/releases/download/v1.5.0/jadx-1.5.0.zip"
  unzip -oq jadx.zip -d jadx && rm -f jadx.zip
fi
[ -f apktool.jar ] || curl -sL -o apktool.jar "https://github.com/iBotPeaches/Apktool/releases/download/v2.9.3/apktool_2.9.3.jar"
mkdir -p bin
printf '#!/usr/bin/env bash\nexec %s/jadx/bin/jadx "$@"\n' "$PWD" > bin/jadx
printf '#!/usr/bin/env bash\nexec java -jar %s/apktool.jar "$@"\n' "$PWD" > bin/apktool
chmod +x bin/jadx bin/apktool
cd ..
echo "[*] Done. Tools in tools/bin/ (jadx, apktool). Java required (openjdk)."
echo "[*] Next: drop APK in apps/coin or apps/pulse and read CONTINUE.md"

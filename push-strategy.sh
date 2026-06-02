#!/bin/bash
# Usage: bash push-strategy.sh [slug]
#   slug → clients/ klasörü adı (örn: dytss)
SLUG=$1

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

WORKSPACE=$(find "$HOME/Library/CloudStorage" -path "*/nomades-agency" -maxdepth 5 -type d 2>/dev/null | head -1)

if [ -z "$WORKSPACE" ]; then
  echo "Hata: nomades-agency workspace bulunamadı."
  exit 1
fi

if [ -z "$SLUG" ]; then
  echo "Kullanım: bash push-strategy.sh [slug]"
  exit 1
fi

HTML_FILE="$WORKSPACE/clients/$SLUG/$SLUG-strateji.html"

if [ ! -f "$HTML_FILE" ]; then
  echo "Hata: $HTML_FILE bulunamadı"
  exit 1
fi

mkdir -p "$SCRIPT_DIR/$SLUG"
cp "$HTML_FILE" "$SCRIPT_DIR/$SLUG/index.html"

cd "$SCRIPT_DIR"
git add .
git commit -m "strategy: update $SLUG"
git push

echo ""
echo "Yayinda: https://strategy.nomadesagency.com/$SLUG"

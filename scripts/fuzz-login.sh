#!/usr/bin/env bash
# Останавливаемся при ошибке, выводим каждый шаг
set -euo pipefail

WORDLIST=${1:-payloads.txt}
OUT_DIR=${2:-artifacts}
URL=${3:-http://localhost:3000/rest/user/login}

mkdir -p "$OUT_DIR"

# FFUF ищет успешные (200 OK) ответы на POST /rest/user/login
ffuf \
  -w "$WORDLIST":PAYLOAD          \
  -u "$URL"                   \
  -X POST                     \
  -H "Content-Type: application/json" \
  -d '{"email":"PAYLOAD","password":"pass"}' \
  -t 50                       \
  -mc 200                     `# показываем только 200 OK` \
  -o "$OUT_DIR/ffuf-results.json" -of json

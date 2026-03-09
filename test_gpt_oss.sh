#!/usr/bin/env bash
# test_gpt_oss.sh – GPT-OSS 120B Sovereign via adesso AI Hub testen
# Usage: bash test_gpt_oss.sh
#        bash test_gpt_oss.sh "Erklaere mir Oracle DB Links in 3 Saetzen"
set -euo pipefail

# ── Config ──────────────────────────────────────────────
API_URL="https://adesso-ai-hub.3asabc.de/v1/chat/completions"
MODEL="gpt-oss-120b-sovereign"

# API Key aus Environment oder .env laden
if [[ -z "${ADESSO_HUB_KEY:-}" ]]; then
    if [[ -f .env ]]; then
        export $(grep ADESSO_HUB_KEY .env | xargs)
    fi
fi

if [[ -z "${ADESSO_HUB_KEY:-}" ]]; then
    echo "ERROR: ADESSO_HUB_KEY nicht gesetzt."
    echo "  export ADESSO_HUB_KEY='sk-...'"
    echo "  oder in .env Datei ablegen: ADESSO_HUB_KEY=sk-..."
    exit 1
fi

# ── Prompt ──────────────────────────────────────────────
PROMPT="${1:-Hello! Please respond with exactly 3 sentences about Oracle SQL. Keep it concise.}"

echo "======================================"
echo "  GPT-OSS 120B Sovereign – Testlauf"
echo "======================================"
echo ""
echo "Modell:   $MODEL"
echo "Endpoint: $API_URL"
echo "Prompt:   $PROMPT"
echo ""
echo "Sende Request..."
echo ""

# ── API Call ────────────────────────────────────────────
START_TIME=$(date +%s%N)

RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL" \
    -H "Authorization: Bearer $ADESSO_HUB_KEY" \
    -H "Content-Type: application/json" \
    -d "$(cat <<EOF
{
    "model": "$MODEL",
    "messages": [
        {
            "role": "user",
            "content": "$PROMPT"
        }
    ],
    "max_tokens": 500,
    "temperature": 0.7
}
EOF
)")

END_TIME=$(date +%s%N)
DURATION_MS=$(( (END_TIME - START_TIME) / 1000000 ))

# HTTP Status extrahieren (letzte Zeile)
HTTP_STATUS=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | sed '$d')

# ── Ergebnis ────────────────────────────────────────────
if [[ "$HTTP_STATUS" != "200" ]]; then
    echo "ERROR: HTTP $HTTP_STATUS"
    echo "$BODY" | python3 -m json.tool 2>/dev/null || echo "$BODY"
    exit 1
fi

# Antwort extrahieren
CONTENT=$(echo "$BODY" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(data['choices'][0]['message']['content'])
")

# Token Usage extrahieren
USAGE=$(echo "$BODY" | python3 -c "
import sys, json
data = json.load(sys.stdin)
u = data.get('usage', {})
print(f\"Input: {u.get('prompt_tokens', '?')} | Output: {u.get('completion_tokens', '?')} | Total: {u.get('total_tokens', '?')}\")
" 2>/dev/null || echo "nicht verfuegbar")

echo "────────────────────────────────────"
echo "ANTWORT:"
echo "────────────────────────────────────"
echo "$CONTENT"
echo ""
echo "────────────────────────────────────"
echo "STATS:"
echo "  Dauer:  ${DURATION_MS} ms"
echo "  Tokens: $USAGE"
echo "  Kosten: 0 USD (gratis)"
echo "────────────────────────────────────"

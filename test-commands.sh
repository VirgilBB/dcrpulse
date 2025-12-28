#!/bin/sh

# Test script for Decred Pulse (combined dcrd + dashboard)
# Intended usage: run inside Akash Console -> Shell (localhost RPC).
#
# Defaults match deploy.yaml:
#   - user: decred
#   - pass: decredpass
#   - url:  http://127.0.0.1:9109

set -eu

echo "🧪 Testing Decred RPC Commands (localhost)"
echo "========================================="
echo ""

URL="${DCRD_URL:-http://127.0.0.1:9109}"
USER="${DCRD_USER:-decred}"
PASS="${DCRD_PASS:-decredpass}"

post() {
  METHOD="$1"
  curl -sS -u "$USER:$PASS" -H 'Content-Type: application/json' \
    -d "{\"jsonrpc\":\"1.0\",\"method\":\"$METHOD\",\"params\":[],\"id\":1}" \
    "$URL"
}

extract_number_result() {
  # Extracts numeric "result" for calls like getblockcount.
  # Example: {"result":123,"error":null,"id":1}
  echo "$1" | sed -n 's/.*"result":\([0-9][0-9]*\).*/\1/p'
}

echo "🔗 Testing connection to: $URL"
echo ""

# Test 1: Ping
echo "Test 1: ping"
RESULT="$(post ping)"
echo "$RESULT" | grep -q '"error":null' || { echo "❌ FAIL"; echo "$RESULT"; exit 1; }
echo "✅ PASS"
echo ""

# Test 2: Get Block Count
echo "Test 2: getblockcount"
RAW_HEIGHT="$(post getblockcount)"
HEIGHT="$(extract_number_result "$RAW_HEIGHT")"
[ "$HEIGHT" != "" ] || { echo "❌ FAIL"; echo "$RAW_HEIGHT"; exit 1; }
echo "✅ PASS - Block height: $HEIGHT"
echo ""

# Test 3: Peer Count (approx)
echo "Test 3: getpeerinfo (approx peer count)"
PEERINFO="$(post getpeerinfo)"
PEERS="$(echo "$PEERINFO" | grep -c '\"addr\"' || true)"
echo "✅ PASS - Connected peers (approx): $PEERS"
echo ""

# Test 4: Best Block Hash
echo "Test 4: getbestblockhash"
HASH_RAW="$(post getbestblockhash)"
HASH="$(echo "$HASH_RAW" | sed -n 's/.*"result":"\([0-9a-fA-F]\{64\}\)".*/\1/p')"
[ "${#HASH}" -eq 64 ] || { echo "❌ FAIL"; echo "$HASH_RAW"; exit 1; }
echo "✅ PASS - Block hash: $(echo "$HASH" | cut -c1-16)..."
echo ""

# Test 5: getinfo
echo "Test 5: getinfo"
INFO="$(post getinfo)"
echo "$INFO" | grep -q '"error":null' || { echo "❌ FAIL"; echo "$INFO"; exit 1; }
echo "✅ PASS"
echo ""

# Test 6: Network comparison (best effort)
echo "Test 6: Network sync status (best effort)"
NETWORK_HEIGHT="$(curl -s https://dcrdata.decred.org/api/block/best/height 2>/dev/null || true)"
if [ "$NETWORK_HEIGHT" != "" ]; then
  DIFF=$((NETWORK_HEIGHT - HEIGHT))
  echo "   Your node:  $HEIGHT"
  echo "   Network:    $NETWORK_HEIGHT"
  echo "   Difference: $DIFF blocks"
else
  echo "⚠️  WARN - Could not fetch network height"
fi
echo ""

echo "========================================="
echo "✅ Tests completed"
echo "========================================="

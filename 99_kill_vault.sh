#!/bin/bash

HASHISTACK_DIR="$HOME/.hashistack/"
HASHISTACK_LOG_DIR="$HASHISTACK_DIR/log"

if [ ! -f "$HASHISTACK_DIR/vault.pid" ]; then
  echo "Vault not running"
  exit 1
else
  VAULT_PID=$(cat "$HASHISTACK_DIR/vault.pid")
fi

kill -9 "$VAULT_PID"

echo "Killed Vault (PID:$VAULT_PID)"

rm "$HASHISTACK_DIR/vault.pid" "$HASHISTACK_LOG_DIR/vault.log"

#!/bin/sh

CERT_DIR="/etc/raddb/certs"

echo "[INFO] Cleaning up old certificates..."
rm -f "$CERT_DIR"/*.pem "$CERT_DIR"/*.der "$CERT_DIR"/*.csr "$CERT_DIR"/*.crt "$CERT_DIR"/*.key "$CERT_DIR"/*.p12 "$CERT_DIR"/serial* "$CERT_DIR"/index.txt*

echo "[INFO] Generating new certificates..."
cd "$CERT_DIR" || exit 1
./bootstrap

echo "[INFO] Setting correct ownership and permissions..."
chown -R root:radius "$CERT_DIR"
chmod 640 "$CERT_DIR"/*.pem

echo "[OK] Certificate update complete."

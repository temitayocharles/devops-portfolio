# Create a simple favicon.ico using base64
ICO_DATA="AAABAAEAEBAAAAEACABoBQAAFgAAACgAAAAQAAAAIAAAAAEACAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAA"

echo "$ICO_DATA" | base64 -d > favicon.ico 2>/dev/null || true

echo "Favicon created (or attempted)"

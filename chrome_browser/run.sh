#!/bin/bash
# Reads the Home Assistant add-on options and turns them into the
# environment variables that linuxserver/chromium understands.
# Then it hands over to the image's own start program (/init).
set -e

OPTS=/data/options.json

# Prints the option value. Works for false too (plain // would skip false).
opt() {
  jq -r --arg k "$1" 'if has($k) and .[$k] != null then .[$k] else empty end' "$OPTS" 2>/dev/null || true
}

TZ_VALUE="$(opt timezone)"
USER_VALUE="$(opt username)"
PASS_VALUE="$(opt password)"
START_URL="$(opt start_url)"
PROXY="$(opt proxy_server)"
FLAGS="$(opt extra_chrome_flags)"
WAYLAND="$(opt wayland)"

[ -n "$TZ_VALUE" ] && export TZ="$TZ_VALUE"
export PUID=0 PGID=0
export TITLE="Chrome Browser"

# Optional web page login. Both must be set.
if [ -n "$USER_VALUE" ] && [ -n "$PASS_VALUE" ]; then
  export CUSTOM_USER="$USER_VALUE"
  export PASSWORD="$PASS_VALUE"
fi

# Display mode. The image defaults to Wayland, which can give a blank
# screen on some hardware. X11 is the safer default here.
if [ "$WAYLAND" = "true" ]; then
  export PIXELFLUX_WAYLAND=true
else
  export PIXELFLUX_WAYLAND=false
fi

# Build the Chromium command line flags.
CLI="$FLAGS"
[ -n "$PROXY" ] && CLI="$CLI --proxy-server=$PROXY"
[ -n "$START_URL" ] && CLI="$CLI $START_URL"
export CHROME_CLI="$CLI"

echo "[chrome_browser] Starting. Time zone: ${TZ:-default}. Proxy: ${PROXY:-none}. Wayland: ${PIXELFLUX_WAYLAND}."

exec /init

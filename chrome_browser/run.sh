#!/bin/sh
# Reads the Home Assistant add-on options and turns them into the
# environment variables that jlesage/chromium understands.
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
SSL="$(opt ssl)"
DNS="$(opt dns_server)"
DARK="$(opt dark_mode)"
SCREEN_W="$(opt screen_width)"
SCREEN_H="$(opt screen_height)"

[ -n "$TZ_VALUE" ] && export TZ="$TZ_VALUE"

# HTTPS for the web page. On by default.
if [ "$SSL" = "false" ]; then
  export SECURE_CONNECTION=0
  SCHEME=http
else
  export SECURE_CONNECTION=1
  SCHEME=https
fi

# Dark mode for the browser (off by default).
[ "$DARK" = "true" ] && export DARK_MODE=1

# Screen size of the browser window. Empty = image default (1920x1080).
[ -n "$SCREEN_W" ] && export DISPLAY_WIDTH="$SCREEN_W"
[ -n "$SCREEN_H" ] && export DISPLAY_HEIGHT="$SCREEN_H"

# Optional DNS server(s). Space or comma separated. Empty = use Home Assistant DNS.
if [ -n "$DNS" ]; then
  RESOLV=""
  for ns in $(echo "$DNS" | tr ',' ' '); do
    RESOLV="${RESOLV}nameserver ${ns}\n"
  done
  if printf "$RESOLV" > /etc/resolv.conf 2>/dev/null; then
    echo "[chrome_browser] DNS forced to: $DNS"
  else
    echo "[chrome_browser] WARNING: could not set DNS to $DNS. Using Home Assistant DNS."
  fi
fi

# Optional web page login. Both must be set.
if [ -n "$USER_VALUE" ] && [ -n "$PASS_VALUE" ]; then
  export WEB_AUTHENTICATION=1
  export WEB_AUTHENTICATION_USERNAME="$USER_VALUE"
  export WEB_AUTHENTICATION_PASSWORD="$PASS_VALUE"
fi

# Chromium needs --no-sandbox here. Add it if the saved flags lack it.
case " $FLAGS " in
  *" --no-sandbox "*) ;;
  *) FLAGS="--no-sandbox $FLAGS" ;;
esac

ARGS="$FLAGS"
[ -n "$PROXY" ] && ARGS="$ARGS --proxy-server=$PROXY"
[ -n "$START_URL" ] && ARGS="$ARGS $START_URL"
export CHROMIUM_CUSTOM_ARGS="$ARGS"

echo "[chrome_browser] Starting. Time zone: ${TZ:-default}. Proxy: ${PROXY:-none}. DNS: ${DNS:-default}. Dark mode: ${DARK:-false}. Web page: $SCHEME on container port 5800."

exec /init

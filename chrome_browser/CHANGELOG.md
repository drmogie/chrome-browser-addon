# Changelog

## 2026.10.04.03

- Default host ports moved to 3010 (HTTP) and 3011 (HTTPS). Port 3001 clashed with another service on arc-ha.
- Inside the add-on the ports are still 3000 and 3001. Only the host side changed.
- If you changed the ports by hand, use Reset to defaults in the Network box.

## 2026.10.04.02

- Now downloads a ready-made image from GitHub instead of building on your server.
- The first build on arc-ha ran for 25+ minutes (slow disk), so building there was dropped.
- Image is built for amd64 and aarch64 by GitHub Actions.

## 2026.10.04.01

- First version.
- Wraps `linuxserver/chromium`.
- Options: time zone, web page login, start page, proxy, extra Chromium flags.

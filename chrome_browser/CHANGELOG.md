# Changelog

## 2026.10.04.05

- Switched the base image to `jlesage/chromium` (about 380 MB, down from over 1 GB).
- The old `linuxserver/chromium` image showed a blank viewer on arc-ha.
- One web port now: host 3011 -> container 5800. Port 3010 is gone.
- New option `ssl` (on by default). Removed the `wayland` option.
- `--no-sandbox` is always added to the Chromium flags.
- If you have old port settings, use Reset to defaults in the Network box.

## 2026.10.04.04

- New option `wayland` (off by default). The browser viewer showed a blank screen with the image's default Wayland mode. X11 mode is used instead.
- Fixed reading `false` option values in `run.sh`.

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

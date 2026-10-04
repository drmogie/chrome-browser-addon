# Chrome Browser Add-on - project notes

## 2026-10-04: first build

- Repo folder: `chrome-browser-addon`. Add-on: `chrome_browser`, name "Chrome Browser".
- Name picked by Mogie (add-on, so no `ha-` prefix). Repo name `-addon` suffix chosen by Claude to match `webvirtcloud-addon`. Not yet confirmed.
- Image: `lscr.io/linuxserver/chromium:latest`, chosen by Mogie.
- `run.sh` reads `/data/options.json`, sets env vars, then `exec /init`.
- Profile is stored in `/config` (mapped from `addon_config`).
- `--disable-dev-shm-usage` is on by default because add-ons cannot set `shm_size`.
- Not tested end to end. No Docker in the cloud container. Test on ha-pi4 first.
- Unknowns to check on ha-pi4: Chromium sandbox without seccomp unconfined,
  whether `CHROME_CLI` is applied, whether the base image has `apt-get` or `apk`.
- No Ingress. KasmVNC uses websockets and may not work under an Ingress path.
- No icon/logo yet.
- Not pushed to GitHub yet. Waiting for Mogie.

## 2026-10-04: prebuilt image (2026.10.04.02)

- First install on arc-ha (arm64) built locally for 25+ minutes unpacking
  the linuxserver/chromium layer (slow disk). Mogie rebooted the server.
- Switched to a prebuilt image: `image: ghcr.io/drmogie/{arch}-addon-chrome-browser`
  in config.yaml. With `image` set, Supervisor pulls and does not build.
- `.github/workflows/build.yaml` builds amd64 (ubuntu-24.04) and aarch64
  (ubuntu-24.04-arm) and pushes `:<version>` and `:latest`. Runs on
  release published, or by hand.
- The GHCR package must be PUBLIC or Supervisor cannot pull it.
- Release flow now: bump config.yaml version, push, create the Release,
  wait for the workflow, then update on HA.

## 2026-10-04: default ports (2026.10.04.03)

- arc-ha already used host port 3001. Supervisor showed a port conflict.
- Defaults are now host 3010 -> container 3000 and host 3011 -> container 3001.
- The container still listens on 3000/3001 (fixed by the linuxserver image).
- `webui` still uses `[PORT:3001]`, which Supervisor turns into the mapped host port.
- Mogie reported the browser "still trying 3001" even though HA showed 3011.
  Not yet confirmed what was opening 3001 (Open Web UI link vs a typed address).

## 2026-10-04: blank viewer (2026.10.04.04)

- On arc-ha the Selkies sidebar showed but no browser. Chromium WAS running
  (ps showed chromium as root with --no-sandbox, Seccomp 0). Container name is
  `app_f686ecb0_chrome_browser` (not `addon_`).
- Latest linuxserver/chromium is Selkies + Wayland (KasmVNC branch is deprecated).
  Wayland can give a black screen on some hardware. Added option `wayland`
  (default false) that sets `PIXELFLUX_WAYLAND`.
- NOT confirmed this fixes it. Other suspects: /dev/shm is 64MB (add-ons cannot
  set shm_size); start_url http://172.16.1.50:7575 may not load from arc-ha.

## 2026-10-04: switched to jlesage/chromium (2026.10.04.05)

- linuxserver/chromium (Selkies + Wayland, 1 GB+) gave a blank viewer on arc-ha
  even with PIXELFLUX_WAYLAND=false. Chromium was running; the display was not.
- jlesage/chromium: ~376 MB arm64, ~391 MB amd64 (Docker Hub, 2026-10-04).
  Web on 5800, VNC 5900 (not exposed). Env: TZ, WEB_AUTHENTICATION(_USERNAME/_PASSWORD),
  SECURE_CONNECTION, CHROMIUM_CUSTOM_ARGS, USER_ID/GROUP_ID.
- Host port 3011 -> container 5800. `webui` uses `[PROTO:ssl]` so the link
  follows the `ssl` option.
- `--no-sandbox` is always added in run.sh (sandbox needs SYS_ADMIN/seccomp
  otherwise, which add-ons do not give by default).
- Old saved options (`wayland`) and old ports (3000/3001) may log warnings.
- NOT tested end to end. Check on arc-ha.

## 2026.10.04.06
- Added dns_server (writes /etc/resolv.conf in run.sh, empty by default), dark_mode (DARK_MODE env), screen_width/screen_height (DISPLAY_WIDTH/HEIGHT).
- Sandbox banner choice (--test-type vs SYS_ADMIN) still open.

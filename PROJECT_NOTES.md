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

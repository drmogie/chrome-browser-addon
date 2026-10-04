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

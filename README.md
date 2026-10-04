# Chrome Browser Add-on

![Project Maintenance][maintenance-shield]
[![License: MIT][license-shield]](LICENSE)

Run a Chromium browser on your Home Assistant server and use it from a web page.

[![Open your Home Assistant instance and show the add add-on repository dialog with this repository pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fdrmogie%2Fchrome-browser-addon)

## Add-ons

- **Chrome Browser** (`chrome_browser`): Chromium in a web page, built on `linuxserver/chromium`.

## Install

1. In Home Assistant go to Settings, Add-ons, Add-on Store.
2. Open the menu (three dots), then Repositories.
3. Add `https://github.com/drmogie/chrome-browser-addon`.
4. Install **Chrome Browser** and start it.
5. Click Open Web UI.

## Network

The browser uses the Home Assistant server's network. See the add-on Docs tab.

## Credits

Built on [linuxserver/chromium](https://github.com/linuxserver/docker-chromium).

[maintenance-shield]: https://img.shields.io/maintenance/yes/2026.svg
[license-shield]: https://img.shields.io/badge/License-MIT-yellow.svg

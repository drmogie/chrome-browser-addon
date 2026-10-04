# Chrome Browser

A Chromium browser that runs on your Home Assistant server.
You use it through a web page.

## How to open it

- Click **Open Web UI**, or go to `https://<your-ha-ip>:3011`.
- The page uses a self-signed certificate. Your browser will warn you once.
- If you turn **ssl** off, use `http://` instead.

## Which network does it use?

The browser runs on the Home Assistant server.
So it uses the server's network, not the network of the device you view it from.

- Websites see the server's internet address.
- It can reach devices on the server's local network.
- It cannot reach devices on your own network, unless the two are linked.

To change this, use the **proxy_server** option, or run a VPN on the server.

## Options

- **timezone**: Time zone for the browser.
- **username** and **password**: Optional login for the web page. Set both or neither.
- **start_url**: Page to open when the browser starts.
- **proxy_server**: Send all traffic through a proxy. Example: `http://172.16.1.5:3128`.
- **extra_chrome_flags**: More Chromium flags. Keep `--no-sandbox` and `--disable-dev-shm-usage`.
- **ssl**: Use HTTPS for the web page. On by default. Login and clipboard need it.

## Saved data

Profile, cookies and settings are saved in the add-on's own config folder.
They stay after a restart or update.

## Safety

- Set a username and password if the port is reachable by other people.
- Do not expose port 3011 to the internet without a login.

## Credits

Built on the [jlesage/chromium](https://github.com/jlesage/docker-chromium) image.

# Chrome Browser Home Assistant add-on.
# Wraps the linuxserver/chromium image. Chromium itself is not modified.
# This add-on only adds a small start script that reads the add-on options.
ARG CHROMIUM_TAG=latest
FROM lscr.io/linuxserver/chromium:${CHROMIUM_TAG}

# jq reads the add-on options.
RUN if command -v apt-get >/dev/null 2>&1; then \
      apt-get update && apt-get install -y --no-install-recommends jq \
      && rm -rf /var/lib/apt/lists/*; \
    elif command -v apk >/dev/null 2>&1; then \
      apk add --no-cache jq; \
    fi

COPY run.sh /usr/local/bin/ha-run.sh
RUN chmod a+x /usr/local/bin/ha-run.sh

ENTRYPOINT ["/usr/local/bin/ha-run.sh"]

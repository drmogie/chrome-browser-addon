# Chrome Browser Home Assistant add-on.
# Wraps the jlesage/chromium image (about 380 MB). Chromium itself is not
# modified. This add-on only adds a small start script that reads the
# add-on options.
ARG CHROMIUM_TAG=latest
FROM jlesage/chromium:${CHROMIUM_TAG}

# jq reads the add-on options.
RUN if command -v jq >/dev/null 2>&1; then :; \
    elif command -v apk >/dev/null 2>&1; then apk add --no-cache jq; \
    elif command -v apt-get >/dev/null 2>&1; then \
      apt-get update && apt-get install -y --no-install-recommends jq \
      && rm -rf /var/lib/apt/lists/*; \
    fi

COPY run.sh /usr/local/bin/ha-run.sh
RUN chmod a+x /usr/local/bin/ha-run.sh

ENTRYPOINT ["/usr/local/bin/ha-run.sh"]

#!/bin/sh
# Simple healthcheck script: return 0 if root path returns HTTP 2xx/3xx
URL="http://127.0.0.1:80/"

# -s silent, -S show errors, -f fail on non-2xx/3xx
curl -sS -f "$URL" >/dev/null 2>&1
exit $?

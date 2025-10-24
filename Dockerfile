# Use official nginx on Alpine for small image size
ARG NGX_VERSION=1.25-alpine
FROM nginx:${NGX_VERSION}

LABEL maintainer="adititiwari1204"

# Make curl available for healthcheck
RUN apk add --no-cache curl

# Replace default config (we provide a minimal config below)
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy site contents (put your static site in ./html)
COPY html /usr/share/nginx/html

# Healthcheck script
COPY healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/healthcheck.sh

EXPOSE 80

# Use a lightweight healthcheck that checks the root path
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD /usr/local/bin/healthcheck.sh || exit 1

# Use the default nginx foreground command from the base image
# (nginx:alpine sets the default CMD to run nginx in foreground)

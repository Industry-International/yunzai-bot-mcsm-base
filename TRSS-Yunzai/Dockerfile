# 基于Debian 12 (bookworm) slim版本构建，amd64架构
FROM debian:bookworm-slim

RUN apt update \
    && apt install -y --no-install-recommends \
        ca-certificates \
        ffmpeg \
        git \
        curl \
        chromium \
        redis-server \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data

RUN git clone --depth 1 https://github.com/TimeRainStarSky/Yunzai /data \
    && cd /data \
    && npm config set registry https://registry.npmmirror.com \
    && npm install -g pnpm  \
    && pnpm install -P \
    && chmod 755 -R /data 


ENTRYPOINT ["/bin/bash", "-c", "cd /data && node app"]
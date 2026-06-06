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
    &&    apt install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/TimeRainStarSky/Yunzai /app \
    && cd /app \
    && npm config set registry https://registry.npmmirror.com \
    && npm install -g pnpm  \
    && pnpm install -P

WORKDIR /data
# 创建/data下存放目录，把/app目录软链指向/data
RUN mkdir -p /data/config /data/plugins /data/data /data/log /data/resources \
    && ln -sf /data/config /app/config \
    && ln -sf /data/plugins /app/plugins \
    && ln -sf /data/data /app/data \
    && ln -sf /data/log /app/log \
    && ln -sf /data/resources /app/resources
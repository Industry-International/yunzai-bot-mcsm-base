# 基于Debian 12 (bookworm) slim版本构建，amd64架构
FROM debian:bookworm-slim

RUN apt update \
    && apt install -y --no-install-recommends gnupg ca-certificates curl \
    # jsdelivr加速github源密钥，国内稳定可解析
    && curl -fsSL https://cdn.jsdelivr.net/gh/valkey-io/valkey-keyring@main/valkey-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/valkey-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/valkey-archive-keyring.gpg] https://packages.valkey.io/deb bookworm main" > /etc/apt/sources.list.d/valkey.list \
    && apt update \
    && apt install -y --no-install-recommends \
        ffmpeg \
        git \
        chromium \
        nodejs \
        valkey-redis-compat \
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
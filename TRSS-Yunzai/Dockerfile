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

RUN git clone --depth 1 https://github.com/TimeRainStarSky/Yunzai /app \
    && cd /app \
    && npm config set registry https://registry.npmmirror.com \
    && npm install -g pnpm  \
    && pnpm install -P

WORKDIR /data

ENTRYPOINT ["/bin/bash", "-c", "\
# 1.启动redis
redis-server --daemonize yes; \
# 2.启动时创建宿主机挂载目录的子文件夹（宿主机空目录自动生成）
mkdir -p /data/config/ /data/plugins/ /data/data/ /data/log/ /data/resources/; \
# 3.删除/app原有目录，创建软链，强制映射到挂载/data
rm -rf /app/config/ /app/plugins/ /app/data/ /app/log/ /app/resources/; \
ln -sf /data/config/ /app/config/; \
ln -sf /data/plugins/ /app/plugins/; \
ln -sf /data/data/ /app/data/; \
ln -sf /data/log/ /app/log/; \
ln -sf /data/resources/ /app/resources/; \
# 4.首次启动初始化防EEXIST报错
if [ ! -f /data/.init ];then rm -rf /data/config/config && touch /data/.init;fi; \
# 5.启动程序
cd /app && exec node app.js \
"]
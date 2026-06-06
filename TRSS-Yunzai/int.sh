#!/bin/bash

# 赋予目录权限
chmod 755 -R /data
# 克隆项目
git clone --depth 1 https://github.com/TimeRainStarSky/Yunzai /data/Yunzai

cd /data/Yunzai

# 安装项目依赖
pnpm install -P
# 启动Yunzai-Bot
exec node app
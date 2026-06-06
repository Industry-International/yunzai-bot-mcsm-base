#!/bin/bash

# 赋予目录权限
chmod 755 -R /data
# 克隆项目
git clone --depth 1 https://github.com/TimeRainStarSky/Yunzai /data

# 进入项目目录
cd /data || exit

# 切换npm镜像源为淘宝源
npm config set registry https://registry.npmmirror.com

# 全局安装pnpm
npm install -g pnpm

# 安装项目依赖
pnpm install -P
# 启动Yunzai-Bot
exec node app
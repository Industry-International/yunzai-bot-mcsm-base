#!/bin/bash

# ===================== 配置需要持久化的目录列表 =====================
PERSIST_DIRS=(
    "app"
)


# 2. 遍历所有需要持久化的目录，创建软链接
for dir in "${PERSIST_DIRS[@]}"; do
    SRC="/${dir}"
    DST="/data/${dir}"

    # 确保持久化目录存在
    mkdir -p "${DST}"

    # 首次启动：如果持久化目录为空，拷贝镜像内默认文件到持久化目录
    if [ -z "$(ls -A "${DST}" 2>/dev/null)" ] && [ -d "${SRC}" ]; then
        echo "Init default files for ${dir} ..."
        cp -r "${SRC}/"* "${DST}/" 2>/dev/null || true
    fi

    # 删除原目录，创建软链接（数据全部指向 /data）
    rm -rf "${SRC}"
    ln -sf "${DST}" "${SRC}"
    echo "Linked /app/${dir} -> /data/${dir}"
done

# 3. 进入程序目录，启动 Yunzai-Bot
echo "Start Yunzai-Bot..."
cd /app
exec node app
#!/bin/bash
# 用法: ./link_first_level.sh SRC_DIR DST_DIR
# 把 SRC_DIR 下的第一層文件/文件夾軟鏈接到 DST_DIR 中，不遞歸

set -e

if [ $# -ne 2 ]; then
    echo "用法: $0 SRC_DIR DST_DIR"
    exit 1
fi

src=$(realpath "$1")
dst=$(realpath "$2")

if [ ! -d "$src" ]; then
    echo "錯誤: $src 不是文件夾"
    exit 1
fi

mkdir -p "$dst"

# 只處理第一層，不遞歸
for item in "$src"/*; do
    [ -e "$item" ] || continue  # 避免空目錄報錯
    ln -sfn "$item" "$dst/"
done

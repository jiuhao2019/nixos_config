#!/bin/bash
# 用 unlink 取消當前目錄下所有軟鏈接（只第一層）

set -e
find . -maxdepth 1 -type l -exec unlink {} \;

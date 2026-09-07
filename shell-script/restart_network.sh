#!/bin/bash
# 重启 ens33 网络接口脚本

echo "正在关闭 ens33..."
sudo ip link set ens33 down

# 延时 3 秒（可根据需要调整）
sleep 3

echo "正在重新启用 ens33..."
sudo ip link set ens33 up

echo "ens33 网络接口已重启完成。"

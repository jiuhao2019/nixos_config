#!/usr/bin/env python3
# -*- coding: utf-8 -*-

def xor_checksum(hex_string):
    """
    计算一串十六进制字节的异或校验。
    支持格式：
      A5 5A 06 0D ...
      0xa5,0x5a,0x06,...
      a5,5a,06,0d
    """
    # 去除分隔符并分割
    hex_string = hex_string.replace(',', ' ').replace('0x', '').replace('0X', '')
    bytes_list = [int(b, 16) for b in hex_string.split() if b.strip()]
    
    xor_result = 0
    for b in bytes_list:
        xor_result ^= b
    return xor_result

if __name__ == "__main__":
    s = input("请输入十六进制字节序列（例如 A5 5A 06 0D ...）:\n> ")
    result = xor_checksum(s)
    print(f"异或结果: 0x{result:02X}")

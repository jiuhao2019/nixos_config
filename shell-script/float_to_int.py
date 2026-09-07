#!/usr/bin/env python3

import struct

def float_to_int32_le(f):
    """小端：float → int32"""
    b = struct.pack('<f', f)
    i = struct.unpack('<I', b)[0]  # 注意这里用 'I' (无符号) 避免负数干扰
    return i

def int32_to_float_le(i):
    """小端：int32 → float"""
    b = struct.pack('<I', i)
    f = struct.unpack('<f', b)[0]
    return f

def main():
    # 浮点数 → 16进制
    f = float(input("请输入一个浮点数: "))
    i = float_to_int32_le(f)
    print(f"浮点数 {f} 的四字节整数（小端）: {i} (16进制: 0x{i:08X})")

if __name__ == "__main__":
    main()

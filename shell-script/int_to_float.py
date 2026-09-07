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

    # 16进制整数 → 浮点数
    hex_input = input("请输入一个 32 位整数（16进制，如 0x4048F5C3 或 4048F5C3）: ")
    i_input = int(hex_input, 16)
    f2 = int32_to_float_le(i_input)
    print(f"16进制整数 0x{i_input:08X} 的浮点数表示（小端）: {f2}")

if __name__ == "__main__":
    main()

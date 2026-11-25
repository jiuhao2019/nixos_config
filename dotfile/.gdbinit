# ==============================
# GDB 基础设置
# ==============================

set confirm off
set pagination off
set breakpoint pending on

# ==============================
# 历史记录
# ==============================

set history save on
set history filename ~/.gdb_history
set history size 1000
set history remove-duplicates unlimited

# ==============================
# 数据显示
# ==============================

set print pretty on
set print array on
set print elements 0
set print repeats 0
set print address on
set print symbol-filename on

# ==============================
# ARM Cortex-M
# ==============================

set architecture arm
set arm force-mode thumb

# ==============================
# 反汇编
# ==============================

set disassemble-next-line on

# ==============================
# 远程连接 J-Link
# ==============================

target remote localhost:2331

monitor reset

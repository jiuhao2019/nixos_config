#!/usr/bin/env python3

import subprocess
import re
from collections import defaultdict

ELF = "build/Release/PCB-V1.1.0.elf"

# 函数分类规则，按顺序匹配
RULES = [
    ("ThreadX", [
        r"^_tx_",
    ]),
    ("HAL", [
        r"^HAL_",
        r"^HAL[A-Z]",
    ]),
    ("CMSIS", [
        r"^System[A-Z_]",
        r"^SysTick",
        r"^PendSV",
    ]),
    ("Compiler Runtime", [
        r"^__aeabi_",
        r"^__(add|sub|mul|div|fix|float|cmp|ash|lsh|mod|udiv|umod)",
        r"^__gnu_",
    ]),
    ("Startup", [
        r"^(Reset_Handler|Default_Handler|NMI_Handler)",
        r"^(HardFault_Handler|MemManage_Handler)",
        r"^(BusFault_Handler|UsageFault_Handler)",
        r"^(SVC_Handler|DebugMon_Handler|PendSV_Handler)",
        r"^(SysTick_Handler|DMA[0-9].*_IRQHandler)",
    ]),
    ("Application", [
        r"^(main|thread_entry)$",
        r"^(action_|proc_|cmd_|mt_|uart_|drv_|ntc_|flow_)",
        r"^(start_motor|stop_motor)",
    ]),
]

def classify(name):
    for module, patterns in RULES:
        if any(re.search(p, name) for p in patterns):
            return module
    return "Other"

# 读取 ELF 函数符号
output = subprocess.check_output(
    ["arm-none-eabi-nm", "-S", "--defined-only", ELF],
    text=True
)

modules = defaultdict(lambda: {
    "count": 0,
    "size": 0,
    "functions": [],
})

for line in output.splitlines():
    parts = line.split()

    if len(parts) < 4:
        continue

    address, size, symbol_type, name = parts[:4]

    if symbol_type not in ("T", "t", "W", "w"):
        continue

    if not re.fullmatch(r"[0-9a-fA-F]+", size):
        continue

    size = int(size, 16)

    if size == 0:
        continue

    module = classify(name)

    modules[module]["count"] += 1
    modules[module]["size"] += size
    modules[module]["functions"].append((size, name))

total = sum(m["size"] for m in modules.values())

print("\n========== Function Statistics ==========\n")

print(
    f"{'Module':<20}"
    f"{'Count':>8}"
    f"{'Bytes':>12}"
    f"{'KB':>10}"
    f"{'Ratio':>10}"
)

print("-" * 60)

for module, data in sorted(
    modules.items(),
    key=lambda x: x[1]["size"],
    reverse=True
):
    ratio = data["size"] / total * 100 if total else 0

    print(
        f"{module:<20}"
        f"{data['count']:>8}"
        f"{data['size']:>12}"
        f"{data['size']/1024:>10.2f}"
        f"{ratio:>9.2f}%"
    )

print("-" * 60)
print(f"{'TOTAL':<20}{sum(m['count'] for m in modules.values()):>8}"
      f"{total:>12}{total/1024:>10.2f}{100 if total else 0:>9.2f}%")

# 输出每个模块 TOP 10
print("\n========== Module TOP 10 ==========")

for module, data in sorted(
    modules.items(),
    key=lambda x: x[1]["size"],
    reverse=True
):
    print(f"\n[{module}]")

    for size, name in sorted(
        data["functions"],
        reverse=True
    )[:10]:
        print(f"{size:6d} B  {size/1024:6.2f} KB  {name}")

# 输出 ELF Section
print("\n========== ELF Sections ==========\n")

section_output = subprocess.check_output(
    ["arm-none-eabi-size", "-A", ELF],
    text=True
)

for line in section_output.splitlines():
    if line.startswith((".text ", ".rodata ", ".data ", ".isr_vector ")):
        print(line)

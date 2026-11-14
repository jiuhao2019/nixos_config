#!/usr/bin/env python3

import subprocess
import re
from collections import defaultdict

ELF = "build/Release/PCB-V1.1.0.elf"

MODULES = {
    "Thread":       "_tx_thread_",
    "Queue":        "_tx_queue_",
    "Mutex":        "_tx_mutex_",
    "Event Flags":  "_tx_event_flags_",
    "Semaphore":    "_tx_semaphore_",
    "Block Pool":   "_tx_block_pool_",
    "Byte Pool":    "_tx_byte_pool_",
    "Timer":        "_tx_timer_",
    "Other":        "_tx_",
}

result = subprocess.check_output(
    ["arm-none-eabi-nm", "-S", ELF],
    text=True
)

sizes = defaultdict(lambda: {"count": 0, "size": 0})
total = 0

for line in result.splitlines():
    parts = line.split()

    if len(parts) < 4:
        continue

    address, size, symbol_type, name = parts[:4]

    if not re.fullmatch(r"[0-9a-fA-F]+", size):
        continue

    if not name.startswith("_tx_"):
        continue

    size = int(size, 16)

    # 按最长前缀匹配，避免 Other 抢先匹配
    module = "Other"

    for key, prefix in MODULES.items():
        if key != "Other" and name.startswith(prefix):
            module = key
            break

    sizes[module]["count"] += 1
    sizes[module]["size"] += size
    total += size

print(f"\nThreadX Flash Statistics: {ELF}\n")

print(f"{'Module':<15} {'Functions':>10} {'Bytes':>12} {'KB':>10} {'Ratio':>10}")
print("-" * 62)

for module, data in sorted(
    sizes.items(),
    key=lambda x: x[1]["size"],
    reverse=True
):
    ratio = data["size"] / total * 100 if total else 0

    print(
        f"{module:<15}"
        f"{data['count']:>10}"
        f"{data['size']:>12}"
        f"{data['size']/1024:>10.2f}"
        f"{ratio:>9.2f}%"
    )

print("-" * 62)
print(f"{'TOTAL':<15}{sum(x['count'] for x in sizes.values()):>10}"
      f"{total:>12}{total/1024:>10.2f}{100 if total else 0:>9.2f}%")

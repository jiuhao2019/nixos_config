#!/usr/bin/env fish

# ===== 你要循环的 workspace（手动指定）=====
# tab 或 shift+tab 只在这些tab里循环
set ws_list "󰼏 " "󰼐 󰨾"
# ===== 获取当前 workspace =====
set current (i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

# ===== 找当前索引 =====
set idx -1
for i in (seq (count $ws_list))
    if test "$ws_list[$i]" = "$current"
        set idx $i
        break
    end
end

# ===== 如果当前不在列表里 → 跳到第一个 =====
if test $idx -eq -1
    i3-msg workspace "$ws_list[1]"
    exit
end

# ===== next / prev =====
if test "$argv[1]" = "next"
    set idx (math "$idx + 1")
    if test $idx -gt (count $ws_list)
        set idx 1
    end
else
    set idx (math "$idx - 1")
    if test $idx -lt 1
        set idx (count $ws_list)
    end
end

# ===== 切换 =====
i3-msg workspace "$ws_list[$idx]"

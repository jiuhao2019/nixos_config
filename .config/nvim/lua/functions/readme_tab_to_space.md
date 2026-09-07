# Tab to Spaces Converter for Neovim

一个简单的Neovim插件，用于在选中行中将制表符（tab）和空格相互转换。

## 功能特性

- 将选中行中的制表符转换为空格
- 将选中行中的空格转换为制表符
- 可配置的tab宽度（默认4个空格）
- 支持视觉模式选择
- 提供命令和快捷键两种使用方式

## 安装

### 使用包管理器（推荐）

**Lazy.nvim:**

```lua
{
    "your-username/tab-to-spaces",
    config = function()
        require("tab_to_spaces").setup({
            tab_width = 4,  -- 每个tab转换为4个空格
            use_spaces = true,
        })
    end
}
```

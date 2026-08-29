# Repository Guidelines

## 项目概览

使用中文回答。
这是一个基于 **LazyVim** 的 Neovim 配置文件仓库。核心目标是提供一个可复用的 Neovim 配置模板，集成常用插件（如 CodeCompanion ACP、格式化工具、颜色主题等），并通过 `lazy.nvim` 管理插件生命周期。

- **用途**: 个人/团队 Neovim 配置起点，支持快速部署和扩展。
- **当前重点**: 通过 CodeCompanion 接入 `omp acp` 作为默认聊天 Agent。

## 架构与数据流

### 启动流程

```
init.lua
  └─ require("config.lazy")           -- 引导 lazy.nvim
       ├─ 若 lazy.nvim 不存在 → git clone 到 stdpath('data')/lazy/lazy.nvim
       └─ require("lazy").setup({
            spec = {
              { "LazyVim/LazyVim", import = "lazyvim.plugins" },  -- LazyVim 内置插件
              { import = "plugins" }                             -- 本地 lua/plugins/*.lua
            },
            defaults = { lazy = false },  -- 本地插件默认禁用延迟加载
            install = { colorscheme = { "tokyonight" } },
            checker = { enabled = true, notify = false },
            performance = {
              rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } }
            }
          })
```

### 配置加载顺序

1. **`lua/config/options.lua`** - 在 lazy 启动前设置基础选项（行号、剪贴板、诊断等）
2. **插件加载** - lazy.nvim 按需/启动时加载插件
3. **`lua/config/keymaps.lua`** - 在 `VeryLazy` 事件加载，删除 LazyVim 默认映射并添加自定义映射
4. **`lua/config/autocmds.lua`** - 在 `VeryLazy` 事件加载，添加自动命令

### 插件配置模式

每个插件文件（如 `lua/plugins/codecompanion.lua`）返回一个 Lua 表：

```lua
return {
  "作者/插件名",        -- 插件仓库地址
  dependencies = { ... }, -- 依赖
  opts = { ... },         -- 传递给插件 setup() 的选项
  keys = { ... },         -- 按键映射（触发延迟加载）
  event = "VeryLazy",     -- 触发事件（可选）
}
```

## 关键目录

| 目录/文件 | 用途 |
|-----------|------|
| `init.lua` | 入口点，引导 lazy.nvim 并配置 GUI（Neovide） |
| `lua/config/lazy.lua` | lazy.nvim 启动器和插件清单定义 |
| `lua/config/options.lua` | Neovim 基础选项（行号、剪贴板、LSP 诊断等） |
| `lua/config/keymaps.lua` | 自定义按键映射，覆盖 LazyVim 默认值 |
| `lua/config/autocmds.lua` | 自动命令（如文件末尾换行） |
| `lua/plugins/` | 插件配置目录，每个文件返回一个插件规范表 |
| `docs/` | CodeCompanion ACP 集成设计和配置文档 |
| `lazyvim.json` | LazyVim 扩展清单和版本声明 |
| `lazy-lock.json` | 插件提交 SHA 锁定文件 |

## 开发命令

### 插件管理

```bash
# 打开 Neovim 并同步插件
nvim

# 在 Neovim 中:
# :Lazy sync    - 安装/更新插件
# :Lazy update  - 更新插件
# :Lazy clean   - 清理禁用/未使用插件
```

### 配置验证

```bash
# 检查 Lua 语法
nvim --headless -c 'luafile lua/plugins/codecompanion.lua' -c 'q'

# 检查所有插件配置
for f in lua/plugins/*.lua; do
  nvim --headless -c "luafile $f" -c 'q' 2>&1 || echo "FAIL: $f"
done
```

### 代码格式化

```bash
# 使用 StyLua 格式化 Lua 文件
stylua lua/

# StyLua 配置: 2 空格缩进, 120 列宽度
```

### Git 工作流

```bash
# 当前开发分支: feat/add-codecompanion.nvim
# 主分支: main

git checkout -b feat/新功能名
# 修改配置...
git add lua/plugins/xxx.lua
git commit -m "feat: 添加 xxx 插件配置"
```

## 代码约定与常见模式

### 插件配置约定

- **文件名**: 使用 kebab-case（如 `codecompanion.lua`, `colorscheme.lua`）
- **返回值**: 每个文件返回一个表或表数组
- **opts 结构**: 直接传递选项给插件，不进行包装或拦截
- **依赖声明**: 在 `dependencies` 字段中列出运行时依赖

### 按键映射模式

```lua
local map = vim.keymap.set
local unmap = vim.keymap.del

-- 删除默认映射
unmap("n", "<leader>fT", { desc = "Terminal (cwd)" })

-- 添加自定义映射
map("n", "<leader>aa", "<cmd>CodeCompanionChat<cr>", { desc = "CodeCompanion Chat" })
map("n", "<M-F12>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })
```

### GUI 配置（Neovide）

仅在 `vim.g.neovide` 为真时应用：

```lua
if vim.g.neovide then
  vim.g.neovide_title_background_color = string.format("%x", ...)
  vim.o.guifont = "JetBrainsMono Nerd Font:h16"
  vim.g.neovide_title_text_color = "pink"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end
```

### ACP 适配器配置模式

```lua
-- 方式 1: 简单自定义适配器
adapters = {
  omp = {
    type = "custom",
    command = "omp",
    args = { "acp" },
  },
}

-- 方式 2: 扩展预设适配器
adapters = {
  acp = {
    gemini_cli = function()
      return require("codecompanion.adapters").extend("gemini_cli", {
        defaults = { auth_method = "gemini-api-key" },
        env = { GEMINI_API_KEY = "cmd:op read ..." },
      })
    end,
  },
}

-- 设置默认聊天适配器
interactions = {
  chat = {
    adapter = "omp",
  },
}
```

## 重要文件

### 入口点

- **`init.lua`** - 唯一入口，立即执行
- **`lua/config/lazy.lua`** - 插件管理器初始化和配置

### 配置文件

- **`lazyvim.json`** - LazyVim 扩展声明（version: 8, 12 个 extras）
- **`stylua.toml`** - Lua 格式化规则（2 空格, 120 列）
- **`.gitignore`** - 忽略 `lazy-lock.json`, `data/`, `debug/`, `.neoconf.json` 等

### 关键模块

- **`lua/config/options.lua`** - 基础选项设置
- **`lua/config/keymaps.lua`** - 按键映射（VeryLazy 加载）
- **`lua/config/autocmds.lua`** - 自动命令（VeryLazy 加载）
- **`lua/plugins/codecompanion.lua`** - CodeCompanion ACP 集成（含 `omp` 适配器）
- **`lua/plugins/formatter.lua`** - Conform 格式化配置
- **`lua/plugins/colorscheme.lua`** - Tokyo Night 主题配置

## 运行时与工具偏好

### 运行时

- **Neovim** - 主要运行环境
- **Lua** - 配置语言
- **lazy.nvim** - 插件管理器
- **LazyVim** - 插件集合框架（version 8）

### 平台支持

- **Windows 11** - 主要开发平台（`win32 10.0.26200`）
- **GUI**: Neovide（可选，仅在 `vim.g.neovide` 时启用）
- **字体**: JetBrainsMono Nerd Font h16

### 工具约束

- **格式化**: StyLua（强制，indent=2, column=120）
- **无测试框架**: 当前无自动化测试基础设施
- **无 CI/CD**: 无 GitHub Actions 或其他 CI 配置
- **无构建步骤**: 纯 Lua 配置，无需编译

## 测试与质量保证

### 当前状态

- ❌ **无自动化测试** - 仓库中无测试文件、测试框架或 CI 配置
- ✅ **语法验证** - 通过 `nvim --headless -c 'luafile <file>' -c 'q'` 手动验证
- ✅ **格式化检查** - StyLua 配置已定义，但未集成到 CI

### 建议实践

```bash
# 修改插件配置后，验证语法
nvim --headless -c 'luafile lua/plugins/新插件.lua' -c 'q'

# 启动 Neovim 并测试
nvim

# 在 Neovim 中手动测试:
# 1. 检查插件是否加载成功 (:Lazy)
# 2. 测试按键映射是否生效
# 3. 验证插件功能正常
```

### 未来改进方向

- 添加 `plenary.nvim` 测试框架支持
- 集成 StyLua 到 pre-commit hook
- 添加 GitHub Actions CI 配置
- 添加插件配置的单元测试

## 文档结构

```
docs/
├── acp-adapters.md              # CodeCompanion ACP 适配器配置指南
├── codecompanion-acp.md         # CodeCompanion ACP 功能参考
├── codecompanion-acp-design.md  # omp ACP 集成设计文档
└── superpowers/
    └── plans/
        └── 2026-08-29-codecompanion-acp-integration.md  # 实施计划
```

## 常见任务

### 添加新插件

1. 创建 `lua/plugins/新插件名.lua`
2. 返回插件规范表
3. 验证语法：`nvim --headless -c 'luafile lua/plugins/新插件名.lua' -c 'q'`
4. 提交：`git add lua/plugins/新插件名.lua && git commit -m "feat: 添加 新插件名 配置"`

### 修改现有插件配置

1. 编辑 `lua/plugins/对应插件.lua`
2. 验证语法
3. 在 Neovim 中测试：`:Lazy sync` 重启后检查效果

### 更新 LazyVim 版本

修改 `lazyvim.json` 中的 `version` 和 `install_version`，然后运行 `:Lazy update`

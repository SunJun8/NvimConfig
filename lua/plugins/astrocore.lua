-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

-- ============================================================
-- Environment-adaptive clipboard helpers (used by g.clipboard below)
-- Priority: local desktop (wl-copy / xsel) > tmux > OSC 52.
-- Local desktop terminals (GNOME Terminal etc.) do not support OSC 52,
-- so a real clipboard must win whenever one exists. Detection runs
-- once per session and is cached in cb_env_cache.
-- ============================================================
local cb_env_cache -- 'wl' | 'xsel' | 'tmux' | 'osc52'

local function detect_cb_env()
  -- 1) Wayland desktop (install wl-clipboard: sudo apt install wl-clipboard)
  if vim.env.WAYLAND_DISPLAY and vim.fn.executable('wl-copy') == 1
      and vim.fn.executable('wl-paste') == 1 then
    return 'wl'
  end
  -- 2) X11 / XWayland desktop. Probe once so a stale $DISPLAY (e.g. ssh -X
  --    without a reachable X server) falls through instead of breaking yank.
  if vim.env.DISPLAY and vim.fn.executable('xsel') == 1 then
    local ok = pcall(function() vim.fn.system({ 'xsel', '-o', '-b' }) end)
    if ok and vim.v.shell_error == 0 then
      return 'xsel'
    end
  end
  -- 3) Inside tmux: tmux mirrors to its buffer and forwards OSC 52 outward.
  if vim.env.TMUX then
    return 'tmux'
  end
  -- 4) Bare remote pty (herdr pane / plain ssh): emit OSC 52 directly.
  return 'osc52'
end

local function get_cb_env()
  if cb_env_cache == nil then
    cb_env_cache = detect_cb_env()
  end
  return cb_env_cache
end

-- Copy into a long-lived clipboard owner. xsel --nodetach / wl-copy must
-- stay alive to keep the selection; never call them via system() (blocking).
local function spawn_copy(lines, cmd)
  if _G.__cb_owner_job then
    pcall(function() vim.fn.jobstop(_G.__cb_owner_job) end)
    _G.__cb_owner_job = nil
  end
  local ok, job = pcall(vim.fn.jobstart, cmd, { detach = true })
  if ok and job > 0 then
    _G.__cb_owner_job = job
    vim.fn.chansend(job, vim.deepcopy(lines))
    vim.fn.chanclose(job, 'stdin')
  end
end

-- Compare clipboard content to the yank cache ignoring a trailing empty
-- line: a linewise yank caches ['aaa',''], while the system clipboard
-- reads back ['aaa']. Without normalization the equality check fails and
-- the regtype degrades to charwise (`yyp` pastes without a newline).
local function lines_equal(a, b)
  local na = vim.deepcopy(a)
  local nb = vim.deepcopy(b)
  while #na > 0 and na[#na] == '' do
    table.remove(na)
  end
  while #nb > 0 and nb[#nb] == '' do
    table.remove(nb)
  end
  return vim.deep_equal(na, nb)
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true,                                 -- enable autopairs at start
      cmp = true,                                       -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true,                              -- highlight URLs at start
      notifications = true,                             -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        defs = "make",
        script = "ld",
      },
      filename = {
        -- ["Foofile"] = "fooscript",
      },
      pattern = {
        -- ["~/%.config/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = {                  -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true,         -- sets vim.opt.number
        spell = false,         -- sets vim.opt.spell
        signcolumn = "yes",    -- sets vim.opt.signcolumn to yes
        wrap = false,          -- sets vim.opt.wrap
        clipboard = "unnamedplus"
      },
      g = {                    -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        -- ============================================================
        -- Clipboard provider: environment-adaptive (X11 / Wayland / tmux / OSC52)
        -- ------------------------------------------------------------
        -- 背景 (Background)
        --   本机经 SSH 使用 herdr(终端 workspace 管理器) 与 tmux 两种环境:
        --   - herdr pane / 裸 ssh: 无 $TMUX、无 $DISPLAY 的裸 pty
        --   - tmux 内: 有 $TMUX
        --   另有本机桌面直开 nvim 的场景(有 X11/Wayland 剪贴板)。
        --   nvim(0.11+, 当前 0.12.5) 剪贴板 provider 自动检测顺序:
        --     g:clipboard 显式配置 -> pbcopy -> wl-copy -> xsel/xclip(需 $DISPLAY)
        --     -> lemonade/win32yank/... -> tmux(需 $TMUX) -> osc52 兜底
        --     (需 g:termfeatures.osc52 且 &clipboard == '')
        --   问题: herdr pane 中无 $DISPLAY/$TMUX, 而本文件 opt.clipboard =
        --     "unnamedplus" 使 &clipboard 非空, osc52 兜底被挡 -> nvim 选不出
        --     任何 provider, `yy` 复制静默失败。2026-08 排查确认, 时间上同时
        --     伴随 herdr 0.8.2(8/24) 与 nvim 0.12.5(8/27) 升级。tmux 内则因
        --     $TMUX 命中 tmux provider, 复制一直正常。
        -- 方案 (Solution)
        --   显式 provider (vim.g.clipboard 表, 一旦设置即完全接管自动检测),
        --   copy/paste 按当前环境自适应 (环境只检测一次并缓存):
        --     1) 本地桌面 Wayland:  wl-copy / wl-paste (需 apt install wl-clipboard)
        --     2) 本地桌面 X11 或 XWayland: xsel; 检测时先试一次 xsel -o -b,
        --        避免 stale $DISPLAY(如 ssh -X 但无可用 X server)误选后失效
        --     3) tmux 内: `tmux load-buffer -w -` / `tmux save-buffer -`
        --        (tmux 同时把 OSC52 转发给支持 OSC52 写的外层终端)
        --     4) 其余(herdr pane / 裸 ssh 远程): OSC52 直接写 / paste 回退
        --        本会话最近一次复制的本地缓存(终端不支持 OSC52 读回)
        --   优先级理由: 本地桌面终端(GNOME Terminal 等)不支持 OSC52, 所以
        --   只要存在真实剪贴板(X11/Wayland)就优先使用, OSC52 只作远程兜底。
        --   关键细节 (易踩坑):
        --   - paste 必须返回 [lines, regtype] 两元素; 只返回行列表会被判为
        --     charwise, `yyp` 不再换行(内容贴到光标行尾)
        --   - paste 返回空 => `p` 报 E353 "Nothing in register"
        --   - 内置 osc52 paste 走终端读回查询, 等不到响应会卡 ~10s
        --     (Waiting for OSC 52 response...), 不可用作 paste
        --   - xsel --nodetach / wl-copy 必须用 jobstart+detach 保持进程以持有
        --     剪贴板所有权; 用 vim.fn.system() 同步调用会永久阻塞
        -- 后续可能问题与修复 (Future issues & fixes)
        --   1. 本地桌面直开: 由 wl/xsel 分支覆盖; 若 Wayland 桌面复制仍无效,
        --      先 `sudo apt install wl-clipboard` 再重启 nvim(检测有会话缓存)。
        --   2. 剪贴板实时读回: Windows Terminal 实测只支持 OSC52 写、不支持
        --      读回 (`ESC]52;c;?` 无响应), 故裸 ssh/herdr 下 `p` 拿到的是本地
        --      缓存而非剪贴板实时内容(终端能力限制, 配置无法绕过)。若换成
        --      支持读回的终端, 可将 paste 升级为"短超时(≈300ms) OSC52 读回
        --      -> 失败回退缓存"。
        --   3. tmux buffer 污染: 其他 pane 的 load-buffer / OSC52 set 会覆盖
        --      同一个默认 buffer, 导致 `p` 粘到非本次复制的旧内容。修复:
        --      load/save 改用命名 buffer(如 -b cb_自增ID), 或接受共享语义。
        --   4. tmux set-clipboard 若被改为 off, tmux 分支不再向外层转发 OSC52,
        --      复制将只进 tmux buffer; 需保持 set-clipboard on/external。
        --   5. nvim/herdr 升级: 显式 g:clipboard 不依赖自动检测链, 一般稳定;
        --      但 nvim 大版本若调整 provider 回调签名/返回格式, 按 :h clipboard
        --      重新核对。
        --   6. 验证注意: nvim --headless 不会真正调用 clipboard provider
        --      (copy 函数不执行), 必须用真实终端里的真实 nvim 验证行为;
        --      环境检测有会话级缓存, 改环境后需重启 nvim。
        -- ============================================================
        clipboard = {
          name = "env-adaptive",
          cache_enabled = 0,
          copy = {
            ['+'] = function(lines, regtype)
              _G.__cb_rt_plus = regtype
              _G.__cb_cache_plus = vim.deepcopy(lines)
              local env = get_cb_env()
              if env == 'wl' then
                spawn_copy(lines, { 'wl-copy', '--type', 'text/plain' })
              elseif env == 'xsel' then
                spawn_copy(lines, { 'xsel', '--nodetach', '-i', '-b' })
              elseif env == 'tmux' then
                vim.fn.system({ 'tmux', 'load-buffer', '-w', '-' }, lines)
              else
                require('vim.ui.clipboard.osc52').copy('+')(lines)
              end
            end,
            ['*'] = function(lines, regtype)
              _G.__cb_rt_star = regtype
              _G.__cb_cache_star = vim.deepcopy(lines)
              local env = get_cb_env()
              if env == 'wl' then
                spawn_copy(lines, { 'wl-copy', '--primary', '--type', 'text/plain' })
              elseif env == 'xsel' then
                spawn_copy(lines, { 'xsel', '--nodetach', '-i', '-p' })
              elseif env == 'tmux' then
                vim.fn.system({ 'tmux', 'load-buffer', '-w', '-' }, lines)
              else
                require('vim.ui.clipboard.osc52').copy('*')(lines)
              end
            end,
          },
          paste = {
            ['+'] = function()
              local env = get_cb_env()
              local lines
              if env == 'wl' then
                lines = vim.fn.systemlist({ 'wl-paste', '--no-newline' })
              elseif env == 'xsel' then
                lines = vim.fn.systemlist({ 'xsel', '-o', '-b' })
              elseif env == 'tmux' then
                lines = vim.fn.systemlist({ 'tmux', 'save-buffer', '-' })
              else
                if _G.__cb_cache_plus then
                  return { _G.__cb_cache_plus, _G.__cb_rt_plus or 'v' }
                end
                return { { '' }, 'v' }
              end
              local rt = _G.__cb_rt_plus
              if rt == nil or _G.__cb_cache_plus == nil
                  or not lines_equal(lines, _G.__cb_cache_plus) then
                rt = #lines > 1 and 'V' or 'v'
              end
              return { lines, rt }
            end,
            ['*'] = function()
              local env = get_cb_env()
              local lines
              if env == 'wl' then
                lines = vim.fn.systemlist({ 'wl-paste', '--no-newline', '--primary' })
              elseif env == 'xsel' then
                lines = vim.fn.systemlist({ 'xsel', '-o', '-p' })
              elseif env == 'tmux' then
                lines = vim.fn.systemlist({ 'tmux', 'save-buffer', '-' })
              else
                if _G.__cb_cache_star then
                  return { _G.__cb_cache_star, _G.__cb_rt_star or 'v' }
                end
                return { { '' }, 'v' }
              end
              local rt = _G.__cb_rt_star
              if rt == nil or _G.__cb_cache_star == nil
                  or not lines_equal(lines, _G.__cb_cache_star) then
                rt = #lines > 1 and 'V' or 'v'
              end
              return { lines, rt }
            end,
          },
        },
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
      },
    },
  },
}

-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = {
        icons = {
          ActiveLSP = "",
          ActiveTS = " ",
          BufferClose = "",
          DapBreakpoint = "",
          DapBreakpointCondition = "",
          DapBreakpointRejected = "",
          DapLogPoint = "",
          DapStopped = "",
          DefaultFile = "",
          Diagnostic = "",
          DiagnosticError = "",
          DiagnosticHint = "",
          DiagnosticInfo = "",
          DiagnosticWarn = "",
          Ellipsis = "",
          FileModified = "",
          FileReadOnly = "",
          FoldClosed = "",
          FoldOpened = "",
          FolderClosed = "",
          FolderEmpty = "",
          FolderOpen = "",
          Git = "",
          GitAdd = "",
          GitBranch = "",
          GitChange = "",
          GitConflict = "",
          GitDelete = "",
          GitIgnored = "",
          GitRenamed = "",
          GitStaged = "",
          GitUnstaged = "",
          GitUntracked = "",
          LSPLoaded = "",
          LSPLoading1 = "",
          LSPLoading2 = "",
          LSPLoading3 = "",
          MacroRecording = "",
          Paste = "",
          Search = "",
          Selected = "",
          TabClose = "",
        },
      },
    },
    {
      "onsails/lspkind.nvim",
      opts = function(_, opts)
        -- use codicons preset
        opts.preset = "codicons"
        -- set some missing symbol types
        opts.symbol_map = {
          Array = "",
          Boolean = "",
          Key = "",
          Namespace = "",
          Null = "",
          Number = "",
          Object = "",
          Package = "",
          String = "",
        }
      end,
    },
  }
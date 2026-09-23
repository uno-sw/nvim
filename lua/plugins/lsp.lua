return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
        },
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local servers = {
        "clangd",
        "gopls",
        "intelephense",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "svelte",
        "ts_ls",
      }

      -- 環境によって mason で導入できない language server を NVIM_MASON_SKIP で除外する。
      -- 例: 開発コンテナには Go ツールチェインが無く、clangd は linux/arm64 向けの
      -- 事前ビルドバイナリが提供されていない。
      local skip = {}
      for _, name in
      ipairs(vim.split(vim.env.NVIM_MASON_SKIP or "", ",", { trimempty = true }))
      do
        skip[vim.trim(name)] = true
      end

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_filter(function(name)
          return not skip[name]
        end, servers),
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities =
          require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("clangd", {
        capabilities = capabilities,
        cmd = { "clangd", "--header-insertion=never" },
      })

      vim.lsp.config("gopls", {
        capabilities = capabilities,
      })

      vim.lsp.config("intelephense", {
        capabilities = capabilities,
        -- lspconfig の既定は { ".git", "composer.json" } で .git が優先されるため、
        -- Laravel がサブディレクトリにある構成だとリポジトリルートが root_dir になり
        -- 無関係な PHP まで走査される。composer.json のある階層を優先する。
        root_markers = { { "composer.json" }, ".git" },
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              },
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.lsp.config("pyright", {
        capabilities = capabilities,
      })

      vim.lsp.config("rust-analyzer", {
        capabilities = capabilities,
      })

      vim.lsp.config("svelte", {
        capabilities = capabilities,
      })

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
      })

      -- Dart は Flutter/Dart SDK 同梱の dartls を使う (mason 管理外)。
      -- dart 実体は「プロジェクトの mise → プロジェクトの fvm → PATH」の
      -- 優先順位でプロジェクトルートごとに解決する。
      local dart_exe_cache = {}

      local function resolve_dart_exe(root)
        if dart_exe_cache[root] ~= nil then
          return dart_exe_cache[root]
        end

        local exe

        -- 1. プロジェクトの mise: そのディレクトリで dart がアクティブなら
        --    `mise which dart` が実体パスを返す (未設定だと非ゼロ終了)。
        if vim.fn.executable("mise") == 1 then
          local r = vim
              .system({ "mise", "which", "dart" }, { cwd = root, text = true })
              :wait(2000)
          if r.code == 0 then
            local p = vim.trim(r.stdout or "")
            if p ~= "" and vim.uv.fs_stat(p) then
              exe = p
            end
          end
        end

        -- 2. プロジェクトの fvm: <root>/.fvm/flutter_sdk/bin/dart
        if not exe then
          local fvm = vim.fs.find(
            ".fvm",
            { path = root, upward = true, type = "directory" }
          )[1]
          if fvm then
            local p = fvm .. "/flutter_sdk/bin/dart"
            if vim.uv.fs_stat(p) then
              exe = p
            end
          end
        end

        -- 3. フォールバック: PATH 上の dart
        exe = exe or "dart"
        dart_exe_cache[root] = exe
        return exe
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dart",
        callback = function(ev)
          local root = vim.fs.root(ev.buf, { ".fvm", "pubspec.yaml", ".git" })
              or vim.fn.getcwd()
          local dart = resolve_dart_exe(root)
          -- 同一 name + root_dir なら既存クライアントに再アタッチされる。
          vim.lsp.start({
            name = "dartls",
            cmd = { dart, "language-server", "--protocol=lsp" },
            root_dir = root,
            capabilities = capabilities,
            settings = {
              dart = {
                completeFunctionCalls = true,
                showTodos = true,
              },
            },
          })
        end,
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function()
      require("lsp_signature").setup()
    end,
  },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    },
  },
}

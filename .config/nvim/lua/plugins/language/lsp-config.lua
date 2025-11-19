local map = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = 0, desc = desc })
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { "folke/snacks.nvim" },
    { "aznhe21/actions-preview.nvim" },
  },
  config = function()
    local snacks = require("snacks")
    local actions_preview = require("actions-preview")
    actions_preview.setup({
      highlight_command = { require("actions-preview.highlight").delta() },
      backend = { "snacks" },
      snacks = { layout = { preset = "ivy" } },
    })
    vim.api.nvim_create_autocmd("LspAttach", {
      -- group = vim.api.nvim_create_augroup("my.lsp", {}),
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        -- vim.print(client)
        if client:supports_method("textDocument/definition") then
          map("gd", snacks.picker.lsp_definitions, "[g]o to [d]efinition")
        end
        if client:supports_method("textDocument/declaration") then
          map("gD", snacks.picker.lsp_declarations, "[g]o to [D]eclaration")
        end
        if client:supports_method("textDocument/references") then
          map("grr", snacks.picker.lsp_references, "[g]o to [r]eferences [r]")
        end
        if client:supports_method("textDocument/codeAction") then
          map("gra", actions_preview.code_actions, "[g]o to code [r] [a]ctions")
        end
        if client:supports_method("textDocument/implementation") then
          map("gri", snacks.picker.lsp_implementations, "[g]o to [r] [i]mplementations")
        end
        if client:supports_method("textDocument/typeDefinition") then
          map("grt", snacks.picker.lsp_type_definitions, "[g]o to [r] [t]ype definitions")
        end
        if client:supports_method("textDocument/documentSymbol") then
          map("gO", snacks.picker.lsp_symbols, "[g][O] to document symbols")
        end
        if client:supports_method("workspace/symbol") then
          map("go", snacks.picker.lsp_workspace_symbols, "[g][o] to workspace symbols")
        end
      end,
    })
    vim.lsp.config("basedpyright", {
      -- capabilities = {
      --   textDocument = {
      --     hover = {
      --       contentFormat = { "plaintext" },
      --     },
      --     completion = { completionItem = { documentationFormat = { "plaintext" } } },
      --     signatureHelp = { signatureInformation = { documentationFormat = { "plaintext" } } },
      --   },
      -- },
      settings = {
        basedpyright = {
          typeCheckingMode = "off",
          -- analysis = { diagnosticSeverityOverrides = { reportAttributeAccessIssue = "information" } },
        },
      },
    })
    -- JS/TS
    vim.lsp.enable("biome")
    vim.lsp.enable("denols")
    vim.lsp.enable("vtsls")
    -- Lua
    vim.lsp.enable("lua_ls")
    -- Python
    vim.lsp.enable("basedpyright")
    vim.lsp.enable("ruff")
    vim.lsp.enable("ty")
  end,
}
-- return {
--   "neovim/nvim-lspconfig",
--   dependencies = {
--     {
--       "folke/lazydev.nvim",
--       ft = "lua", -- only load on lua files
--       opts = {
--         library = {
--           -- See the configuration section for more details
--           -- Load luvit types when the `vim.uv` word is found
--           { path = "${3rd}/luv/library", words = { "vim%.uv" } },
--         },
--       },
--     },
--     { "saghen/blink.cmp" },
--   },
--   config = function()
--     local capabilities = require("blink.cmp").get_lsp_capabilities()
--     local lspconfig = require("lspconfig")
--     local on_attach = function(client, bufnr)
--       local map = require("utils").set_local_keymap
--       map("n", "gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
--       map("n", "gd", require("telescope.builtin").lsp_definitions, "[g]o to [d]efinition")
--       map("n", "gr", require("telescope.builtin").lsp_references, "[g]o to [r]eferences")
--       map("n", "<leader>rrn", vim.lsp.buf.rename, "[r]eally [r]e[n]ame")
--     end
--
--     -- Monkeypatch to make all floating windows have borders
--     local _open_floating_preview = vim.lsp.util.open_floating_preview
--     vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
--       opts = opts or {}
--       opts.border = opts.border or "rounded"
--       return _open_floating_preview(contents, syntax, opts, ...)
--     end
--
--     lspconfig.bashls.setup({ capabilities = capabilities, on_attach = on_attach })
--     lspconfig.biome.setup({ capabilities = capabilities, on_attach = on_attach, single_file_support = true })
--     lspconfig.lua_ls.setup({ capabilities = capabilities, on_attach = on_attach })
--     -- lspconfig.ruff_lsp.setup({ capabilities = capabilities, on_attach = on_attach, single_file_support = true })
--     lspconfig.taplo.setup({ capabilities = capabilities, on_attach = on_attach })
--     lspconfig.ty.setup({ capabilities = capabilities, on_attach = on_attach })
--     vim.lsp.enable("ty")
--     lspconfig.vimls.setup({ capabilities = capabilities, on_attach = on_attach })
--     lspconfig.vtsls.setup({ capabilities = capabilities, on_attach = on_attach })
--
--     -- markdown makes weird escape codes, so use plaintext
--     -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#markupContent
--     -- Search above page for "MarkupKind"
--     lspconfig.basedpyright.setup({
--       capabilities = vim.tbl_deep_extend("force", capabilities, {
--         textDocument = {
--           hover = {
--             contentFormat = { "plaintext" },
--           },
--           completion = { completionItem = { documentationFormat = { "plaintext" } } },
--           signatureHelp = { signatureInformation = { documentationFormat = { "plaintext" } } },
--         },
--       }),
--       on_attach = function()
--         vim.opt_local.textwidth = 88
--         on_attach()
--       end,
--       settings = {
--         basedpyright = {
--           typeCheckingMode = "off",
--           analysis = { diagnosticSeverityOverrides = { reportAttributeAccessIssue = "information" } },
--         },
--       },
--     })
--     lspconfig.ruff.setup({
--       on_attach = function(client, bufnr)
--         client.server_capabilities.hoverProvider = false
--       end,
--     })
--     -- lspconfig.pyright.setup({ capabilities = capabilities, on_attach = on_attach })
--
--     -- This is so we can use it in virtual environment setup
--     -- lspconfig.pylsp_config = {
--     --   capabilities = capabilities,
--     --   cmd = {
--     --     "/home/doeke/Projects/python-lsp-server/.venv/bin/pylsp",
--     --     "-vv",
--     --     "--log-file",
--     --     "/home/doeke/my_pylsp_log.txt",
--     --   },
--     --   settings = {
--     --     pylsp = {
--     --       plugins = {
--     --         autopep8 = { enabled = false },
--     --         flake8 = { enabled = false },
--     --         mccabe = { enabled = false },
--     --         preload = { enabled = false },
--     --         pycodestyle = { enabled = false },
--     --         pydocstyle = { enabled = false },
--     --         pyflakes = { enabled = false },
--     --         pylint = { enabled = false },
--     --         rope_autoimport = {
--     --           enabled = false,
--     --           completions = { enabled = false },
--     --           code_actions = { enabled = false },
--     --         },
--     --         rope_completion = { enabled = false },
--     --         yapf = { enabled = false },
--     --       },
--     --     },
--     --   },
--     --   on_attach = function(client, bufnr)
--     --     vim.opt_local.textwidth = 88
--     --     on_attach(client, bufnr)
--     --   end,
--     -- }
--     -- lspconfig.pylsp.setup(lspconfig.pylsp_config)
--   end,
-- }

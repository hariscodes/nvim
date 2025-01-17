local lspconfig = require("lspconfig")
local cmp_lsp_default_capabilities = require("cmp_nvim_lsp").default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'rust_analyzer', 'lua_ls', 'templ', 'html', 'htmx', 'tailwindcss', 'gopls' }
})

-- Zig
lspconfig.zls.setup({})

-- TypeScript
lspconfig.tsserver.setup({})

-- Rust
lspconfig.rust_analyzer.setup({})

-- Lua
lspconfig.lua_ls.setup({
  capabilities = cmp_lsp_default_capabilities,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then return end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        },
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      },
    })
  end,
  settings = {
    Lua = {},
  },
})

-- Python
lspconfig.pyright.setup({
  capabilities = cmp_lsp_default_capabilities,
})

lspconfig.marksman.setup({})

-- HTML
lspconfig.html.setup({
  filetypes = { "html", "templ" },
})

-- HTMX
lspconfig.htmx.setup({
  filetypes = { "html", "templ" },
})

-- Tailwind
lspconfig.tailwindcss.setup({
  filetypes = { "templ", "astro", "javascript", "typescript", "react" },
  init_options = { userLanguages = { templ = "html" } },
})

-- templ
vim.filetype.add({ extension = { templ = "templ" } })

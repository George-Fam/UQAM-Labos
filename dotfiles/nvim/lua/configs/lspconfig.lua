-- Load NVChad defaults
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- Custom on_attach that enables semantic tokens if supported
local function my_on_attach(client, bufnr)
  if client.server_capabilities.semanticTokensProvider then
    vim.lsp.semantic_tokens.start(bufnr, client.id)
  end

  -- Also run NVChad’s default on_attach
  if nvlsp.on_attach then
    nvlsp.on_attach(client, bufnr)
  end
end

-- Capabilities
local capabilities = nvlsp.capabilities

----------------------------------------------------------------------
--                          CLANGD
----------------------------------------------------------------------

vim.lsp.config("clangd", {
  on_attach = my_on_attach,
  capabilities = capabilities,
})

----------------------------------------------------------------------
--                   SERVERS WITH DEFAULT CONFIG
----------------------------------------------------------------------

local servers = { "html", "cssls" }

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities,
  })
end

----------------------------------------------------------------------
--                        ENABLE LSPs
----------------------------------------------------------------------

vim.lsp.enable({
  "clangd",
  "html",
  "cssls",
  -- add more here when needed
})

----------------------------------------------------------------------
--                   TYPESCRIPT (EXAMPLE)
----------------------------------------------------------------------
-- vim.lsp.config("ts_ls", {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = capabilities,
-- })
-- vim.lsp.enable({ "ts_ls" })

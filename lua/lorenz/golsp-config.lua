local lspconfig = require('lspconfig')
local lastRootPath = nil
local gomodpath = vim.trim(vim.fn.system("go env GOPATH")) .. "/pkg/mod"

lspconfig.gopls.setup({
  root_dir = function(fname)
    local fullpath = vim.fn.expand(fname, ":p")
    if string.find(fullpath, gomodpath) and lastRootPath ~= nil then
        return lastRootPath
    end
    local root = lspconfig.util.root_pattern("go.mod", ".git")(fname)
    if root ~= nil then
        lastRootPath = root
    end
    return root
  end,
})

lspconfig.templ.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "templ", "astro", "javascript", "typescript", "react" },
  init_options = { userLanguages = { templ = "html" } },
})

lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ" },
})

lspconfig.htmx.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ" },
})

lspconfig.unocss.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "javascriptreact", "rescript", "typescriptreact", "vue", "svelte", "templ"}
}

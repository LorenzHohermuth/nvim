local nvim_lsp = require('lspconfig')
local lastRootPath = nil
local gomodpath = vim.trim(vim.fn.system("go env GOPATH")) .. "/pkg/mod"

nvim_lsp.gopls.setup({
  root_dir = function(fname)
    local fullpath = vim.fn.expand(fname, ":p")
    if string.find(fullpath, gomodpath) and lastRootPath ~= nil then
        return lastRootPath
    end
    local root = nvim_lsp.util.root_pattern("go.mod", ".git")(fname)
    if root ~= nil then
        lastRootPath = root
    end
    return root
  end,
})

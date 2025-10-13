-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- -- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

-- Changes indents from 4 to 2 for specific files because of language conventions
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "css", "scss", "html", "json", "yaml", "toml", "graphql",
    "tsx", "jsx", "typescript", "typescriptreact", "ts",
    "javascript", "javascriptreact", "js", "svelte",
    "sql", "query", "md", "markdown", "sh", "bash", "lua"
  },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.bo.autoindent = true
  end,
})


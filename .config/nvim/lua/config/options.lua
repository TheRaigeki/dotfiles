-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Additional Configs
vim.g.autoformat = false -- IMPORTANT: Disables the autoformat and autoindent, which is needed if working on open source projects with different indent settings

-- Basic Configs
vim.g.mapleader = " " -- sets SPACE to the leader for special commands

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true -- enables line numbers

vim.opt.title = true -- shows the file name in the terminal title
vim.opt.shiftwidth = 4 -- defines 4 spaces as indent as default (some file with 2 defined in autocmds)
vim.opt.tabstop = 4 -- defines 4 spaces as indent with tabs (some file with 2 defined in autocmds)
vim.opt.autoindent = true
vim.opt.smartindent = true -- extended indent
vim.opt.smarttab = true
vim.opt.expandtab = true -- change tabs to spaces
vim.opt.breakindent = true -- keeps the indent, even line will be switched
vim.opt.hlsearch = true -- highlights search results
vim.opt.backup = false -- disables backups
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2 -- always shows the statusbar
vim.opt.scrolloff = 8 -- keeps the cursor on 10th line from above while scolling up
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" } -- do not take any backups of these folders
vim.opt.inccommand = "split" -- shows preview of incremental rename
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.wrap = false -- No Wrap lines
vim.opt.swapfile = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({
    "*/node_modules/*",
    "*/build/*",
    "*/target/*",
    "*/venv/*",
    "*/.venv/*",
    "*/__pycache__/*",
    "*/.git/*",
    "*.a",
    "*.o",
}) -- defines, which folders should be ignored while searching
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "cursor" -- keeps the cursor at the same position while splitting windows
vim.opt.mouse = "" -- disables mouse

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments for longer comments
vim.opt.formatoptions:append({ "r" })

-- sets the fileformat for .astro files to astro and for Podfile files (like in iOS Development) to Ruby files
vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

-- checks if the used nvim version is 0.8 or above and if so, it sets cmdheight to 0 so the cmd line is just visible if used and not everytime
if vim.fn.has("nvim-0.8") == 1 then
    vim.opt.cmdheight = 0
end

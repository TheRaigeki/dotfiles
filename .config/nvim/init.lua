if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")

-- MINIMAL CONFIGURATION, IF I HAVE A BUG OR WEIRD BEHAVIOR, TO TEST WITH LESS PLUGINS
-- COMMENT OUT EVERYTHING ABOVE, SO THAT THE ACTUAL PLUGINS AND CONFIGS WILL NOT LOAD
--
-- vim.o.shiftwidth = 2
-- vim.o.tabstop = 2
-- vim.o.expandtab = true
-- vim.o.smartindent = true
-- vim.o.autoindent = true
--
-- local ensure_packer = function()
--     local fn = vim.fn
--     local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
--     if fn.empty(fn.glob(install_path)) > 0 then
--         fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--         vim.cmd [[packadd packer.nvim]]
--         return true
--     end
--     return false
-- end
--
-- local packer_bootstrap = ensure_packer()
--
-- require('packer').startup(function(use)
--     use {'wbthomason/packer.nvim'}  -- Packer selbstverwaltend
--     use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}  -- Treesitter
--     use {'windwp/nvim-autopairs'}
--     use {'tpope/vim-sleuth'}  -- Sleuth für automatische Einrückung
--
--     if packer_bootstrap then
--         require('packer').sync()
--     end
-- end)
--
-- require'nvim-treesitter.configs'.setup {
--     ensure_installed = {"html", "css", "tsx", "typescript", "javascript"},
--     sync_install = false,
--     auto_install = true,
--     highlight = {
--         enable = true,
--         additional_vim_regex_highlighting = false,
--     },
--     autotags = {
--         enable = true,
--     },
-- }
--

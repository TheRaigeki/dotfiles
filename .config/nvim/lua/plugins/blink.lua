return {
    {
        'saghen/blink.cmp',
        lazy = false,
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = 'default',
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<Tab>'] = {
                    function(cmp)
                        if cmp.snippet_active() then return cmp.accept()
                        else return cmp.select_and_accept() end
                    end,
                    'snippet_forward',
                    'fallback'
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                cmdline = {},
            },
            completion = {
                list = {
                    max_items = 200,
                    selection = 'manual',
                },
                menu = {
                    max_height = 10,
                    scrollbar = true,
                },
                ghost_text = {
                    enabled = false,
                }
            },
            enabled = function()
                return vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
            end,
        },
    },
}

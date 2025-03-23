vim.g.augment_disable_completions = true
return {
    {
        'augmentcode/augment.vim',
        config = function()
            vim.g.augment_enable = 1

            vim.keymap.set('n', '<leader>as', '<cmd>Augment status<cr>')
            vim.keymap.set('n', '<leader>ac', '<cmd>Augment chat<cr>')
            vim.keymap.set('n', '<leader>an', '<cmd>Augment chat-new<cr>')
            vim.keymap.set('n', '<leader>aa', '<cmd>Augment chat-toggle<cr>')
            vim.keymap.set('n', '<leader>al', '<cmd>Augment log<cr>')
            vim.keymap.set('n', '<leader>y', '<cmd>call augment#Accept()<cr>')
        end,
    }
}

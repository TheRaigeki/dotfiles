return {
    {
        enabled = false,
        "folke/flash.nvim",
        ---@type Flash.Config
        opts = {
            search = {
                forward = true,
                multi_window = false,
                wrap = false,
                incremental = true,
            },
        },
    },
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {
                "<leader>fP",
                function()
                    require("telescope.builtin").find_files({
                        cwd = require("lazy.core.config").options.root,
                    })
                end,
                desc = "Find Plugin File",
            },
            {
                ";f",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.find_files({
                        no_ignore = false,
                        hidden = true,
                    })
                end,
                desc = "Lists files in your current working directory, respects .gitignore",
            },
            {
                ";g",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.git_files({
                        no_ignore = false,
                        hidden = true,
                    })
                end,
                desc = "Fuzzy search through the output of git ls-files command, respects .gitignore",
            },
            {
                ";r",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.live_grep()
                end,
                desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
            },
            {
                "\\\\",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.buffers()
                end,
                desc = "Lists open buffers",
            },
            {
                ";t",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.help_tags()
                end,
                desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
            },
            {
                ";;",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.resume()
                end,
                desc = "Resume the previous telescope picker",
            },
            -- {
            --   ";e",
            --   function()
            --     local builtin = require("telescope.builtin")
            --     builtin.diagnostics()
            --   end,
            --   desc = "Lists Diagnostics for all open buffers or a specific buffer",
            -- },
            {
                ";s",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.treesitter()
                end,
                desc = "Lists Function names, variables, from Treesitter",
            },
        },
        config = function(_, opts)
            opts = opts or {}
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local rg_excludes = function()
                return {
                    "-g", "!node_modules/**",
                    "-g", "!build/**",
                    "-g", "!.vscode/**",
                    "-g", "!target/**",
                    "-g", "!venv/**",
                    "-g", "!.venv/**",
                    "-g", "!__pycache__/**",
                    "-g", "!.git/**",
                    "-g", "!*.a",
                    "-g", "!*.o",
                    "-g", "!*-lock.json",
                    "-g", "!.cargo",
                    "-g", "!.lock",
                }
            end

            opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
                wrap_results = true,
                layout_strategy = "horizontal",
                layout_config = { prompt_position = "top" },
                sorting_strategy = "ascending",
                winblend = 0,
                mappings = {
                    n = {},
                },
            })
            opts.pickers = {
                diagnostics = {
                    theme = "ivy",
                    initial_mode = "normal",
                    layout_config = {
                        preview_cutoff = 9999,
                    },
                },
                live_grep = {
                    additional_args = rg_excludes,
                },
                grep_string = {
                    additional_args = rg_excludes,
                }
            }
            telescope.setup(opts)
            require("telescope").load_extension("fzf")
        end,
    },
}

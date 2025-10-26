return {
    -- install and register lsp server and tools for nvim-lspconfig
    {
        "mason-org/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "stylua",
                "html-lsp",
                'dcm',
                "selene",
                "luacheck",
                "tailwindcss-language-server",
                "typescript-language-server",
                "css-lsp",
                "rust-analyzer",
                "yaml-language-server",
                "angular-language-server",
            })
        end,
    },

    -- lsp servers
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = { enabled = false },
            -- @type lspconfig.options
            servers = {
                ['*'] = {
                    keys = {
                        {
                            "gd",
                            function()
                                require("telescope.builtin").lsp_definitions({ reuse_win = false })
                            end,
                            desc = "Goto Definition",
                            has = "definition",
                        },
                    },
                },
                cssls = {},
                tailwindcss = {
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern(".git")(...)
                    end,
                },
                tsserver = {
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern(".git", "package.json", "tsconfig.json", "jsconfig.json", ".eslint.json", ".luarc.json")(...)
                    end,
                    single_file_support = false,
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "literal",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = false,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                        javascript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                    },
                },
                jsonls = {
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern(".git", "package.json", "tsconfig.json", "jsconfig.json", ".eslint.json", ".luarc.json")(...)
                    end,
                    settings = {
                        json = {
                            schemas = require('schemastore').json.schemas(),
                            validate = { enable = true },
                        },
                    },
                },
                eslint = {
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern(".eslint.json", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc")(...)
                    end,
                    settings = {
                        validate = "on",
                        packageManager = "npm",
                        autoFixOnSave = false,
                        codeAction = {
                            disableRuleComment = {
                                enable = true,
                                location = "separateLine",
                            },
                            showDocumentation = {
                                enable = true,
                            },
                        },
                        format = {
                            enable = true,
                        },
                        lintTask = {
                            enable = true,
                        },
                        nodePath = "",
                        onIgnoredFiles = "off",
                        options = {},
                        run = "onType",
                        useESLintClass = false,
                    },
                    handlers = {
                        ["eslint/noLibrary"] = function()
                            return {}
                        end,
                    },
                    filetypes = {
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                        "vue",
                        "svelte",
                    },
                },
                html = {},
                yamlls = {
                    settings = {
                        yaml = {
                            keyOrdering = false,
                        },
                    },
                },
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            procMacro = { enable = true },
                            cargo = { allFeatures = true },
                            checkOnSave = {
                                command = "clippy",
                                extraArgs = { "--no-deps" },
                            },
                        },
                    },
                },
                lua_ls = {
                    -- enabled = false,
                    single_file_support = true,
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                workspaceWord = true,
                                callSnippet = "Both",
                            },
                            misc = {
                                parameters = {
                                    -- "--log-level=trace",
                                },
                            },
                            hint = {
                                enable = true,
                                setType = false,
                                paramType = true,
                                paramName = "Disable",
                                semicolon = "Disable",
                                arrayIndex = "Disable",
                            },
                            doc = {
                                privateName = { "^_" },
                            },
                            type = {
                                castNumberToInteger = true,
                            },
                            diagnostics = {
                                disable = { "incomplete-signature-doc", "trailing-space" },
                                -- enable = false,
                                groupSeverity = {
                                    strong = "Warning",
                                    strict = "Warning",
                                },
                                groupFileStatus = {
                                    ["ambiguity"] = "Opened",
                                    ["await"] = "Opened",
                                    ["codestyle"] = "None",
                                    ["duplicate"] = "Opened",
                                    ["global"] = "Opened",
                                    ["luadoc"] = "Opened",
                                    ["redefined"] = "Opened",
                                    ["strict"] = "Opened",
                                    ["strong"] = "Opened",
                                    ["type-check"] = "Opened",
                                    ["unbalanced"] = "Opened",
                                    ["unused"] = "Opened",
                                },
                                unusedLocalExclude = { "_*" },
                            },
                            format = {
                                enable = false,
                                defaultConfig = {
                                    indent_style = "space",
                                    indent_size = "2",
                                    continuation_indent_size = "2",
                                },
                            },
                        },
                    },
                },
                angularls = {
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern('angular.json', 'project.json')(...)
                    end,
                    filetypes = { 'typescript', 'html', 'typescripthtml', 'htmlangular' },
                },
            },
            setup = {
                lua_ls = function(_, opts)
                    local capabilities = require("blink.cmp").get_lsp_capabilities()
                    require("lspconfig").lua_ls.setup { capabilities = capabilities }
                end,
                angularls = function()
                    LazyVim.lsp.on_attach(function(client)
                        -- HACK: Deactivate angulars rename capability to prevent double rename prompts
                        client.server_capabilities.renameProvider = false
                    end, "angularls")
                end,
            },
        },
        {
            "neovim/nvim-lspconfig",
            opts = function(_, opts)
                LazyVim.extend(opts.servers.tsserver, "settings.tsserver.globalPlugins", {
                    {
                        name = "@angular/language-server",
                        location = LazyVim.get_pkg_path("angular-language-server", "/node_modules/@angular/language-server"),
                        enableForWorkspaceTypeScriptVersions = false,
                    },
                })
            end,
        },
    },
}

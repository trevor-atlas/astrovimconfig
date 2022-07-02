local config = {

    -- Configure AstroNvim updates
    updater = {
        remote = "origin", -- remote to use
        channel = "nightly", -- "stable" or "nightly"
        version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
        branch = "main", -- branch name (NIGHTLY ONLY)
        commit = nil, -- commit hash (NIGHTLY ONLY)
        pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
        skip_prompts = false, -- skip prompts about breaking changes
        show_changelog = true -- show the changelog after performing an update
        -- remotes = { -- easily add new remotes to track
        --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
        --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
        --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
        -- },
    },

    -- Set colorscheme
    colorscheme = "default_theme",

    -- set vim options here (vim.<first_key>.<second_key> =  value)
    options = {
        opt = {
            relativenumber = true -- sets vim.opt.relativenumber
        },
        g = {
            mapleader = " " -- sets vim.g.mapleader
        }
    },

    -- Default theme configuration
    default_theme = {
        diagnostics_style = {
            italic = true
        },
        -- Modify the color table
        colors = {
            fg = "#abb2bf"
        },
        -- Modify the highlight groups
        highlights = function(highlights)
            local C = require "default_theme.colors"

            highlights.Normal = {
                fg = C.fg,
                bg = C.bg
            }
            return highlights
        end,
        plugins = { -- enable or disable extra plugin highlighting
            aerial = true,
            beacon = false,
            bufferline = true,
            dashboard = true,
            highlighturl = true,
            hop = false,
            indent_blankline = true,
            lightspeed = false,
            ["neo-tree"] = true,
            notify = true,
            ["nvim-tree"] = false,
            ["nvim-web-devicons"] = true,
            rainbow = true,
            symbols_outline = false,
            telescope = true,
            vimwiki = false,
            ["which-key"] = true
        }
    },

    -- Disable AstroNvim ui features
    ui = {
        nui_input = true,
        telescope_select = true
    },

    -- Configure plugins
    plugins = {
        -- Add plugins, the packer syntax without the "use"
        init = { -- You can disable default plugins as follows:
        -- ["goolord/alpha-nvim"] = { disable = true },
        -- You can also add new plugins here as well:
        -- { "andweeb/presence.nvim" },
        -- {
        --   "ray-x/lsp_signature.nvim",
        --   event = "BufRead",
        --   config = function()
        --     require("lsp_signature").setup()
        --   end,
        -- },

        {'tpope/vim-surround'},
        {'christoomey/vim-tmux-navigator'},
        {'nvim-lua/plenary.nvim'}, {"bobrown101/plugin-utils.nvim"}, {
            "bobrown101/asset-bender.nvim",
            requires = {"bobrown101/plugin-utils.nvim"},
            config = function()
                require("asset-bender").setup({})
            end
        }},

        lspconfig = function(config)
            local util = require("lspconfig/util")
            local Job = require("plenary.job")

            function getIsHubspotMachine()
                local result = ""
                local testing = {}
                Job:new({
                    command = "ls",
                    args = {vim.env.HOME .. '/.isHubspotMachine'},
                    on_exit = function(j, return_val)
                        result = return_val
                        testing = j
                    end
                }):sync()

                return return_val == 0
            end

            function getLogPath()
                return vim.lsp.get_log_path()
            end

            function getTsserverPath()
                local result = "/lib/tsserver.js"
                Job:new({
                    command = "bpx",
                    args = {"--path", "hs-typescript"},
                    on_exit = function(j, return_val)
                        local path = j:result()[1]
                        result = path .. result
                    end
                }):sync()

                return result
            end
            -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

            local customPublishDiagnosticFunction = function(_, result, ctx, config)
                local filter = function(fun, t)
                    local res = {}
                    for _, item in ipairs(t) do
                        if fun(item) then
                            res[#res + 1] = item
                        end
                    end

                    return res
                end
                local raw_diagnostics = result.diagnostics

                local filtered_diagnostics = filter(function(diagnostic)
                    local diagnostic_code = diagnostic.code
                    local diagnostic_source = diagnostic.source
                    return not (diagnostic_code == 7016 and diagnostic_source == "typescript")
                end, raw_diagnostics)

                result.diagnostics = filtered_diagnostics

                return vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
            end
            local isHubspotMachine = getIsHubspotMachine()

            if isHubspotMachine then

                require("lspconfig").tsserver.setup({
                    cmd = {"typescript-language-server", "--log-level", -- A number indicating the log level (4 = log, 3 = info, 2 = warn, 1 = error). Defaults to `2`.
                           "2", "--tsserver-log-verbosity", "terse", -- Specify tsserver log verbosity (off, terse, normal, verbose). Defaults to `normal`. example: --tsserver-log-verbosity=verbose
                           "--tsserver-log-file", getLogPath(), "--tsserver-path", getTsserverPath(), "--stdio"},
                    on_attach = on_attach,
                    root_dir = util.root_pattern(".git"),
                    filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact",
                                 "typescript.tsx"},
                    handlers = {
                        ["textDocument/publishDiagnostics"] = vim.lsp.with(customPublishDiagnosticFunction, {
                            -- Disable virtual_text
                            -- virtual_text = false
                        })
                    },
                    capabilities = capabilities

                })
            else
                require("lspconfig").tsserver.setup({})
            end
            -- npm install -g graphql-language-service-cli
            require'lspconfig'.graphql.setup {}

            -- yarn global add yaml-language-server
            require'lspconfig'.yamlls.setup {}
            require("lspkind").init({})

            vim.lsp.handlers['textDocument/signatureHelp'] =
                vim.lsp.with(vim.lsp.handlers.signature_help, {
                    border = 'single'
                })

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = 'single'
            })
        end,
        -- All other entries override the setup() call for default plugins
        ["null-ls"] = function(config)
            local null_ls = require "null-ls"
            -- Check supported formatters and linters
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
            config.sources = { -- Set a formatter
            null_ls.builtins.formatting.rufo, -- Set a linter
            null_ls.builtins.diagnostics.rubocop}
            -- set up null-ls's on_attach function
            config.on_attach = function(client)
                -- NOTE: You can remove this on attach function to disable format on save
                if client.resolved_capabilities.document_formatting then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        desc = "Auto format before save",
                        pattern = "<buffer>",
                        callback = vim.lsp.buf.formatting_sync
                    })
                end
            end
            return config -- return final config table
        end,
        treesitter = {
            ensure_installed = {"lua"}
        },
        ["nvim-lsp-installer"] = {
            ensure_installed = {"sumneko_lua"}
        },
        packer = {
            compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua"
        }
    },

    -- LuaSnip Options
    luasnip = {
        -- Add paths for including more VS Code style snippets in luasnip
        vscode_snippet_paths = {},
        -- Extend filetypes
        filetype_extend = {
            javascript = {"javascriptreact"}
        }
    },

    -- Modify which-key registration
    ["which-key"] = {
        -- Add bindings
        register_mappings = {
            -- first key is the mode, n == normal mode
            n = {
                -- second key is the prefix, <leader> prefixes
                ["<leader>"] = {
                    -- which-key registration table for normal mode, leader prefix
                    -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
                }
            }
        }
    },

    -- CMP Source Priorities
    -- modify here the priorities of default cmp sources
    -- higher value == higher priority
    -- The value can also be set to a boolean for disabling default sources:
    -- false == disabled
    -- true == 1000
    cmp = {
        source_priority = {
            nvim_lsp = 1000,
            luasnip = 750,
            buffer = 500,
            path = 250
        }
    },

    -- Extend LSP configuration
    lsp = {
        -- enable servers that you already have installed without lsp-installer
        servers = {
            -- "pyright"
        },
        -- easily add or disable built in mappings added during LSP attaching
        mappings = {
            n = {
                -- ["<leader>lf"] = false -- disable formatting keymap
            }
        },
        -- add to the server on_attach function
        -- on_attach = function(client, bufnr)
        -- end,

        -- override the lsp installer server-registration function
        -- server_registration = function(server, opts)
        --   require("lspconfig")[server].setup(opts)
        -- end,

        -- Add overrides for LSP server settings, the keys are the name of the server
        ["server-settings"] = {
            -- example for addings schemas to yamlls
            -- yamlls = {
            --   settings = {
            --     yaml = {
            --       schemas = {
            --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
            --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
            --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
            --       },
            --     },
            --   },
            -- },
        }
    },

    -- Diagnostics configuration (for vim.diagnostics.config({}))
    diagnostics = {
        virtual_text = true,
        underline = true
    },

    mappings = {
        -- first key is the mode
        n = {
            -- second key is the lefthand side of the map
            ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
            ["<C-q>"] = {":q<CR>", desc = "ctrl-q quit"},
            ["H"] = {"^", desc="jump to line start"},
            ["L"] = {"$", desc="jump to line end"},
            ["<Leader>j"] = {":bn<cr>", desc="next buffer"},
            ["<Leader>k"] = {":bp<cr>", desc="prev buffer"},
            ["<esc>"] = {":noh<CR><esc>", desc="clear highlight with esc"},
            ["<esc>^["] = {"<esc>^[", desc="clear highlight with esc"},
           ["<C-j>"] = {"<C-W><C-J>", desc="jump split"},
           ["<C-k>"] = {"<C-W><C-K>", desc="jump split"},
           ["<C-l>"] = {"<C-W><C-L>", desc="jump split"},
           ["<C-h>"] = {"<C-W><C-H>", desc="jump split"},

        },
        t = {
            -- setting a mapping to false will disable it
            -- ["<esc>"] = false,
        },
        v = {
            ["H"] = {"^", desc="jump to line start"},
            ["L"] = {"$", desc="jump to line end"},

        }


    },

    -- This function is run last
    -- good place to configuring augroups/autocommands and custom filetypes
    polish = function()
        -- Set key binding
        -- Set autocommands
        vim.api.nvim_create_augroup("packer_conf", {
            clear = true
        })
        vim.api.nvim_create_autocmd("BufWritePost", {
            desc = "Sync packer after modifying plugins.lua",
            group = "packer_conf",
            pattern = "plugins.lua",
            command = "source <afile> | PackerSync"
        })

        -- Set up custom filetypes
        -- vim.filetype.add {
        --   extension = {
        --     foo = "fooscript",
        --   },
        --   filename = {
        --     ["Foofile"] = "fooscript",
        --   },
        --   pattern = {
        --     ["~/%.config/foo/.*"] = "fooscript",
        --   },
        -- }
    end
}

return config
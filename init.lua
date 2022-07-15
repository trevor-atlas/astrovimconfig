function themeTelescope()
  local colors = {
    white = "#bbc2cf",
    darker_black = "#22262e",
    black = "#282c34",
    black2 = "#2e323a",
    one_bg = "#32363e",
    one_bg2 = "#3c4048",
    one_bg3 = "#41454d",
    grey = "#494d55",
    grey_fg = "#53575f",
    grey_fg2 = "#5d6169",
    light_grey = "#676b73",
    red = "#ff6b5a",
    baby_pink = "#ff7665",
    pink = "#ff75a0",
    line = "#3b3f47", -- for lines like vertsplit
    green = "#98be65",
    vibrant_green = "#a9cf76",
    nord_blue = "#47a5e5",
    blue = "#61afef",
    yellow = "#ECBE7B",
    sun = "#f2c481",
    purple = "#dc8ef3",
    dark_purple = "#c678dd",
    teal = "#4db5bd",
    orange = "#ea9558",
    cyan = "#46D9FF",
    statusline_bg = "#2d3139",
    lightbg = "#3a3e46",
    pmenu_bg = "#98be65",
    folder_bg = "#51afef"
  }

  local teletheme = {
    TelescopeBorder = {fg = colors.darker_black, bg = colors.darker_black},
    FloatBorder = {fg = colors.darker_black, bg = colors.darker_black},
    NormalFloat = {fg = colors.darker_black, bg = colors.darker_black},
    -- search input border
    TelescopePromptBorder = {fg = colors.one_bg, bg = colors.one_bg},
    -- search input
    TelescopePromptNormal = {fg = colors.white, bg = colors.one_bg},
    -- search input prefix (icon)
    TelescopePromptPrefix = {fg = colors.red, bg = colors.one_bg},
    TelescopeNormal = {bg = colors.darker_black},
    TelescopePreviewTitle = {fg = colors.black, bg = colors.green},
    TelescopePromptTitle = {fg = colors.black, bg = colors.red},
    TelescopeResultsTitle = {fg = colors.darker_black, bg = colors.darker_black},
    TelescopeSelection = {fg = colors.white, bg = colors.black2}
  }
  for hl, col in pairs(teletheme) do vim.api.nvim_set_hl(0, hl, col) end
end

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
  colorscheme = "doom-one", -- "default_theme",

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = true, -- sets vim.opt.relativenumber
      scrolloff = 999,
      clipboard = "unnamedplus", -- copy/paste to system clipboard
      swapfile = false
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      neovide_refresh_rate = 120,
      neovide_cursor_vfx_mode = "sonicboom",
      doom_one_terminal_colors = true
    },
    o = {guifont = "JetBrainsMono Nerd Font:h18"}
  },
  header = {
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣉⡥⠶⢶⣿⣿⣿⣿⣷⣆⠉⠛⠿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⡿⢡⡞⠁⠀⠀⠤⠈⠿⠿⠿⠿⣿⠀⢻⣦⡈⠻⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⡇⠘⡁⠀⢀⣀⣀⣀⣈⣁⣐⡒⠢⢤⡈⠛⢿⡄⠻⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⡇⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠉⠐⠄⡈⢀⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⠇⢠⣿⣿⣿⣿⡿⢿⣿⣿⣿⠁⢈⣿⡄⠀⢀⣀⠸⣿⣿⣿⣿",
    "⣿⣿⣿⣿⡿⠟⣡⣶⣶⣬⣭⣥⣴⠀⣾⣿⣿⣿⣶⣾⣿⣧⠀⣼⣿⣷⣌⡻⢿⣿",
    "⣿⣿⠟⣋⣴⣾⣿⣿⣿⣿⣿⣿⣿⡇⢿⣿⣿⣿⣿⣿⣿⡿⢸⣿⣿⣿⣿⣷⠄⢻",
    "⡏⠰⢾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⢂⣭⣿⣿⣿⣿⣿⠇⠘⠛⠛⢉⣉⣠⣴⣾",
    "⣿⣷⣦⣬⣍⣉⣉⣛⣛⣉⠉⣤⣶⣾⣿⣿⣿⣿⣿⣿⡿⢰⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡘⣿⣿⣿⣿⣿⣿⣿⣿⡇⣼⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢸⣿⣿⣿⣿⣿⣿⣿⠁⣿⣿⣿⣿⣿⣿⣿⣿⣿"
  },

  -- Default theme configuration
  default_theme = {
    diagnostics_style = {italic = true},
    -- Modify the color table
    colors = {fg = "#abb2bf"},
    -- Modify the highlight groups
    highlights = function(highlights)
      local C = require "default_theme.colors"

      highlights.Normal = {fg = C.fg, bg = C.bg}
      return highlights
    end,
    plugins = { -- enable or disable extra plugin highlighting
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = true,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = true,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true
    }
  },

  -- Disable AstroNvim ui features
  ui = {nui_input = true, telescope_select = true},

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

      {
        'kyazdani42/nvim-tree.lua',
        config = function()
          require("nvim-tree").setup({
            sort_by = "case_sensitive",
            view = {side = "right", adaptive_size = true, mappings = {list = {{key = "u", action = "dir_up"}}}},
            renderer = {group_empty = true},
            filters = {dotfiles = true}
          })
        end
      },
      {"mhartington/formatter.nvim", config = function() require("user.formatter-config") end},
      {
        "rmagatti/auto-session",
        config = function()
          require('auto-session').setup {log_level = 'info', auto_session_suppress_dirs = {'~/', '~/projects'}}
        end
      }, -- { "christoomey/vim-tmux-navigator" },
      {"romgrk/doom-one.vim"}, -- colorscheme
      {
        "phaazon/hop.nvim", -- autojump
        branch = "v2", -- optional but strongly recommended
        config = function()
          -- you can configure Hop the way you like here; see :h hop-config
          require("hop").setup({keys = "etovxqpdygfblzhckisuran"})
        end
      },
      {
        "kylechui/nvim-surround",
        config = function()
          require("nvim-surround").setup({}) -- Configuration here, or leave empty to use defaults
        end
      },
      {"bobrown101/plugin-utils.nvim"},
      {"numToStr/Navigator.nvim", config = function() require('Navigator').setup() end},
      {
        "bobrown101/asset-bender.nvim",
        requires = {"bobrown101/plugin-utils.nvim"},
        config = function() require("asset-bender").setup({}) end
      },
      {
        'bobrown101/nvim_cmp_hs_translation_source',
        config = function() require('nvim_cmp_hs_translation_source').setup() end
      },
      {
        "bobrown101/hubspot-js-utils.nvim",
        requires = {"bobrown101/plugin-utils.nvim"},
        config = function() require("hubspot-js-utils").setup({}) end
      },
      {
        "akinsho/git-conflict.nvim",
        config = function()
          require("git-conflict").setup({
            default_mappings = true, -- disable buffer local mapping created by this plugin
            disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
            highlights = { -- They must have background color, otherwise the default color will be used
              incoming = 'DiffText',
              current = 'DiffAdd'
            }
          })
        end
      },
      ["nvim-neo-tree/neo-tree.nvim"] = {disable = true} -- function(configuration)
    }, -- end plugin install, begin config
    ["nvim-neo-tree/neo-tree.nvim"] = {disable = true}, -- function(configuration)
    -- configuration.close_if_last_window = false
    --   configuration.window.position = "right"
    --   configuration.filesystem.filtered_items.hide_dotfiles = false
    --   configuration.window.width = 60;
    --
    --   return configuration
    -- end,
    bufferline = function(configuration)
      configuration.options.separator_style = "slant"
      configuration.options.tab_size = 30
      configuration.options.max_name_length = 24
      return configuration
    end,
    lspconfig = function()
      local util = require("lspconfig/util")
      local Job = require("plenary.job")

      local function getLogPath() return vim.lsp.get_log_path() end

      local function getTsserverPath()
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

      local function getIsHubspotMachine()
        local result = ""
        Job:new({
          command = "ls",
          args = {vim.env.HOME .. "/.isHubspotMachine"},
          on_exit = function(_, return_val) result = return_val end
        }):sync()

        return result == 0
      end

      local function customPublishDiagnosticFunction(_, result, ctx, conf)
        local filter = function(fun, t)
          local res = {}
          for _, item in ipairs(t) do if fun(item) then res[#res + 1] = item end end

          return res
        end
        local raw_diagnostics = result.diagnostics

        local filtered_diagnostics = filter(function(diagnostic)
          local diagnostic_code = diagnostic.code
          local diagnostic_source = diagnostic.source
          return not (diagnostic_code == 7016 and diagnostic_source == "typescript")
        end, raw_diagnostics)

        result.diagnostics = filtered_diagnostics

        return vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, conf)
      end

      -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
      local on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = bufnr,
          callback = function()
            local opts = {
              focusable = false,
              close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
              border = 'rounded',
              source = 'always',
              prefix = ' ',
              scope = 'cursor'
            }
            vim.diagnostic.open_float(nil, opts)
          end
        })
      end
      local lsp_flags = {debounce_text_changes = 500}

      if getIsHubspotMachine() then
        require("lspconfig").tsserver.setup({
          flags = lsp_flags,
          cmd = {
            "typescript-language-server", "--log-level", -- A number indicating the log level (4 = log, 3 = info, 2 = warn, 1 = error). Defaults to `2`.
            "2", "--tsserver-log-verbosity", "terse", -- Specify tsserver log verbosity (off, terse, normal, verbose). Defaults to `normal`. example: --tsserver-log-verbosity=verbose
            "--tsserver-log-file", getLogPath(), "--tsserver-path", getTsserverPath(), "--stdio"
          },
          init_options = {hostInfo = "neovim"},
          on_attach = on_attach,
          root_dir = util.root_pattern(".git"),
          filetypes = {
            "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"
          },
          handlers = {
            ["textDocument/publishDiagnostics"] = vim.lsp.with(customPublishDiagnosticFunction, {
              -- Disable virtual_text
              -- virtual_text = false
            })
          },
          capabilities = capabilities
        })
      else
        require("lspconfig").tsserver.setup({
          root_dir = util.root_pattern(".git"),
          init_options = {hostInfo = "neovim"},
          flags = lsp_flags,
          on_attach = on_attach,
          capabilities = capabilities,
          filetypes = {
            "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"
          }
        })
      end

      -- npm install -g graphql-language-service-cli
      require("lspconfig").graphql.setup({flags = lsp_flags, on_attach = on_attach, capabilities = capabilities})

      -- yarn global add yaml-language-server
      require("lspconfig").yamlls.setup({flags = lsp_flags, on_attach = on_attach, capabilities = capabilities})
      require("lspkind").init({flags = lsp_flags, on_attach = on_attach, capabilities = capabilities})

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp
                                                           .with(vim.lsp.handlers.signature_help, {border = "single"})

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"})
    end,
    telescope = function(config)
      config.defaults.file_ignore_patterns = {"node%_modules/.*"}
      -- config.defaults.border = false
      config.defaults.winblend = 0
      config.defaults.color_devicons = true
      -- config.defaults.border="rounded"
      return config

    end,
    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = { -- Set a formatter
        null_ls.builtins.formatting.rufo, -- Set a linter
        null_ls.builtins.diagnostics.rubocop
      }
      -- set up null-ls's on_attach function
      local old_on_attach = config.on_attach;
      config.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync
          })
        end
        old_on_attach(client)
      end
      return config -- return final config table
    end,
    ["nvim-cmp"] = function(configuration)
      configuration.sources = {
        {name = "nvim_cmp_hs_translation_source"}
        ---...other sources
      }
      -- formatting is totally optional, but setting this up will explicitly let you know a completion is a translation key as opposed to just a word found in your buffer
      configuration.formatting = {
        format = function(entry, vim_item)
          vim_item.menu = ({
            nvim_cmp_hs_translation_source = "[Translation]"
            -- other examples may look like
            -- buffer = "[Buffer]",
            -- nvim_lsp = "[LSP]",
            -- luasnip = "[LuaSnip]",
            -- nvim_lua = "[Lua]",
            -- latex_symbols = "[Latex]",
          })[entry.source.name]
          return vim_item
        end
      }
    end,
    treesitter = {ensure_installed = "all", ignore_install = {"phpdoc"}},
    ["nvim-lsp-installer"] = {
      ensure_installed = "all", -- {"sumneko_lua"}
      ignore_install = {"phpdoc"}
    },
    packer = {compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua"}
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {javascript = {"javascriptreact"}}
  },

  -- Modify which-key registration
  ["which-key"] = {
    -- Add bindings
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        -- which-key registration table for normal mode, leader prefix
        -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
        -- ["<H>"] = {
        --     name = "HubSpot",
        --     ["t"] = { ":lua require('hubspot-js-utils').test_file()<cr>", "open current file's test if it exists" }
        -- },
        ["<leader>"] = {
          ["H"] = {
            name = "HubSpot",
            ["t"] = {function() require('hubspot-js-utils').test_file() end, "open current file's test if it exists"}
          },

          ["-"] = {function() vim.cmd("split") end, "Split Horizontal"},
          ["|"] = {function() vim.cmd("vsplit") end, "Split Vertical"}
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
  cmp = {source_priority = {nvim_lsp = 1000, luasnip = 750, buffer = 500, path = 250}},

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
  diagnostics = {virtual_text = true, underline = true},

  mappings = {

    -- first key is the mode
    --
    i = {

      ["<C-t>"] = {"<cmd>tabnew<cr>", desc = "create buffer"},
      -- relies on "bufdelete.nvim" 
      ["<C-w>"] = {"<cmd>Bdelete<cr>", desc = "close buffer"},
      ["<C-s>"] = {"<cmd>w!<cr>", desc = "Save File"},
      ["<C-q>"] = {"<cmd>q<cr>", desc = "ctrl-q quit"}
    },
    n = {
      -- second key is the lefthand side of the map
      ["<C-s>"] = {"<cmd>w!<cr>", desc = "Save File"},
      ["<C-q>"] = {"<cmd>qa<cr>", desc = "ctrl-q quit"},
      ["<S-h>"] = {"^", desc = "jump to line start"},
      ["<S-l>"] = {"$", desc = "jump to line end"},
      ["<Leader>k"] = {":bn<cr>", desc = "next buffer"},
      ["<Leader>j"] = {":bp<cr>", desc = "prev buffer"},
      ["<esc>"] = {":noh<cr><esc>", desc = "clear highlight with esc"},
      ["<esc>^["] = {"<esc>^[", desc = "clear highlight with esc"},
      ["<C-h>"] = {"<CMD>NavigatorLeft<CR>"},
      ["<C-l>"] = {"<CMD>NavigatorRight<CR>"},
      ["<C-k>"] = {"<CMD>NavigatorUp<CR>"},
      ["<C-j>"] = {"<CMD>NavigatorDown<CR>"},
      ["<C-p>"] = {"<CMD>NavigatorPrevious<CR>"},
      ["<C-a>"] = {"ggVG", desc = "highlight everything"},

      ["<C-t>"] = {"<cmd>tabnew<cr>", desc = "create buffer"},
      ["<C-w>"] = {"<cmd>bdelete<cr>", desc = "close buffer"},
      ["n"] = {"nzzzv", desc = "centered 'next' when searching"},
      ["N"] = {"Nzzzv", desc = "centered 'next' when searching"},
      ["<Leader>bb"] = {"<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "search buffers"},
      -- place this in one of your configuration file(s)
      ["t"] = {":HopWord<cr>", desc = "jump to a character"},
      ["T"] = {":HopLine<cr>", desc = "jump to a character"},
      ["<leader>e"] = {"<cmd>NvimTreeToggle<cr>", desc = "toggle sidenav"},
      ["<leader>o"] = {"<cmd>NvimTreeFocus<cr>", desc = "toggle sidenav"}
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
    v = {
      ["<S-h>"] = {"^", desc = "jump to line start"},
      ["<S-l>"] = {"$", desc = "jump to line end"},
      ["<S-j>"] = {":m '>+1<CR>gv=gv", desc = "Move lines around"},
      ["<S-k>"] = {":m '<-2<CR>gv=gv", desc = "Move lines around"}
    }
  },

  -- This function is run last
  -- good place to configuring augroups/autocommands and custom filetypes
  polish = function()
    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", {clear = true})
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync"
    })

    local api = vim.api

    -- Highlight on yank
    local yankGrp = api.nvim_create_augroup("YankHighlight", {clear = true})
    api.nvim_create_autocmd("TextYankPost", {command = "silent! lua vim.highlight.on_yank()", group = yankGrp})
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
    themeTelescope()
    -- vim.o.updatetime = 250
    -- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
  end
}

return config

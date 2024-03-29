require("user.globals")

local config = {
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
  colorscheme = "github_dark",
  --colorscheme = "tokyonight", -- "default_theme",

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = true, -- sets vim.opt.relativenumber
      scrolloff = 999,
      clipboard = "unnamedplus", -- copy/paste to system clipboard
      swapfile = false,
      -- I prefer '>' and '<' to move text the same distance as the tab-key.
      -- by settin shiftwidth=0 you tell vim that you always want it to match tabstop
      shiftwidth = 0,
      tabstop = 2,
      softtabstop = 2
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      neovide_transparency = 0.9,
      neovide_refresh_rate_idle = 5,
      neovide_refresh_rate = 60,
      neovide_floating_blur_amount_x = 2.0,
      neovide_floating_blur_amount_y = 2.0,
      neovide_cursor_vfx_mode = "sonicboom"
      -- doom_one_terminal_colors = true
    },
    o = {guifont = "JetBrainsMono Nerd Font:h18", updatetime = 250}
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
    plugins = {
      -- enable or disable extra plugin highlighting
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
    init = {
      -- You can disable default plugins as follows:
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
      -- ##

      { "f-person/git-blame.nvim"},
      { "simrat39/inlay-hints.nvim", setup = function()
          require("inlay-hints").setup()
        end
      },
      {
        "simrat39/rust-tools.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()

          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

          local rt = require("rust-tools")

          local rt_config = {
              server = {
                on_attach = function(client, bufnr)
                  vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, {buffer = bufnr})
                  vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, {buffer = bufnr})
                end
              },
              dap = {
                adapter = require("rust-tools.dap").get_codelldb_adapter(
                  os.getenv("HOME") .. "/repos/codelldb/extension/adapter/codelldb",
                  os.getenv("HOME") .. "/repos/codelldb/extension/lldb/lib/liblldb.dylib"
                )
              }
            }

          if require('user.utils').is_available('inlay-hints.nvim') then
            local ih = require("inlay-hints")
            local prev_on_attach = rt_config.server.on_attach
              rt_config.server.on_attach = function(client, bufnr)
              ih.on_attach(client, bufnr)
              prev_on_attach(client, bufnr)
            end
              rt_config.tools = {
                inlay_hints = {
                  auto = true,
                  only_current_line = true,
                  -- whether to show parameter hints with the inlay hints or not
                  -- default: true
                  show_parameter_hints = false
                },
                on_initialized = function()
                  ih.set_all()
                end
              }
          end

          rt.setup(rt_config)
        end
      },
      {
        "mfussenegger/nvim-dap",
        config = function()
          local dap = require("dap")
          dap.adapters.chrome = {
            type = "executable",
            command = "node",
            args = {os.getenv("HOME") .. "/repos/vscode-chrome-debug/out/src/chromeDebug.js"}
          }
          dap.configurations.javascriptreact = {
            -- change this to javascript if needed
            {
              type = "chrome",
              request = "attach",
              program = "${file}",
              cwd = vim.fn.getcwd(),
              sourceMaps = true,
              protocol = "inspector",
              port = 9222,
              webRoot = "${workspaceFolder}"
            }
          }
          dap.configurations.javascript = dap.configurations.javascriptreact

          dap.configurations.typescriptreact = {
            -- change to typescript if needed
            {
              type = "chrome",
              request = "attach",
              program = "${file}",
              cwd = vim.fn.getcwd(),
              sourceMaps = true,
              protocol = "inspector",
              port = 9222,
              webRoot = "${workspaceFolder}"
            }
          }
          dap.configurations.typescript = dap.configurations.typescriptreact
        end
      },
      {
        "rcarriga/nvim-dap-ui",
        requires = {"mfussenegger/nvim-dap"},
        config = function()
          local dapui = require("dapui")
          dapui.setup(
            {
              icons = {expanded = "▾", collapsed = "▸"},
              mappings = {
                -- Use a table to apply multiple mappings
                expand = {"<CR>", "<2-LeftMouse>"},
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t"
              },
              -- Expand lines larger than the window
              -- Requires >= 0.7
              expand_lines = vim.fn.has("nvim-0.7"),
              -- Layouts define sections of the screen to place windows.
              -- The position can be "left", "right", "top" or "bottom".
              -- The size specifies the height/width depending on position. It can be an Int
              -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
              -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
              -- Elements are the elements shown in the layout (in order).
              -- Layouts are opened in order so that earlier layouts take priority in window sizing.
              layouts = {
                {
                  elements = {
                    -- Elements can be strings or table with id and size keys.
                    {id = "scopes", size = 0.25},
                    "breakpoints",
                    "stacks",
                    "watches"
                  },
                  size = 40, -- 40 columns
                  position = "left"
                },
                {
                  elements = {"repl", "console"},
                  size = 0.25, -- 25% of total lines
                  position = "bottom"
                }
              },
              floating = {
                max_height = nil, -- These can be integers or a float between 0 and 1.
                max_width = nil, -- Floats will be treated as percentage of your screen.
                border = "single", -- Border style. Can be "single", "double" or "rounded"
                mappings = {close = {"q", "<Esc>"}}
              },
              windows = {indent = 1},
              render = {
                max_type_length = nil -- Can be integer or nil.
              }
            }
          )

          local dap = require("dap")
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end
      },
      {"folke/tokyonight.nvim"},
      {
        "projekt0n/github-nvim-theme",
        config = function()
          require("github-theme").setup(
            {
              theme_style = "dark",
              function_style = "italic"
            }
          )
        end
      },
      {
        "yamatsum/nvim-cursorline",
        config = function()
          require("nvim-cursorline").setup(
            {
              cursorline = {enable = false, timeout = 1000, number = false},
              cursorword = {enable = true, min_length = 1, timeout = 100, hl = {underline = true}}
            }
          )
        end
      },
      { "mhartington/formatter.nvim", config = function()
          require("user.formatter-config")
        end
      },
      {"nvim-treesitter/playground"},
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
      {"numToStr/Navigator.nvim", config = function()
          require("Navigator").setup()
        end},
      {
        "bobrown101/nvim_cmp_hs_translation_source",
        config = function()
          require("nvim_cmp_hs_translation_source").setup()
        end
      },
      {
        "bobrown101/hubspot-js-utils.nvim",
        requires = {"bobrown101/plugin-utils.nvim"},
        config = function()
          require("hubspot-js-utils").setup({})
        end
      },
      {
        "akinsho/git-conflict.nvim",
        config = function()
          require("git-conflict").setup(
            {
              default_mappings = true, -- disable buffer local mapping created by this plugin
              disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
              highlights = {
                -- They must have background color, otherwise the default color will be used
                incoming = "DiffText",
                current = "DiffAdd"
              }
            }
          )
        end
      },
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          require "treesitter-context".setup {
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
            trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            patterns = {
              -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
              -- For all filetypes
              -- Note that setting an entry here replaces all other patterns for this entry.
              -- By setting the 'default' entry below, you can control which nodes you want to
              -- appear in the context window.
              default = {
                "class",
                "function",
                "method"
                -- 'for', -- These won't appear in the context
                -- 'while',
                -- 'if',
                -- 'switch',
                -- 'case',
              }
              -- Example for a specific filetype.
              -- If a pattern is missing, *open a PR* so everyone can benefit.
              --   rust = {
              --       'impl_item',
              --   },
            },
            exact_patterns = {},
            -- [!] The options below are exposed but shouldn't require your attention,
            --     you can safely ignore them.

            zindex = 20, -- The Z-index of the context window
            mode = "cursor" -- Line used to calculate context. Choices: 'cursor', 'topline'
          }
        end
      },
      {
        --[[
        Open agenda prompt: <leader>oa
        Open capture prompt: <leader>oc
        In any orgmode buffer press g? for help
        ]] --
        "nvim-orgmode/orgmode",
        config = function()
          local orgmode = require("orgmode")
          orgmode.setup({org_agenda_files = {"~/Desktop/org/*"}, org_default_notes_file = "~/Desktop/org/notes.org"})
          orgmode.setup_ts_grammar()
        end
      }
    }, -- end plugin install, begin config
    ["neo-tree"] = function(c)
      c.window.position = "right"
      c.window.width = 40
      c.filesystem.filtered_items.hide_dotfiles = false
      c.filesystem.filtered_items.hide_by_name = {"node_modules", ".DS_Store"}
      c.filesystem.filtered_items.never_show = {".DS_Store", "thumbs.db"}
      c.close_if_last_window = false
      c.window.mappings = {["<space>"] = false}
      return c
    end,
    bufferline = function(c)
      c.options.show_buffer_close_icons = false
      c.options.show_close_icon = false
      c.options.separator_style = "slant"
      c.options.tab_size = 30
      c.options.diagnostics = "nvim_lsp"
      c.options.diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end
      c.options.name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
        return vim.fn.fnamemodify(buf.name, ":p:.")
      end
      c.options.max_name_length = 30

      return P(c)
    end,
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = {
      -- overrides `require("mason-lspconfig").setup(...)`
      ensure_installed = {"sumneko_lua"}
    },
    -- use mason-tool-installer to configure DAP/Formatters/Linter installation
    ["mason-tool-installer"] = {
      -- overrides `require("mason-tool-installer").setup(...)`
      ensure_installed = {"prettier", "stylua"}
    },
    telescope = function(c)
      local actions = require "telescope.actions"
      c.defaults.vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case"
      }
      c.defaults.file_sorter = require("telescope.sorters").get_fuzzy_file
      c.defaults.file_ignore_patterns = {"node%_modules/.*"}
      c.defaults.generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter
      c.defaults.path_display = {"truncate"}
      c.defaults.mappings.i["<esc>"] = actions.close
      c.defaults.mappings.i["<C-k>"] = actions.preview_scrolling_up
      c.defaults.mappings.i["<C-j>"] = actions.preview_scrolling_down

      -- config.defaults.border = false
      c.defaults.winblend = 0
      c.defaults.color_devicons = true
      -- config.defaults.border="rounded"
      return c
    end,
    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(c)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      c.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.rufo, -- Set a linter
        null_ls.builtins.diagnostics.rubocop
      }
      -- set up null-ls's on_attach function
      local old_on_attach = c.on_attach
      c.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd(
            "BufWritePre",
            {
              desc = "Auto format before save",
              pattern = "<buffer>",
              callback = vim.lsp.buf.formatting_sync
            }
          )
        end
        old_on_attach(client)
      end
      return c -- return final config table
    end,
    ["nvim-cmp"] = function(c)
      c.sources = {{name = "nvim_cmp_hs_translation_source"}}
      -- formatting is totally optional, but setting this up will explicitly let you know a completion is a translation key as opposed to just a word found in your buffer
      c.formatting = {
        format = function(entry, vim_item)
          vim_item.menu =
            ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[Latex]",
            nvim_cmp_hs_translation_source = "[Translation]"
          })[entry.source.name]
          return vim_item
        end
      }
      return c
    end,
    treesitter = {ensure_installed = "all", ignore_install = {"phpdoc"}},
    packer = {compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua"}
    --[[ feline = function(c) ]]
    --[[   table.insert(c.components.active[1], {short_provider = {name = 'file_info', opts = {type = 'short-path'}}}) ]]
    --[[ end ]]
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
          ["l"] = {["x"] = {"<cmd>TSHighlightCapturesUnderCursor<cr>", "describe token under cursor"}},
          ["-"] = {function()
              vim.cmd("split")
            end, "Split Horizontal"},
          ["|"] = {function()
              vim.cmd("vsplit")
            end, "Split Vertical"}
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
    servers = {},
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
        ["<leader>D"] = "<cmd>lua require('telescope.builtin').lsp_definitions({ jump_type = 'never', fname_width = 0 })<cr>"
      }
    },
    -- add to the server on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the lsp installer server-registration function
    --[[ server_registration = function(server, opts) ]]
    -- require("lspconfig")[server].setup(opts)
    --[[ end, ]]
    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      tsserver = require("user.lsp-config").tsserver()
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
  diagnostics = {virtual_text = false, underline = true},
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
      ["<C-s>"] = {"<cmd>w!<cr>", desc = "Save File"},
      ["<C-q>"] = {"<cmd>qa<cr>", desc = "ctrl-q quit"},
      ["<esc>"] = {":noh<cr><esc>", desc = "clear highlight with esc"},
      ["<esc>^["] = {"<esc>^[", desc = "clear highlight with esc"},
      ["<C-h>"] = {"<cmd>NavigatorLeft<cr>"},
      ["<C-l>"] = {"<cmd>NavigatorRight<cr>"},
      ["<C-k>"] = {"<cmd>NavigatorUp<cr>"},
      ["<C-j>"] = {"<cmd>NavigatorDown<cr>"},
      ["<C-p>"] = {"<cmd>NavigatorPrevious<cr>"},
      ["<C-a>"] = {"ggVG", desc = "highlight everything"},
      ["<C-t>"] = {"<cmd>tabnew<cr>", desc = "create buffer"},
      ["<C-w>"] = {"<cmd>bdelete<cr>", desc = "close buffer"},
      ["<leader>k"] = {":bn<cr>", desc = "next buffer"},
      ["<leader>j"] = {":bp<cr>", desc = "prev buffer"},
      ["<leader>rn"] = {"<cmd>lua vim.lsp.buf.rename()<cr>", desc = "rename symbol"},
      ["<leader>E"] = {"<cmd>lua vim.diagnostic.open_float()<cr>", desc = "show diagnostics for this line"},
      ["<leader>bb"] = {"<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "search buffers"},
      ["<leader>G"] = {"<cmd>lua require('neogit').open()<cr>", desc = "open neogit"},
      -- DAP
      ["<leader>B"] = {"<cmd>lua require('dap').toggle_breakpoint()<cr>"},
      ["<leader>dr"] = {"<cmd>lua require('dap').step_out()<cr>"},
      ["<F1>"] = {"<cmd>lua require('dap').continue()<cr>"},
      ["<F2>"] = {"<cmd>lua require('dap').step_into()<cr>"},
      ["<F3>"] = {"<cmd>lua require('dap').step_over()<cr>"},
      ["<F4>"] = {"<cmd>lua require('dap').step_out()<cr>"},
      ["n"] = {"nzzzv", desc = "centered 'next' when searching"},
      ["N"] = {"Nzzzv", desc = "centered 'prev' when searching"},
      ["t"] = {":HopWord<cr>", desc = "jump to a character"},
      ["T"] = {":HopLine<cr>", desc = "jump to a character"},
      ["<S-h>"] = {"^", desc = "jump to line start"},
      ["<S-l>"] = {"$", desc = "jump to line end"},
      ["<S-Up>"] = {"<cmd>resize -2<cr>", desc = "Resize split up"},
      ["<S-Down>"] = {"<cmd>resize +2<cr>", desc = "Resize split down"},
      ["<S-Left>"] = {"<cmd>vertical resize -2<cr>", desc = "Resize split left"},
      ["<S-Right>"] = {"<cmd>vertical resize +2<cr>", desc = "Resize split right"}
    },
    t = {},
    v = {
      ["<S-h>"] = {"^", desc = "jump to line start"},
      ["<S-l>"] = {"$", desc = "jump to line end"},
      ["<S-j>"] = {":m '>+1<cr>gv=gv", desc = "Move lines around"},
      ["<S-k>"] = {":m '<-2<cr>gv=gv", desc = "Move lines around"}
    }
  },
  -- This function is run last
  -- good place to configuring augroups/autocommands and custom filetypes
  polish = function()
    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", {clear = true})
    vim.api.nvim_create_autocmd(
      "BufWritePost",
      {
        desc = "Sync packer after modifying plugins.lua",
        group = "packer_conf",
        pattern = "plugins.lua",
        command = "source <afile> | PackerSync"
      }
    )

    local api = vim.api

    -- Highlight on yank
    local yankGrp = api.nvim_create_augroup("YankHighlight", {clear = true})
    api.nvim_create_autocmd("TextYankPost", {command = "silent! lua vim.highlight.on_yank()", group = yankGrp})
    vim.api.nvim_create_autocmd(
      "CursorHold",
      {
        buffer = bufnr,
        callback = function()
          local opts = {
            focusable = false,
            close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor"
          }
          vim.diagnostic.open_float(nil, opts)
        end
      }
    )

    local fmt_on_save_group = vim.api.nvim_create_augroup("MyFormatOnSave", {clear = true})
    vim.api.nvim_create_autocmd(
      "BufWritePre",
      {group = fmt_on_save_group, pattern = {"*.rs"}, callback = vim.lsp.buf.formatting_sync}
    )

    require("user.nvim-dev")
    require("user.ts-config")
    require("user.asset-bender").setup()
    local theme = require("user.theme")
    theme.theme_telescope()
    theme.theme_syntax()

    vim.g.neovide_input_use_logo = 1
    vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", {noremap = true, silent = true})
    vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", {noremap = true, silent = true})
    vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", {noremap = true, silent = true})
    vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", {noremap = true, silent = true})
    -- Set up custom filetypes
    vim.filetype.add(
      {
        extension = {lyaml = "yaml"}
        -- filename = {
        --   [""] = "fooscript",
        -- },
        -- pattern = {
        --   ["~/%.config/foo/.*"] = "fooscript",
        -- },
      }
    )

    vim.filetype.add({extension = {scpt = "javascript"}})
  end
}

local utils = require("user.utils")
if utils.is_hubspot_machine then
  config["which-key"].register_mappings.n["<leader>"].H = {
    name = "HubSpot",
    ["t"] = {function()
        require("hubspot-js-utils").test_file()
      end, "open current file's test if it exists"}
  }
end

return config

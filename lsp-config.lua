local Job = require("plenary.job")
local myutils = require("user.utils")
local ih = require("inlay-hints")
local util = require 'lspconfig/util'

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

--[[ local capabilities = vim.lsp.protocol.make_client_capabilities() ]]
--[[ capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities) ]]

local on_attach = function(client, bufnr)
  ih.on_attach(client, bufnr)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float(nil, {
        focusable = false,
        close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor'
      })
    end
  })
end

local lsp_flags = {debounce_text_changes = 500}

return {
  ["tsserver"] = function()
    local root_dir = function(pattern)
      local cwd = vim.loop.cwd();
      local root = util.root_pattern("package.json", "tsconfig.json", ".git")(pattern);
      return root or cwd;
    end;
    local default_config = {
      root_dir = root_dir,
      init_options = {hostInfo = "neovim"},
      on_attach = on_attach,
      --[[ handlers = { ]]
      --[[   ["textDocument/publishDiagnostics"] = vim.lsp.with(customPublishDiagnosticFunction, { ]]
      --[[     -- Disable virtual_text ]]
      --[[     -- virtual_text = false ]]
      --[[   }) ]]
      --[[ }, ]]
      filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"},
      settings = {
        javascript = {
          inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true
          }
        },
        typescript = {
          inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true
          }
        }
      }
    }
    if myutils.is_hubspot_machine then
      default_config.cmd = {
        "typescript-language-server", "--log-level", -- A number indicating the log level (4 = log, 3 = info, 2 = warn, 1 = error). Defaults to `2`.
        "2", "--tsserver-log-verbosity", "terse", -- Specify tsserver log verbosity (off, terse, normal, verbose). Defaults to `normal`. example: --tsserver-log-verbosity=verbose
        "--tsserver-log-file", getLogPath(), "--tsserver-path", getTsserverPath(), "--stdio"
      }
    end
    return default_config
  end
}

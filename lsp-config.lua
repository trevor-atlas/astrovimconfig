local util = require("lspconfig/util")
local Job = require("plenary.job")
local myutils = require("user.utils")

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local function create_on_attach(server_name)
  local server = require("lspconfig")[server_name]
  local old_on_attach = server.on_attach
  local custom_on_attach = function(client, bufnr)
    myutils.conditional_func(old_on_attach, true, client, bufnr)
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
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
end
local lsp_flags = {debounce_text_changes = 500}

local servers = {
  ["tsserver"] = function(custom_on_attach)
    if myutils.is_hubspot_machine then
      return {
        flags = lsp_flags,
        cmd = {
          "typescript-language-server", "--log-level", -- A number indicating the log level (4 = log, 3 = info, 2 = warn, 1 = error). Defaults to `2`.
          "2", "--tsserver-log-verbosity", "terse", -- Specify tsserver log verbosity (off, terse, normal, verbose). Defaults to `normal`. example: --tsserver-log-verbosity=verbose
          "--tsserver-log-file", getLogPath(), "--tsserver-path", getTsserverPath(), "--stdio"
        },
        init_options = {hostInfo = "neovim"},
        on_attach = custom_on_attach,
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
      }
    else
      return {
        root_dir = util.root_pattern(".git"),
        init_options = {hostInfo = "neovim"},
        flags = lsp_flags,
        on_attach = custom_on_attach,
        capabilities = capabilities,
        filetypes = {
          "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"
        }
      }
    end
  end,

  -- npm install -g graphql-language-service-cli
  ["graphql"] = function(custom_on_attach)
    return {flags = lsp_flags, on_attach = custom_on_attach, capabilities = capabilities}
  end,

  -- yarn global add yaml-language-server
  ["yamlls"] = function(custom_on_attach)
    return {flags = lsp_flags, on_attach = custom_on_attach, capabilities = capabilities}
  end
}

for server_name, setupFN in pairs(servers) do
  local custom_on_attach = create_on_attach(server_name)
  require("lspconfig")[server_name].setup(setupFN(custom_on_attach))
end


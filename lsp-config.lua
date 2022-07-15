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
    filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"},
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
    filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"}
  })
end

-- npm install -g graphql-language-service-cli
require("lspconfig").graphql.setup({flags = lsp_flags, on_attach = on_attach, capabilities = capabilities})

-- yarn global add yaml-language-server
require("lspconfig").yamlls.setup({flags = lsp_flags, on_attach = on_attach, capabilities = capabilities})
require("lspkind").init({flags = lsp_flags, on_attach = on_attach, capabilities = capabilities})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"})

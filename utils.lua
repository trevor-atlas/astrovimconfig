local Job = require("plenary.job")

local M = {}

M.dir_exists = function(dirpath)
  local result = ""
  Job:new({command = "ls", args = {dirpath}, on_exit = function(_, return_val) result = return_val end}):sync()
  return result == 0
end

M.conditional_func = function(func, condition, ...)
  if (condition == nil and true or condition) and type(func) == "function" then return func(...) end
end

M.path_sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"

function M.path_join(...) return table.concat(vim.tbl_flatten({...}), M.path_sep) end

function M.is_dir(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type == 'directory' or false
end

function M.dirname(filepath)
  local is_changed = false
  local result = filepath:gsub(M.path_sep .. "([^" .. M.path_sep .. "]+)$", function()
    is_changed = true
    return ""
  end)
  return result, is_changed
end

function M.buffer_find_root_dir(bufnr, is_root_path)
  -- change to use git instead of this 
  -- git rev-parse --show-toplevel | tr -d '\\n'
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if vim.fn.filereadable(bufname) == 0 then return nil end
  local dir = bufname
  -- Just in case our algo is buggy, don't infinite loop.
  for _ = 1, 100 do
    local did_change
    dir, did_change = M.dirname(dir)
    if is_root_path(dir, bufname) then return dir, bufname end
    -- If we can't ascend further, then stop looking.
    if not did_change then return nil end
  end
end

function M.file_exists(fname)
  local stat = vim.loop.fs_stat(fname)
  return (stat and stat.type) or false
end

function M.open_file(file) vim.cmd("e " .. file) end

function M.get_uname()
  local result = ""
  Job:new({command = "uname", args = {"-a"}, on_exit = function(res, return_val) result = res._stdout_results[1] end})
      :sync()
  return result
end

function M.determine_os()
  local uname = M.get_uname()
  P(uname)
  local osnames = {"WSL", "Darwin"}
  for _, name in ipairs(osnames) do if not not string.find(uname or "", name) then return name end end
  return "Unknown"
end

M.is_hubspot_machine = M.dir_exists(vim.env.HOME .. "/.hubspot")
M.os = M.determine_os()
M.is_wsl = M.os == "WSL"
M.is_macos = M.os == "Darwin"

return M

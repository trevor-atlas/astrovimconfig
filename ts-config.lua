local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.pug = {
  install_info = {
    url = "https://github.com/zealot128/tree-sitter-pug", -- local path or git repo
    files = {"src/parser.c", "src/scanner.cc"},
    branch = "master"
  },
  filetype = {"pug", "jade"},
  used_by = {"vue"}
}

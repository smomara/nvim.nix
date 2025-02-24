-- Exit if the Verible LSP isn't available
if vim.fn.executable('verible-verilog-ls') ~= 1 then
  return
end

local root_files = {
  '.git',
  'Makefile',
  'verilog_project.v',
}

vim.lsp.start {
  name = 'verible_ls',
  cmd = { 'verible-verilog-ls' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
}

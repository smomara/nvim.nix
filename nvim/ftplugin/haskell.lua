local hls_cmd = 'haskell-language-server-wrapper'

-- Check if Haskell Language Server is available
if vim.fn.executable(hls_cmd) ~= 1 then
  return
end

local root_files = {
  'stack.yaml',
  'cabal.project',
  'hie.yaml',
  '.git',
}

vim.lsp.start {
  name = 'hls',
  cmd = { hls_cmd, '--lsp' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = {
    haskell = {
      formattingProvider = 'fourmolu',
    }
  }
}

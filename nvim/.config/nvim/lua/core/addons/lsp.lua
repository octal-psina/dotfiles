local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--require("lspconfig").sumneko_lua.setup {}
require("lspconfig").lua_ls.setup {
capabilities = capabilities,
}
require('lspconfig').pyright.setup{
    capabilities = capabilities,
    on_attach = function()
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts,{buffer = 0})
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition,{buffer = 0}) --<C-t> to go back show where return difine
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,{buffer = 0}) --<C-t> 
        vim.keymap.set('n', 'gn', vim.diagnostic.goto_next,{buffer = 0}) --next error 
        vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev,{buffer = 0}) --prev error 
        vim.keymap.set('n', '<space>n', vim.lsp.buf.rename,{buffer = 0}) --<C-t> to go back show where return difine
        --vim.keymap.set('n', '<leader>td','<cmd>Telescope diagnostocs<cr>,'{buffer = 0})--?  

  end,
}
require('lspconfig').html.setup{
capabilities = capabilities,
--root_dir = require("lspconfig").util.root_pattern("html.config.js", ".git"),
cmd = { 'vscode-html-language-server', '--stdio' },
filetypes = { 'html' },
single_file_support = true,
settings = {},
init_options = {
      provideFormatter = true,
      embeddedLanguages = { css = true, javascript = true },
      configurationSection = { 'html', 'css', 'javascript' }
    }
}

require('lspconfig').cssls.setup{
capabilities = capabilities,
}


--[[require('lspconfig').tailwindcss.setup{
capabilities = capabilities,
root_dir = require("lspconfig").util.root_pattern("tailwind.config.js", ".git")
}]]--
--[[require'lspconfig'.pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        flake8 = {enabled = true},
        pycodestyle = {enabled = false},
        pyflakes = {enabled = false},
        pylint = {enabled = false},
        mccabe = {enabled = false},
      },
    },
  },

}]]--

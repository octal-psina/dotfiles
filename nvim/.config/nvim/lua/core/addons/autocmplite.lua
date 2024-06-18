vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-a>'] = cmp.mapping.scroll_docs(-4),
      ['<C-z>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" }, --luasnip
        { name = "buffer", keyword_length = 4 },--nvim_lua
    }, {
        { name = "luasnip" },--path
        { name = "nvim_lua" },--buffer
    }),
  experimental = {
    -- I like the new menu better! Nice work hrsh7th
    native_menu = false,

    -- Let's play with this for a day or two
    ghost_text = false,
  }
})











































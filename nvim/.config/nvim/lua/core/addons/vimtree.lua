require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30, -- Here place for remaping keys
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })

vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]] --transparency

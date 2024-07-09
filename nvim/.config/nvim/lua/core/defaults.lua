--some default settings
vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.autoindent=true
vim.opt.clipboard='unnamed'--this option worck with util 'xclip' on X11
--vim.opt.hlsearch
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.scrolloff = 8
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.colorcolumn = "80"

--Netrw adjust
--vim.g.loaded_netrw = 1
----vim.g.loaded_netrwPlugin = 1
--vim.g.netrw_banner = 0 -- Hide banner
--vim.g.netrw_browse_split = 1 --Open in previous window
--vim.g.netrw_altv = 1 -- Open with right splitting
--vim.g.netrw_liststyle = 3 -- Tree-style view
--vim.g.netrw_list_hide = (vim.fn["netrw_gitignore#Hide"]()) .. [[,\(^\|\s\s\)\zs\.\S\+]] -- use .gitignore

--python3 provider
vim.g.python3_host_prog = '/usr/bin/python3.12' --enable
--vim.g.loaded_python3_provider = 0 disable

--Nodejs I DONT KNOW WTF IS THIS
vim.g.loaded_node_provider = 0

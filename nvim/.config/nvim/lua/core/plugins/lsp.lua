return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "williamboman/mason-lspconfig.nvim",
        --"L3MON4D3/LuaSnip",
        {
          "L3MON4D3/LuaSnip",
          version = "v2.3",
          build = "make install_jsregexp",
          dependencies = { "rafamadriz/friendly-snippets" },-- useful snippets
        },
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "nvim-lua/plenary.nvim",
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
        "saadparwaiz1/cmp_luasnip", -- for autocompletion
        --"rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim", -- vs-code like pictograms

    },

    config = function()
        local lspconfig = require("lspconfig")
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local lspkind = require("lspkind") --vs code snipets
        local mason_lspconfig = require("mason-lspconfig")--local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local keymap = vim.keymap -- for conciseness

        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("UserLspConfig", {}),
          callback = function(ev)
            -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

       -- opts.desc = "Go to previous diagnostic"
       --     keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

       -- opts.desc = "Go to next diagnostic"
       -- keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })
        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
              local hl = "DiagnosticSign" .. type
              vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())


        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()
        require("fidget").setup({}) --From primagen setup!!
        mason_lspconfig.setup({
    -- list of servers for mason to install
        ensure_installed = {
--          "tsserver",
--          "html",
--          "cssls",
--          "tailwindcss",
--          "svelte",
          "lua_ls",
          "sqlls",
--          "graphql",
--          "emmet_ls",
--          "prismals",
          "pyright",
        },        -- default handler for installed servers
        handlers = {
        function(server_name)
          lspconfig[server_name].setup{
            capabilities = capabilities,
            }
        end,
        ["pyright"] = function()
        -- configure python language server
        lspconfig["pyright"].setup({
          capabilities = capabilities,
          filetypes = { "python" },
          settings =
          {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true
            }
          }
        }
        })
      end,
      ["sqlls"] = function()
        -- configure sql language server
        lspconfig["sqlls"].setup({
          capabilities = capabilities,
          filetypes = { "sql","mysql" },
        })
      end,
      ["emmet_ls"] = function()
        -- configure emmet language server
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        })
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    },
    })
        -- CMP setup
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
            }),
            --CMP sources
            sources = cmp.config.sources({

                { name = "nvim_lsp" },
                { name = "path" }, --luasnip
                { name = "buffer", keyword_length = 4 },--nvim_lua
            }, {
                { name = "luasnip" },--path
                { name = "nvim_lua" },--buffer

            }),
            --    { name = 'nvim_lsp' },
            --    { name = 'luasnip' }, -- For luasnip users.
            --}, {
            --    { name = 'buffer' },
            --})
            -- VScode icons
            formatting = {
               format = lspkind.cmp_format({
                 maxwidth = 50,
                 ellipsis_char = "...",
               }),
             },
            --dadbod SQL
            cmp.setup.filetype({ "sql","mysql" }, {
              sources = {
              { name = "vim-dadbod-completion" },
              { name = "buffer" },
              { name = "path" }, -- file system paths
              },
       })
    })
        --I dont know what is it
        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}


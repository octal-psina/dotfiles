return{
  "binhtran432k/dracula.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
        require("dracula").setup({
    --colors = {
    --bg = "#282A36",
    --fg = "#F8F8F2",
    --selection = "#44475A",
    --comment = "#8b97bc",--standart color #6272a4
    --red = "#FF5555",
    --orange = "#FFB86C",
    --yellow = "#F1FA8C",
    --green = "#50fa7b",
    --purple = "#BD93F9",
    --cyan = "#8BE9FD",
    --pink = "#FF79C6",
    --bright_red = "#FF6E6E",
    --bright_green = "#69FF94",
    --bright_yellow = "#FFFFA5",
    --bright_blue = "#D6ACFF",
    --bright_magenta = "#FF92DF",
    --bright_cyan = "#A4FFFF",
    --bright_white = "#FFFFFF",
    --menu = "#21222C",
    --visual = "#3E4452",
    --gutter_fg = "#4B5263",
    --nontext = "#8f97a3",
  --},
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "default", -- The theme comes in three styles, `default`, a darker variant `soft` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  on_colors = function() end,

 --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  on_highlights = function() end,
  use_background = true, -- can be light/dark/auto. When auto, background will be set to vim.o.background
})
vim.cmd[[colorscheme dracula]]
end,
}

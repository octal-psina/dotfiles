--reletive number colors
function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg="#31748f", bold=true })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='#9ccfd8', bold=true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#eb6f92', bold=true })
end
LineNumberColors()

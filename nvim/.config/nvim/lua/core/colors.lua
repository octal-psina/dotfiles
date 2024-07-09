--reletive number colors
function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg="#8BE9FD", bold=true })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#FF79C6', bold=true })
end
LineNumberColors()

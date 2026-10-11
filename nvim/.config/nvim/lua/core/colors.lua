--reletive number colors
function LineNumberColors()
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#88c0d0", bold = true })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#b48ead", bold = true })
end
LineNumberColors()

-- To install this plugin you have to read docs for all dependencies below!
-- To map keys :help dap-mapping
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		--dap-ui
		{
			"rcarriga/nvim-dap-ui",
			dependencies = {
				"nvim-neotest/nvim-nio",
			},
		},
		{
			"mfussenegger/nvim-dap-python",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("dapui").setup()
		require("dap-python").setup("/home/katie/.virtualenvs/debugpy/bin/python")

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<Leader>bp", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<Leader>dc", dap.continue, {})
		vim.keymap.set("n", "<Leader>so", dap.step_over, {})
		vim.keymap.set("n", "<Leader>si", dap.step_into, {})
		vim.keymap.set("n", "<Leader>se", dap.step_out, {})
	end,
}

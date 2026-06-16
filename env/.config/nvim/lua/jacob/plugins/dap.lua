return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")
		-- local runtime = vim.uv.fs_stat("yarn.lock") and "yarn" or "npm"
		local runtime = "yarn"

		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<leader>dc", dap.continue, {})

		if not dap.adapters["pwa-node"] then
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						-- Point to the Mason installation instead of the Lazy folder
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}
		end

		if not dap.adapters["node"] then
			dap.adapters["node"] = function(cb, config)
				if config.type == "node" then
					config.type = "pwa-node"
				end

				local nativeAdapter = dap.adapters["pwa-node"]

				if type(nativeAdapter) == "function" then
					nativeAdapter(cb, config)
				else
					cb(nativeAdapter)
				end
			end
		end

		local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

		local vscode = require("dap.ext.vscode")
		vscode.type_to_filetypes["node"] = js_filetypes
		vscode.type_to_filetypes["pwa-node"] = js_filetypes

		local dap_configurations = {
			{
				name = "NestJS: debug",
				type = "pwa-node",
				request = "launch",
				cwd = "${workspaceFolder}/packages/server",
				outDir = "${workspaceFolder}/packages/server/dist",
				runtimeExecutable = runtime,
				runtimeArgs = { "run" },
				args = {
					"start:debug",
				},
				autoAttach = true,
				sourceMaps = true,
				console = "integratedTerminal",
			},
		}

		for _, language in ipairs(js_filetypes) do
			if not dap.configurations[language] then
				dap.configurations[language] = dap_configurations
			end
		end

		-- https://emojipedia.org/en/stickers/search?q=circle
		-- vim.fn.sign_define("DapBreakpoint", {
		-- 	text = "⚪",
		-- 	texthl = "DapBreakpointSymbol",
		-- 	linehl = "DapBreakpoint",
		-- 	numhl = "DapBreakpoint",
		-- })
		--
		-- vim.fn.sign_define("DapStopped", {
		-- 	text = "🔴",
		-- 	texthl = "yellow",
		-- 	linehl = "DapBreakpoint",
		-- 	numhl = "DapBreakpoint",
		-- })
		--
		-- vim.fn.sign_define("DapBreakpointRejected", {
		-- 	text = "⭕",
		-- 	texthl = "DapStoppedSymbol",
		-- 	linehl = "DapBreakpoint",
		-- 	numhl = "DapBreakpoint",
		-- })

		local dapui = require("dapui")
		-- Initialize the UI
		dapui.setup({
			expand_lines = true,
			floating = {
				border = "rounded",
			},
			render = { max_type_length = 60, max_value_lines = 200 },
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.7,
						},
						{
							id = "console",
							size = 0.3,
						},
					},
					position = "bottom",
					size = 20,
				},
			},
		})

		-- Tell dapui to automatically open and close when debugging starts/stops
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,

	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
}

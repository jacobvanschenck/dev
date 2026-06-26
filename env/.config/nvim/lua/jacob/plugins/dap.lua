return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")
		local runtime = "yarn"

		vim.keymap.set("n", "<leader>dc", dap.continue, {})

		vim.keymap.set("n", "<F3>", dap.continue)
		vim.keymap.set("n", "<F4>", dap.step_over)
		vim.keymap.set("n", "<F13>", dap.step_into)
		vim.keymap.set("n", "<F16>", dap.step_out)
		vim.keymap.set("n", "<F17>", dap.step_back)
		vim.keymap.set("n", "<F18>", dap.restart)
		vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint)

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

		local dapview = require("dap-view")
		-- https://igorlfs.github.io/nvim-dap-view/configuration
		dapview.setup({
			winbar = {
				sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
				default_section = "console",
			},
			windows = {
				size = 0.4,
				position = "below",
			},
		})

		-- Tell dapui to automatically open and close when debugging starts/stops
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapview.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapview.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapview.close()
		end
	end,

	dependencies = {
		"igorlfs/nvim-dap-view",
		"nvim-neotest/nvim-nio",
	},
}

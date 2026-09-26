return {
	-- Глубокая подсветка синтаксиса C#
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "c_sharp" })
			end
		end,
	},

	-- Современный LSP сервер Roslyn для C#
	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		opts = function()
			-- Безопасно получаем стандартные capabilities из LazyVim
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if has_cmp then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end
			return {
				capabilities = capabilities,
				-- Настройки по умолчанию для roslyn
				config = {
					-- Здесь можно передать кастомные настройки для сервера, если понадобятся
				},
			}
		end,
	},

	-- Настройка отладчика (DAP) для C#
	-- {
	--   "mfussenegger/nvim-dap",
	--   opts = function()
	--     local dap = require("dap")
	--     -- Регистрируем netcoredbg, который вы установите через :Mason
	--     dap.adapters.coreclr = {
	--       type = "executable",
	--       command = "netcoredbg",
	--       args = { "--interpreter=vsdap" },
	--     }
	--     dap.configurations.cs = {
	--       {
	--         type = "coreclr",
	--         name = "launch - netcoredbg",
	--         request = "launch",
	--         program = function()
	--           -- Запрашивает путь к скомпилированной .dll вашего проекта
	--           return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
	--         end,
	--       },
	--     }
	--   end,
	-- },
}

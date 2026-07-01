return {
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			-- Настройки ДО загрузки темы для максимального контраста
			vim.g.everforest_background = "hard" -- Делает фон темнее, а цвета ярче
			vim.g.everforest_better_performance = 1

			-- Дополнительно: делаем синтаксис более насыщенным
			vim.g.everforest_ui_contrast = "high"
			vim.g.everforest_diagnostic_text_highlight = 1
		end,
	},

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "everforest",
		},
	},
}

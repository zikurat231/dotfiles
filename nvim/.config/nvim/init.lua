vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_vfx_mode = "pixiedust"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.showtabline = 0
vim.opt.cmdheight = 1
vim.opt.undofile = true
vim.opt.number = true
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false

vim.opt.cursorline = true

vim.opt.clipboard = "unnamedplus"

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 3

vim.opt.mouse = ""

vim.highlight.priorities.semantic_tokens = 95

-- Plugins
vim.pack.add({
	{ src = "https://github.com/EdenEast/nightfox.nvim" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/folke/noice.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/karb94/neoscroll.nvim" },
	{ src = "https://github.com/kevinhwang91/nvim-bqf" },
	{ src = "https://github.com/kevinhwang91/nvim-hlslens" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/MagicDuck/grug-far.nvim" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/mg979/vim-visual-multi", version = "master" },
	{ src = "https://github.com/mtdl9/vim-log-highlighting" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-mini/mini.nvim", version = "main" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = "v0.1.9" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
	{ src = "https://github.com/otavioschwanck/arrow.nvim" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/RRethy/vim-illuminate" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1") },
	{ src = "https://github.com/sindrets/diffview.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/tpope/vim-surround" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cpp", "hpp", "c", "cc" }, -- Include common C and C++ extensions.
	callback = function()
		vim.cmd("inoreabbrev <buffer> end std::endl;")
	end,
})

-- Language servers and diagnostics
vim.lsp.config("clangd", {
	cmd = { "clangd", "--background-index", "--clang-tidy" },
})
vim.lsp.enable({
	"clangd",
	"gopls",
	"basedpyright",
})

vim.diagnostic.config({
	virtual_text = true, -- Show diagnostics inline.
	underline = true, -- Underline invalid code.
	signs = true, -- Show diagnostic signs.
	update_in_insert = false, -- Do not update diagnostics while typing.
	severity_sort = true, -- Show the most severe diagnostics first.
})

vim.lsp.config("protols", {
	cmd = { vim.fn.expand("~/work/myDeal/protols") },
	filetypes = { "proto" },
})

vim.filetype.add({
	filename = {
		["Jenkinsfile"] = "groovy",
		["jenkinsfile"] = "groovy", -- Also support the lowercase variant.
	},
	pattern = {
		["Jenkinsfile.*"] = "groovy",
		[".*%.jenkinsfile"] = "groovy",
	},
})

-- Plugin configuration
require("noice").setup({
	presets = {
		command_palette = true,
	},
})

require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<CR>"] = { "accept", "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		menu = {
			draw = {
				treesitter = { "lsp" },
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		ghost_text = {
			enabled = vim.g.ai_cmp,
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = {
		implementation = "lua",
	},
})

vim.cmd.colorscheme("nightfox")

require("nvim-web-devicons").setup({
	color_icons = false,
	strict = true,
})

local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

require("telescope").setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--fixed-strings", -- Treat the search query as plain text.
		},
		layout_strategy = "vertical",
		layout_config = {
			height = 0.95,
			prompt_position = "top",
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.send_to_qflist,

				["<CR>"] = actions.select_default,

				["<C-p>"] = actions.cycle_history_prev,
				["<C-n>"] = actions.cycle_history_next,
				["<C-o>"] = open_with_trouble,

				["<C-c>"] = actions.close,
			},
			n = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-n>"] = actions.cycle_history_next,

				["p"] = function()
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i<C-r>0", true, false, true), "n", false)
				end,
				["<C-c>"] = actions.close,
				["dd"] = actions.delete_buffer,
			},
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
		live_grep = {
			sorting_strategy = "ascending",
		},
		buffers = {
			initial_mode = "normal",
			ignore_current_buffer = true,
			sort_lastused = true,
		},
	},
	extensions = {},
})

require("trouble").setup({
	focus = true,
	position = "bottom",
	keys = { l = "jump", h = "fold_toggle" },
	win = {
		type = "split",
		relative = "win",
		position = "bottom",
		size = 0.3,
	},
	modes = {
		telescope = {
			max_items = 10000,
			groups = {
				{ "directory" },
				{ "filename", format = "{file_icon} {basename:Title} {count}" },
			},
		},
	},
})

local MiniFiles = require("mini.files")

MiniFiles.setup({
	windows = {
		preview = true,
		width_focus = 30,
		width_preview = 50,
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local open_entry = function()
			MiniFiles.go_in({ close_on_file = true })
		end

		vim.keymap.set("n", "l", open_entry, { buffer = args.data.buf_id })
		vim.keymap.set("n", "<CR>", open_entry, { buffer = args.data.buf_id })
	end,
})

require("treesitter-context").setup({
	enable = true,
	max_lines = 3,
	multiline_threshold = 1,
	trim_scope = "outer",
	mode = "cursor",
	separator = "─",
})

require("conform").setup({
	formatters_by_ft = {
		sh = { "shfmt" },
		python = { "ruff_format" },
		lua = { "stylua" },
		go = { "goimports", "gofmt" },
	},
})

require("grug-far").setup({})

require("neoscroll").setup({
	mappings = {
		"<C-u>",
		"<C-d>",
		"<C-b>",
		"<C-f>",
		"<C-y>",
		"<C-e>",
		"zt",
		"zz",
		"zb",
	},
	hide_cursor = true,
	stop_eof = true,
	respect_scrolloff = true,
	duration_multiplier = 0.8,
	easing = "sine",
})

require("diffview").setup({
	use_icons = false,
	diff_binaries = false,
})

require("nvim-autopairs").setup({})

require("gitsigns").setup({})

require("which-key").setup({
	preset = "helix",
})

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {
				"trouble",
				"qf", -- Quickfix, including some Trouble views.
				"help",
				"terminal",
				"toggleterm",
			},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = false,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16,
			{
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = { "diagnostics" },
		lualine_x = { "fileformat", "filetype" },
		lualine_y = { { "datetime", style = "%d/%m %H:%M" } },
		lualine_z = {
			function()
				local current_line = vim.fn.line(".")
				local total_lines = vim.fn.line("$")
				return string.format("%d/%d", current_line, total_lines)
			end,
		},
	},

	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},

	winbar = {
		lualine_a = {},
		lualine_b = {
			{
				"filename",
				file_status = true,
				path = 1,
				symbols = {
					modified = " ●", -- Bold dot from Nerd Fonts.
				},
			},
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {
			{
				"filename",
				file_status = true,
				path = 1,
				symbols = {
					modified = " ●",
				},
			},
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
})

require("hlslens").setup({
	nearest_only = true,
})

require("flash").setup()

require("illuminate").configure({
	providers = {
		"lsp",
	},
	delay = 300,
	filetype_overrides = {},
	filetypes_denylist = {
		"dirbuf",
		"dirvish",
		"fugitive",
	},
	filetypes_allowlist = {},
	modes_denylist = {},
	modes_allowlist = {},
	providers_regex_syntax_denylist = {},
	providers_regex_syntax_allowlist = {},
	under_cursor = true,
	large_file_cutoff = 3000,
	large_file_overrides = nil,
	min_count_to_highlight = 1,
	should_enable = function(bufnr)
		return true
	end,
	case_insensitive_regex = false,
	disable_keymaps = false,
})

require("arrow").setup({
	show_icons = true,
	leader_key = ";", -- Open the project bookmarks menu.
	buffer_leader_key = "m", -- Open bookmarks for the current buffer.
})

require("ibl").setup({})

-- Keymaps
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>w", "<C-w>")
vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		async = true,
		lsp_format = "fallback",
	})
end, { desc = "Format file" })

local builtin = require("telescope.builtin")

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gs", "<cmd>LspClangdSwitchSourceHeader<cr>", { desc = "Switch source/header" })
vim.keymap.set("n", "grr", "<cmd>Trouble lsp_references toggle<cr>", { desc = "LSP References (Trouble)" })
vim.keymap.set("n", "gk", vim.lsp.buf.hover, { desc = "LSP: Show information" })
vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "Rename symbol (LSP)" })

vim.keymap.set("n", "H", require("arrow.persist").previous)
vim.keymap.set("n", "L", require("arrow.persist").next)
vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "Jump to code context" })

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })

vim.keymap.set("n", "<Leader>fr", require("telescope.builtin").resume, { desc = "Resume last Telescope picker" })
vim.keymap.set(
	"n",
	"<Leader>fhc",
	require("telescope.builtin").command_history,
	{ desc = "[F]ind [H]istory [C]ommands" }
)
vim.keymap.set("n", "<Leader>fhs", require("telescope.builtin").search_history, { desc = "[F]ind [H]istory [S]earch" })

vim.keymap.set("n", "<Leader>cn", ":cnext<CR>", { desc = "Quickfix: Next item" })
vim.keymap.set("n", "<Leader>cp", ":cprev<CR>", { desc = "Quickfix: Previous item" })

vim.keymap.set("n", "<leader>co", ":copen<CR>", { desc = "Quickfix: Open QuickList" })
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", { desc = "Quickfix: Close QuickList" })

vim.keymap.set("n", "<leader>e", function()
	local path = vim.api.nvim_buf_get_name(0)
	require("mini.files").open(path ~= "" and path or vim.uv.cwd(), true)
end, { desc = "Open file manager" })

vim.keymap.set("n", "<leader>gf", ":DiffviewFileHistory %<CR>")

vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash search" })

vim.keymap.set("n", "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Gitsigns reset hunk" })
vim.keymap.set("n", "<leader>ghv", ":Gitsigns preview_hunk<CR>")
vim.keymap.set("n", "<leader>ghp", ":Gitsigns nav_hunk prev<CR>")
vim.keymap.set("n", "<leader>ghn", ":Gitsigns nav_hunk next<cr>")
vim.keymap.set("n", "<leader>gb", ":Gitsigns blame<CR>")

vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "]]", require("illuminate").goto_next_reference)
vim.keymap.set("n", "[[", require("illuminate").goto_prev_reference)

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
vim.keymap.set("n", "<C-w>o", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w><C-o>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>wo", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>w<C-o>", "<Nop>", { noremap = true, silent = true })

local function get_visual_selection()
	vim.cmd('noau normal! "vy')
	return vim.fn.getreg("v")
end

vim.keymap.set("n", "<leader>fg", function()
	builtin.live_grep({ default_text = vim.fn.expand("<cword>") })
end, { desc = "Live Grep word" })

vim.keymap.set("x", "<leader>fg", function()
	builtin.live_grep({ default_text = get_visual_selection() })
end, { desc = "Live Grep selection" })
vim.keymap.set("n", "<leader>gw", require("telescope.builtin").grep_string, { desc = "Search word under cursor" })

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble diagnostics" })

vim.keymap.set(
	"n",
	"<leader>xd",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Current file diagnostics" }
)

vim.keymap.set({ "n", "v" }, "<leader>fip", function()
	local q = ""

	if vim.fn.mode():find("[vV]") then
		vim.cmd('normal! "vy')
		q = vim.fn.getreg("v")
	else
		q = vim.fn.input("Grep Proto: ")
	end

	if q == "" then
		return
	end
	vim.cmd("silent! grep! " .. "-S -g'*.proto' " .. vim.fn.shellescape(q))
	vim.cmd("copen")
end, { desc = "Grep Proto (quickfix)" })

vim.keymap.set({ "n", "v" }, "<leader>fij", function()
	local q = ""

	if vim.fn.mode():find("[vV]") then
		vim.cmd('normal! "vy')
		q = vim.fn.getreg("v")
	else
		q = vim.fn.input("Grep JSON: ")
	end

	if q == "" then
		return
	end
	vim.cmd("silent! grep! " .. "-S -g'*.json' " .. vim.fn.shellescape(q))
	vim.cmd("copen")
end, { desc = "Grep JSON (quickfix)" })

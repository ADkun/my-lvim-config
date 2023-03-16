--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
vim.opt.cursorcolumn = true

local function get_cmd(c)
	return "<cmd>" .. c .. "<CR>"
end

-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	pattern = "*.lua",
	timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["ga"] = ":EasyAlign<CR>"
lvim.keys.visual_mode["ga"] = ":EasyAlign<CR>"

lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["o"] = {
	name = "+Custom",
	w = { get_cmd("setlocal wrap!"), "Toggle Soft Wrap" },
	s = {
		name = "+Spectre",
		s = { get_cmd("lua require('spectre').open()"), "Spectre Open" },
		w = { get_cmd("lua require('spectre').open_visual({select_word=true})"), "Spectre in Visual Word" },
		v = { "<esc>:lua require('spectre').open_visual()<CR>", "Spectre in Visual" },
		f = { "viw:lua require('spectre').open_file_search()<CR>", "Spectre in File" },
	},
	t = {
		name = "+Todo",
		q = { get_cmd("TodoQuickFix"), "Todo quickfix" },
		l = { get_cmd("TodoLocList"), "Todo loclist" },
		t = { get_cmd("TodoTelescope"), "Todo Telescope" },
		T = { get_cmd("TodoTrouble"), "Todo Trouble" },
	},
	n = {
		name = "+Notify",
		n = { get_cmd("Notifications"), "Show Notifications" },
		t = { get_cmd("Noice telescope"), "Show Notifications in Telescope" },
		m = { get_cmd("messages"), "Show Messages" },
	},
	m = {
		name = "+Marks",
		a = { "<cmd>MarksListAll<CR>", "Show All Marks" },
		b = { "<cmd>MarksListBuf<CR>", "Show Marks in Buffer" },
		g = { "<cmd>MarksListGlobal<CR>", "Show Marks Global" },
	},
	l = { "<cmd>e<CR>", "Reload File" },
	c = { "<cmd>pwd<CR>", "Show Current Folder" },
	o = { "<cmd>SymbolsOutline<cr>", "Toggle Symbols Outline" },
	i = { "<cmd>LspInstall<cr>", "LspInstall" },
}
lvim.builtin.which_key.mappings["m"] = { get_cmd("WindowsMaximize"), "Window Maximize" }
lvim.builtin.which_key.mappings["z"] = {
	name = "+Windows",
	m = { get_cmd("WindowsMaximize"), "Window Maximize" },
	v = { get_cmd("WindowsMaximizeVertically"), "Window Vertically Maximize" },
	h = { get_cmd("WindowsMaximizeHorizontally"), "Window Horizontally Maximize" },
	e = { get_cmd("WindowsEqualize"), "Window Equalize" },
}
lvim.builtin.which_key.mappings["a"] =
	{ get_cmd("lua require('persistence').load()"), "Restore last session for current dir" }
lvim.builtin.which_key.mappings["S"] = {
	name = "+Session",
	c = { get_cmd("lua require('persistence').load()"), "Restore last session for current dir" },
	l = { get_cmd("lua require('persistence').load({ last = true })"), "Restore last session" },
	Q = { get_cmd("lua require('persistence').stop()"), "Quit without saving session" },
}
lvim.builtin.which_key.mappings["t"] = {
	name = "Diagnostics",
	t = { "<cmd>TroubleToggle<cr>", "trouble" },
	w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
	d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
	q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
	l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
	r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

-- -- Change theme settings
-- lvim.colorscheme = "one_monokai"
lvim.colorscheme = "OceanicNext"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = false

-- --- disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
lvim.builtin.treesitter.ensure_installed = {
	"comment",
	"markdown_inline",
	"regex",
	"html",
	"bash",
	"c",
	"cpp",
	"python",
	"go",
	"gosum",
	"gomod",
	"markdown",
	"dockerfile",
	"cmake",
	"make",
	"ini",
	"toml",
	"yaml",
	"thrift",
	"css",
	"javascript",
	"po",
	"json",
	"rust",
	"lua",
}

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--     return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
-- 	local function buf_set_option(...)
-- 		vim.api.nvim_buf_set_option(bufnr, ...)
-- 	end
-- 	--Enable completion triggered by <c-x><c-o>
-- 	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua" },
	{
		command = "black",
		filetypes = { "python" },
	},
	{
		command = "prettier",
		extra_args = { "--print-width", "100" },
		filetypes = { "typescript", "typescriptreact" },
	},
})
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "flake8", filetypes = { "python" } },
	{
		command = "shellcheck",
		args = { "--severity", "warning" },
	},
	{
		command = "luacheck",
		filetypes = { "lua" },
	},
	-- {
	-- 	command = "cpplint",
	-- 	filetypes = { "cpp", "c" },
	-- },
})

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
	{
		"nathom/filetype.nvim",
		lazy = true,
		event = { "BufRead", "BufNewFile", "BufReadPre" },
		config = function()
			require("filetype").setup({
				overrides = {
					extensions = {
						-- Set the filetype of *.pn files to potion
						pn = "potion",
						h = "cpp",
					},
					literal = {
						-- Set the filetype of files named "MyBackupFile" to lua
						MyBackupFile = "lua",
					},
					complex = {
						-- Set the filetype of any full filename matching the regex to gitconfig
						[".*git/config"] = "gitconfig", -- Included in the plugin
					},

					-- The same as the ones above except the keys map to functions
					function_extensions = {
						["cpp"] = function()
							vim.bo.filetype = "cpp"
							-- Remove annoying indent jumping
							vim.bo.cinoptions = vim.bo.cinoptions .. "L0"
						end,
						["pdf"] = function()
							vim.bo.filetype = "pdf"
							-- Open in PDF viewer (Skim.app) automatically
							vim.fn.jobstart("open -a skim " .. '"' .. vim.fn.expand("%") .. '"')
						end,
					},
					function_literal = {
						Brewfile = function()
							vim.cmd("syntax off")
						end,
					},
					function_complex = {
						["*.math_notes/%w+"] = function()
							vim.cmd("iabbrev $ $$")
						end,
					},

					shebang = {
						-- Set the filetype of files with a dash shebang to sh
						dash = "sh",
					},
				},
			})
		end,
	},
	{
		-- Smart Panel
		"folke/trouble.nvim",
		lazy = true,
		cmd = { "TroubleToggle", "Trouble", "TroubleRefresh" },
		config = function()
			require("trouble").setup()
		end,
	},
	{
		"ggandor/leap.nvim",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("leap").opts.highlight_unlabeled_phase_one_targets = true
			-- leap.add_default_mappings()
			vim.keymap.set({ "x", "o", "n" }, "R", "<Plug>(leap-forward-to)")
			vim.keymap.set({ "x", "o", "n" }, "E", "<Plug>(leap-backward-to)")
			vim.keymap.set({ "x", "o", "n" }, "W", "<Plug>(leap-from-window)")
		end,
	},
	{
		"ggandor/flit.nvim",
		lazy = true,
		event = { "User FileOpened" },
		dependencies = { "ggandor/leap.nvim" },
		config = function()
			require("flit").setup({
				keys = {
					f = "f",
					F = "F",
					t = "t",
					T = "T",
				},
				labeled_modes = "v",
				multiline = true,
				opts = {},
			})
		end,
	},
	{
		"phaazon/hop.nvim",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("hop").setup({
				-- keys = "etovxqpdygfblzhckisuran",
				-- uppercase_labels = true,
				-- hint_position = require("hop.hint").HintPosition.MIDDLE,
			})
			-- vim.api.nvim_set_keymap("n", "R", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "r", ":HopChar1<cr>", { silent = true })
			-- vim.api.nvim_set_keymap("n", "W", ":HopWord<cr>", { silent = true })
			-- vim.api.nvim_set_keymap("n", "W", ":HopLine<cr>", { silent = true })
			-- vim.api.nvim_set_keymap("n", "P", ":HopPattern<cr>", { silent = true })
		end,
	},
	{
		-- Bracket pair rainbow colorize
		"mrjones2014/nvim-ts-rainbow",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			lvim.builtin.treesitter.rainbow.enable = true
		end,
	},
	{
		-- Show context of code such as function name, class name, labels
		"romgrk/nvim-treesitter-context",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				throttle = true, -- Throttles plugin updates (may improve performance)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				patterns = {
					default = {
						"class",
						"function",
						"method",
					},
				},
			})
		end,
	},
	{
		-- Colors
		"folke/lsp-colors.nvim",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("lsp-colors").setup()
		end,
	},
	{
		-- Show function signature hint
		"ray-x/lsp_signature.nvim",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("lsp_signature").on_attach()
		end,
	},
	{
		-- Auto set commentstring base on your cursor
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		event = { "User FileOpened" },
	},
	{
		-- Preview goto page
		"rmagatti/goto-preview",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("goto-preview").setup({
				width = 120, -- Width of the floating window
				height = 25, -- Height of the floating window
				default_mappings = true, -- Bind default mappings
				debug = false, -- Print debug information
				opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
				-- You can use "default_mappings = true" setup option
				-- Or explicitly set keybindings
				-- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
				-- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
				-- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
			})
		end,
	},
	{
		-- Remember last place
		"ethanholz/nvim-lastplace",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	{
		-- HACK, NOTE, TODO, WARNING, BUG, FIX, PREF
		"folke/todo-comments.nvim",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("todo-comments").setup()
		end,
	},
	{ -- dot
		"tpope/vim-repeat",
		lazy = true,
		event = { "User FileOpened" },
	},
	{
		-- csxx
		"tpope/vim-surround",
		lazy = true,
		keys = { "c", "d", "y" },
		event = "User FileOpened",
	},
	{
		-- Replace all
		"windwp/nvim-spectre",
		lazy = true,
		cmd = { "Spectre" },
		config = function()
			require("spectre").setup()
		end,
	},
	{
		-- Add some function to quickfix & loclist
		-- <C-S>: Split
		-- <C-O>: Toggle all
		"kevinhwang91/nvim-bqf",
		lazy = true,
		-- event = { "BufRead", "BufNew" },
		event = { "WinNew" },
		config = function()
			require("bqf").setup({
				auto_enable = true,
				auto_resize_height = true,
				preview = {
					win_height = 12,
					win_vheight = 12,
					delay_syntax = 80,
					border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
					should_preview_cb = function(bufnr, qwinid)
						local ret = true
						local bufname = vim.api.nvim_buf_get_name(bufnr)
						local fsize = vim.fn.getfsize(bufname)
						if fsize > 100 * 1024 then
							-- skip file size greater than 100k
							ret = false
						elseif bufname:match("^fugitive://") then
							-- skip fugitive buffer
							ret = false
						end
						return ret
					end,
				},
				func_map = {
					drop = "o",
					openc = "O",
					split = "<C-s>",
					tabdrop = "<C-t>",
					tabc = "",
					vsplit = "<C-v>",
					ptogglemode = "z,",
					stoggleup = "",
				},
				filter = {
					fzf = {
						action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
						extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
					},
				},
			})
		end,
	},
	{
		-- Highlight, jump between pairs like if..else
		"andymass/vim-matchup",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
			lvim.builtin.treesitter.matchup.enable = true
		end,
	},
	{
		-- Restore last session of current dir
		"folke/persistence.nvim",
		lazy = true,
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
				options = { "buffers", "curdir", "tabpages", "winsize" },
				pre_save = nil,
			})
		end,
	},
	{
		-- Custom keys to exit normal_mode
		"max397574/better-escape.nvim",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("better_escape").setup({
				mapping = { "jk", "jl" },
				timeout = 150,
				clear_empty_lines = false,
				keys = "<Esc>",
			})
		end,
	},
	{
		-- Use <Tab> jump out of quotes
		"abecodes/tabout.nvim",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>",
				backwards_tabkey = "<S-Tab>",
				act_as_tab = true,
				act_as_shift_tab = false,
				default_tab = "<C-t>",
				default_shift_tab = "<C-d>",
				enable_backwards = true,
				completion = true,
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },
				},
				ignore_beginning = true,
				exclude = {
					"qf",
					"NvimTree",
					"toggleterm",
					"TelescopePrompt",
					"alpha",
					"netrw",
				},
			})
		end,
		after = { "nvim-cmp" },
	},
	{
		-- Yank from any circumstance
		"ibhagwan/smartyank.nvim",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("smartyank").setup()
		end,
	},
	{
		-- Show and jump to marks
		"chentoast/marks.nvim",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("marks").setup({
				default_mappings = true,
				-- builtin_marks = { ".", "<", ">", "^" },
				cyclic = true,
				force_write_shada = false,
				refresh_interval = 250,
				sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
				excluded_filetypes = {
					"qf",
					"NvimTree",
					"toggleterm",
					"TelescopePrompt",
					"alpha",
					"netrw",
				},
				bookmark_0 = {
					sign = "",
					virt_text = "hello world",
					annotate = false,
				},
				mappings = {},
			})
		end,
	},
	{
		"zbirenbaum/neodim",
		lazy = true,
		event = "LspAttach",
		config = function()
			require("neodim").setup({
				alpha = 0.75,
				blend_color = "#000000",
				update_in_insert = {
					enable = true,
					delay = 100,
				},
				hide = {
					virtual_text = true,
					signs = false,
					underline = false,
				},
			})
		end,
	},
	{
		"anuvyklack/middleclass",
		lazy = true,
	},
	{
		"anuvyklack/windows.nvim",
		lazy = true,
		cmd = { "WindowsMaximize", "WindowsMaximizeVertically", "WindowsMaximizeHorizontally", "WindowsEqualize" },
		dependencies = {
			"anuvyklack/middleclass",
		},
		config = function()
			require("windows").setup({
				autowidth = {
					enable = false,
				},
				ignore = {
					buftype = { "quickfix" },
					filetype = {
						"NvimTree",
						"neo-tree",
						"undotree",
						"gundo",
						"qf",
						"toggleterm",
						"TelescopePrompt",
						"alpha",
						"netrw",
					},
				},
			})
		end,
	},
	{
		"mhartington/oceanic-next",
		priority = 1000,
		lazy = lvim.colorscheme ~= "OceanicNext",
	},
	{
		"rcarriga/nvim-notify",
		lazy = true,
		event = "VeryLazy",
		config = function()
			local notify = require("notify")
			notify.setup({
				-- "fade", "slide", "fade_in_slide_out", "static"
				stages = "static",
				on_open = nil,
				on_close = nil,
				timeout = 3000,
				fps = 1,
				render = "default",
				background_colour = "Normal",
				max_width = math.floor(vim.api.nvim_win_get_width(0) / 2),
				max_height = math.floor(vim.api.nvim_win_get_height(0) / 4),
				-- minimum_width = 50,
				-- ERROR > WARN > INFO > DEBUG > TRACE
				level = "TRACE",
			})

			vim.notify = notify
		end,
	},
	{
		"MunifTanjim/nui.nvim",
		lazy = true,
	},
	{
		"folke/noice.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = { "rcarriga/nvim-notify", "MunifTanjim/nui.nvim" },
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = false,
				},
				messages = {
					enabled = true,
					view = "notify",
					view_error = "notify",
					view_warn = "notify",
					view_history = "messages",
					view_search = "virtualtext",
				},
				health = {
					checker = false,
				},
			})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		lazy = true,
		event = { "User FileOpened" },
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			vim.o.foldcolumn = "1" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
			vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
			vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
			vim.keymap.set("n", "B", function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					-- choose one of coc.nvim and nvim lsp
					vim.lsp.buf.hover()
				end
			end)

			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("  %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
				fold_virt_text_handler = handler,
			})
		end,
	},
	{
		"edluffy/specs.nvim",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			local specs = require("specs")
			specs.setup({
				show_jumps = true,
				min_jump = 10,
				popup = {
					delay_ms = 0,
					inc_ms = 10,
					blend = 50,
					width = 10,
					winhl = "PMenu",
					fader = specs.pulse_fader,
					resizer = specs.shrink_resizer,
				},
				ignore_filetypes = {},
				ignore_buftypes = { nofile = true },
			})
			-- You can even bind it to search jumping and more, example:
			vim.api.nvim_set_keymap(
				"n",
				"n",
				'n:lua require("specs").show_specs()<CR>',
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"N",
				'N:lua require("specs").show_specs()<CR>',
				{ noremap = true, silent = true }
			)

			-- Or maybe you do a lot of screen-casts and want to call attention to a specific line of code:
			vim.api.nvim_set_keymap(
				"n",
				"<leader>v",
				':lua require("specs").show_specs({blend = 80, width = 97, winhl = "Search", delay_ms = 0, inc_ms = 21})<CR>',
				{ noremap = true, silent = true }
			)
		end,
	},
	{
		"junegunn/vim-easy-align",
		lazy = true,
		cmd = "EasyAlign",
	},
	{
		"s1n7ax/nvim-window-picker",
		lazy = true,
		event = { "WinNew" },
		config = function()
			local picker = require("window-picker")
			picker.setup({
				autoselect_one = true,
				include_current = false,
				filter_rules = {
					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

						-- if the buffer type is one of following, the window will be ignored
						buftype = { "terminal" },
					},
				},
				other_win_hl_color = "#e35e4f",
			})

			vim.keymap.set("n", ",w", function()
				local picked_window_id = picker.pick_window({
					include_current_win = true,
				}) or vim.api.nvim_get_current_win()
				vim.api.nvim_set_current_win(picked_window_id)
			end, { desc = "Pick a window" })

			-- Swap two windows using the awesome window picker
			local function swap_windows()
				local window = picker.pick_window({
					include_current_win = false,
				})
				local target_buffer = vim.fn.winbufnr(window)
				-- Set the target window to contain current buffer
				vim.api.nvim_win_set_buf(window, 0)
				-- Set current window to contain target buffer
				vim.api.nvim_win_set_buf(0, target_buffer)
			end

			vim.keymap.set("n", ",W", swap_windows, { desc = "Swap windows" })
		end,
	},
	{
		"nacro90/numb.nvim",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			})
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		lazy = true,
		cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
		config = function()
			local opts = {
				highlight_hovered_item = true,
				show_guides = true,
				auto_preview = false,
				position = "right",
				relative_width = true,
				width = 25,
				auto_close = false,
				show_numbers = false,
				show_relative_numbers = false,
				show_symbol_details = true,
				preview_bg_highlight = "Pmenu",
				autofold_depth = nil,
				auto_unfold_hover = true,
				fold_markers = { "", "" },
				wrap = false,
				keymaps = { -- These keymaps can be a string or a table for multiple keys
					close = { "<Esc>", "q" },
					goto_location = "<Cr>",
					focus_location = "o",
					hover_symbol = "<C-space>",
					toggle_preview = "K",
					rename_symbol = "r",
					code_actions = "a",
					fold = "h",
					unfold = "l",
					fold_all = "P",
					unfold_all = "U",
					fold_reset = "Q",
				},
				lsp_blacklist = {},
				symbol_blacklist = {},
				symbols = {
					File = { icon = "", hl = "@text.uri" },
					Module = { icon = "", hl = "@namespace" },
					Namespace = { icon = "", hl = "@namespace" },
					Package = { icon = "", hl = "@namespace" },
					Class = { icon = "𝓒", hl = "@type" },
					Method = { icon = "ƒ", hl = "@method" },
					Property = { icon = "", hl = "@method" },
					Field = { icon = "", hl = "@field" },
					Constructor = { icon = "", hl = "@constructor" },
					Enum = { icon = "", hl = "@type" },
					Interface = { icon = "ﰮ", hl = "@type" },
					Function = { icon = "", hl = "@function" },
					Variable = { icon = "", hl = "@constant" },
					Constant = { icon = "", hl = "@constant" },
					String = { icon = "𝓐", hl = "@string" },
					Number = { icon = "#", hl = "@number" },
					Boolean = { icon = "", hl = "@boolean" },
					Array = { icon = "", hl = "@constant" },
					Object = { icon = "", hl = "@type" },
					Key = { icon = "🔐", hl = "@type" },
					Null = { icon = "NULL", hl = "@type" },
					EnumMember = { icon = "", hl = "@field" },
					Struct = { icon = "𝓢", hl = "@type" },
					Event = { icon = "🗲", hl = "@type" },
					Operator = { icon = "+", hl = "@operator" },
					TypeParameter = { icon = "𝙏", hl = "@parameter" },
					Component = { icon = "󰡀", hl = "@function" },
					Fragment = { icon = "", hl = "@constant" },
				},
			}
			require("symbols-outline").setup(opts)
		end,
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		lazy = true,
		event = "WinNew",
		config = function()
			require("colorful-winsep").setup()
		end,
	},
	{
		"booperlv/nvim-gomove",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("gomove").setup({
				map_defaults = false,
				reindent = true,
				undojoin = true,
				move_past_end_col = false,
			})

			local map = vim.api.nvim_set_keymap
			map("n", "<M-h>", "<Plug>GoNSMLeft", { noremap = true, silent = true })
			map("n", "<M-j>", "<Plug>GoNSMDown", { noremap = true, silent = true })
			map("n", "<M-k>", "<Plug>GoNSMUp", { noremap = true, silent = true })
			map("n", "<M-l>", "<Plug>GoNSMRight", { noremap = true, silent = true })

			map("x", "<M-h>", "<Plug>GoVSMLeft", { noremap = true, silent = true })
			map("x", "<M-j>", "<Plug>GoVSMDown", { noremap = true, silent = true })
			map("x", "<M-k>", "<Plug>GoVSMUp", { noremap = true, silent = true })
			map("x", "<M-l>", "<Plug>GoVSMRight", { noremap = true, silent = true })

			map("x", "<C-h>", "<Plug>GoVSDLeft", { noremap = true, silent = true })
			map("x", "<C-j>", "<Plug>GoVSDDown", { noremap = true, silent = true })
			map("x", "<C-k>", "<Plug>GoVSDUp", { noremap = true, silent = true })
			map("x", "<C-l>", "<Plug>GoVSDRight", { noremap = true, silent = true })
		end,
	},
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "zsh",
-- 	callback = function()
-- 		-- let treesitter use bash highlight for zsh files as well
-- 		require("nvim-treesitter.highlight").attach(0, "bash")
-- 	end,
-- })

-- vim.api.nvim_create_autocmd({ "ModeChanged" }, {
-- 	callback = function()
-- 		local current_mode = vim.fn.mode()
-- 		if current_mode == "n" then
-- 			vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#8aa872" })
-- 			vim.fn.sign_define("smoothcursor", { text = "" })
-- 		elseif current_mode == "v" then
-- 			vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
-- 			vim.fn.sign_define("smoothcursor", { text = "" })
-- 		elseif current_mode == "V" then
-- 			vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
-- 			vim.fn.sign_define("smoothcursor", { text = "" })
-- 		elseif current_mode == "x" then
-- 			vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
-- 			vim.fn.sign_define("smoothcursor", { text = "" })
-- 		elseif current_mode == "i" then
-- 			vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#668aab" })
-- 			vim.fn.sign_define("smoothcursor", { text = "" })
-- 		end
-- 	end,
-- })

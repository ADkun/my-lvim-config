local ENABLE_EXT = true
local ENABLE_NOICE = true
local ENABLE_HARPOON = true

-- vim options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
vim.opt.cursorcolumn = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = false,
	pattern = "*.lua",
	timeout = 2500,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<CR>"

local function set_keymap()
	local keymap = lvim.builtin.which_key.mappings
	lvim.keys.normal_mode["ga"] = "<cmd>EasyAlign<CR>"
	lvim.keys.visual_mode["ga"] = "<cmd>EasyAlign<CR>"
	keymap["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
	keymap["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
	keymap["o"] = { name = "+Custom" }
	keymap["ow"] = { "<cmd>setlocal wrap!<cr>", "Toggle Soft Wrap" }

	keymap["os"] = { name = "+Spectre" }
	keymap["oss"] = { "<cmd>lua require('spectre').open()<cr>", "Spectre Open" }
	keymap["osw"] = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Spectre in Visual Word" }
	keymap["osv"] = { "<esc><cmd>lua require('spectre').open_visual()<CR>", "Spectre in Visual" }
	keymap["osf"] = { "viw<cmd>lua require('spectre').open_file_search()<CR>", "Spectre in File" }

	keymap["ot"] = { name = "+Todo" }
	keymap["otq"] = { "<cmd>TodoQuickFix<cr>", "Todo quickfix" }
	keymap["otl"] = { "<cmd>TodoLocList<cr>", "Todo loclist" }
	keymap["ott"] = { "<cmd>TodoTelescope<cr>", "Todo Telescope" }
	keymap["otT"] = { "<cmd>TodoTrouble<cr>", "Todo Trouble" }

	keymap["on"] = { name = "+Notify" }
	keymap["onn"] = { "<cmd>Notifications<cr>", "Show Notifications" }
	keymap["ont"] = { "<cmd>Noice telescope<cr>", "Show Notifications in Telescope" }
	keymap["onm"] = { "<cmd>messages<cr>", "Show Messages" }
	keymap["ond"] = { "<cmd>NoiceDisable<cr>", "Noice Disable" }
	keymap["one"] = { "<cmd>NoiceEnable<cr>", "Noice Enable" }

	keymap["om"] = { name = "+Marks" }
	keymap["oma"] = { "<cmd>MarksListAll<CR>", "Show All Marks" }
	keymap["omb"] = { "<cmd>MarksListBuf<CR>", "Show Marks in Buffer" }
	keymap["omg"] = { "<cmd>MarksListGlobal<CR>", "Show Marks Global" }

	keymap["ol"] = { "<cmd>e<CR>", "Reload File" }
	keymap["oc"] = { "<cmd>pwd<CR>", "Show Current Folder" }
	keymap["oo"] = { "<cmd>SymbolsOutline<cr>", "Toggle Symbols Outline" }
	keymap["oi"] = { "<cmd>LspInstall<cr>", "LspInstall" }

	keymap["oh"] = { name = "+Harpoon" }
	keymap["ohf"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add File" }
	keymap["oht"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle Menu" }
	keymap["ohn"] = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Next" }
	keymap["ohp"] = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Prev" }
	keymap["ohh"] = { "<cmd>Telescope harpoon marks<cr>", "Telescope Harpoon" }
	keymap["ohd"] = { "<cmd>lua require('harpoon.mark').rm_file()<cr>", "Remove File" }

	keymap["m"] = { "<cmd>WindowsMaximize<cr>", "Window Maximize" }

	keymap["z"] = { name = "+Windows" }
	keymap["zm"] = { "<cmd>WindowsMaximize<cr>", "Window Maximize" }
	keymap["zv"] = { "<cmd>WindowsMaximizeVertically<cr>", "Window Vertically Maximize" }
	keymap["zh"] = { "<cmd>WindowsMaximizeHorizontally<cr>", "Window Horizontally Maximize" }
	keymap["ze"] = { "<cmd>WindowsEqualize<cr>", "Window Equalize" }

	keymap["a"] = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" }

	keymap["S"] = { name = "+Session" }
	keymap["Sc"] = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" }
	keymap["Sl"] = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" }
	keymap["SQ"] = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" }

	keymap["t"] = { name = "Diagnostics" }
	keymap["tt"] = { "<cmd>TroubleToggle<cr>", "trouble" }
	keymap["tw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" }
	keymap["td"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" }
	keymap["tq"] = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" }
	keymap["tl"] = { "<cmd>TroubleToggle loclist<cr>", "loclist" }
	keymap["tr"] = { "<cmd>TroubleToggle lsp_references<cr>", "references" }

	-- search.replace.nvim config BEGIN
	keymap["r"] = {
		name = "SearchReplaceSingleBuffer",
		s = { "<CMD>SearchReplaceSingleBufferSelections<CR>", "SearchReplaceSingleBuffer [s]elction list" },
		o = { "<CMD>SearchReplaceSingleBufferOpen<CR>", "[o]pen" },
		w = { "<CMD>SearchReplaceSingleBufferCWord<CR>", "[w]ord" },
		W = { "<CMD>SearchReplaceSingleBufferCWORD<CR>", "[W]ORD" },
		e = { "<CMD>SearchReplaceSingleBufferCExpr<CR>", "[e]xpr" },
		f = { "<CMD>SearchReplaceSingleBufferCFile<CR>", "[f]ile" },
		b = {
			name = "SearchReplaceMultiBuffer",
			s = { "<CMD>SearchReplaceMultiBufferSelections<CR>", "SearchReplaceMultiBuffer [s]elction list" },
			o = { "<CMD>SearchReplaceMultiBufferOpen<CR>", "[o]pen" },
			w = { "<CMD>SearchReplaceMultiBufferCWord<CR>", "[w]ord" },
			W = { "<CMD>SearchReplaceMultiBufferCWORD<CR>", "[W]ORD" },
			e = { "<CMD>SearchReplaceMultiBufferCExpr<CR>", "[e]xpr" },
			f = { "<CMD>SearchReplaceMultiBufferCFile<CR>", "[f]ile" },
		},
	}
	lvim.keys.visual_block_mode["<C-r>"] = [[<CMD>SearchReplaceSingleBufferVisualSelection<CR>]]
	lvim.keys.visual_block_mode["<C-s>"] = [[<CMD>SearchReplaceWithinVisualSelection<CR>]]
	lvim.keys.visual_block_mode["<C-b>"] = [[<CMD>SearchReplaceWithinVisualSelectionCWord<CR>]]
	vim.o.inccommand = "split"
	-- search.replace.nvim config END

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
end
set_keymap()

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

lvim.builtin.treesitter.rainbow.enable = true
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
		event = { "User FileOpened" },
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
		"folke/trouble.nvim",
		enabled = ENABLE_EXT,
		lazy = true,
		cmd = { "TroubleToggle", "Trouble", "TroubleRefresh" },
		config = function()
			require("trouble").setup()
		end,
	},
	{
		"ggandor/leap.nvim",
		lazy = true,
		keys = { "r", "R", "W", "dr", "dR", "yr", "yR", "cr", "cR" },
		config = function()
			require("leap").opts.highlight_unlabeled_phase_one_targets = true
			-- leap.add_default_mappings()
			vim.keymap.set({ "x", "o", "n" }, "r", "<Plug>(leap-forward-to)")
			vim.keymap.set({ "x", "o", "n" }, "R", "<Plug>(leap-backward-to)")
			vim.keymap.set({ "x", "o", "n" }, "W", "<Plug>(leap-from-window)")
		end,
	},
	{
		"ggandor/flit.nvim",
		lazy = true,
		keys = { "f", "F", "t", "T" },
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
        keys = { "E" },
		config = function()
			require("hop").setup({
				-- keys = "etovxqpdygfblzhckisuran",
				-- uppercase_labels = true,
				-- hint_position = require("hop.hint").HintPosition.MIDDLE,
			})
			-- vim.api.nvim_set_keymap("n", "R", "<cmd>HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "E", "<cmd>HopChar1<cr>", { silent = true })
			-- vim.api.nvim_set_keymap("n", "W", "<cmd>HopWord<cr>", { silent = true })
			-- vim.api.nvim_set_keymap("n", "W", "<cmd>HopLine<cr>", { silent = true })
			-- vim.api.nvim_set_keymap("n", "P", "<cmd>HopPattern<cr>", { silent = true })
		end,
	},
	{
		"mrjones2014/nvim-ts-rainbow",
		-- Bracket pair rainbow colorize
		lazy = true,
		event = { "User FileOpened" },
		config = function()
            
		end,
	},
	{
		"romgrk/nvim-treesitter-context",
		-- Show context of code such as function name, class name, labels
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
		"folke/lsp-colors.nvim",
		lazy = true,
		event = { "LspAttach" },
		config = function()
			require("lsp-colors").setup()
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		lazy = true,
		event = { "LspAttach" },
		config = function()
			require("lsp_signature").on_attach()
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		event = { "User FileOpened" },
	},
	{
		"rmagatti/goto-preview",
		enabled = ENABLE_EXT,
		lazy = true,
        keys = { "gp" },
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
		"folke/todo-comments.nvim",
		enabled = ENABLE_EXT,
		-- HACK, NOTE, TODO, WARNING, BUG, FIX, PREF
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("todo-comments").setup()
		end,
	},
	{ -- dot
		"tpope/vim-repeat",
		lazy = true,
		keys = { "." },
	},
	{
		"kylechui/nvim-surround",
		-- ysiw)  ys$" ds]  cs'" dsf
		lazy = true,
		keys = { "c", "d", "y" },
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"windwp/nvim-spectre",
		-- Replace all
		lazy = true,
		cmd = { "Spectre" },
		config = function()
			require("spectre").setup()
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		-- enabled = ENABLE_EXT,
		-- quickfix preview and other functions
		lazy = true,
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
		"andymass/vim-matchup",
		enabled = ENABLE_EXT,
		-- Highlight, jump between pairs like if..else
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
			lvim.builtin.treesitter.matchup.enable = true
		end,
	},
	{
		"folke/persistence.nvim",
		-- Restore last session of current dir
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
		"max397574/better-escape.nvim",
		-- Custom keys to exit normal_mode
		lazy = true,
		event = { "InsertEnter" },
		config = function()
			require("better_escape").setup({
				mapping = { "jk", "jl" },
				timeout = 300,
				clear_empty_lines = false,
				keys = "<Esc>",
			})
		end,
	},
	{
		"abecodes/tabout.nvim",
		-- Use <Tab> jump out of quotes
		lazy = true,
		event = { "InsertEnter" },
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
		"ibhagwan/smartyank.nvim",
		lazy = true,
        keys = { "y", "Y" },
		config = function()
			require("smartyank").setup()
		end,
	},
	{
		"chentoast/marks.nvim",
		-- Marks management
		lazy = true,
        event = { "User FileOpened" },
        -- keys = { "m" },
        -- cmd = { "MarksListAll", "MarksListBuf", "MarksListGlobal" },
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
		enabled = ENABLE_EXT and ENABLE_NOICE,
		lazy = true,
		event = "User FileOpened",
		dependencies = { "rcarriga/nvim-notify", "MunifTanjim/nui.nvim" },
		config = function()
			require("noice").setup({
				lsp = {
                    progress = {
                        enabled = false,
                    },
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					-- override = {
					-- 	["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					-- 	["vim.lsp.util.stylize_markdown"] = true,
					-- 	["cmp.entry.get_documentation"] = true,
					-- },
				},
                -- popupmenu = {
                --     enabled = true,
                -- },
                -- cmdline = {
                --     enabled = true,
                -- },
				presets = {
					bottom_search = false,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = true,
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
		-- enabled = ENABLE_EXT,
		lazy = true,
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			vim.o.foldcolumn = "1" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true


			vim.cmd([[highlight AdCustomFold guifg=#bf8040]])
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

				-- Second line
				local lines = vim.api.nvim_buf_get_lines(0, lnum, lnum + 1, false)
				local secondLine = nil
				if #lines == 1 then
					secondLine = lines[1]
				elseif #lines > 1 then
					secondLine = lines[2]
				end
				if secondLine ~= nil then
					table.insert(newVirtText, { secondLine, "AdCustomFold" })
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
		enabled = ENABLE_EXT,
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
	{
		"ThePrimeagen/harpoon",
		enabled = ENABLE_EXT and ENABLE_HARPOON,
		lazy = true,
		cmd = "Telescope harpoon marks",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("harpoon").setup({
				-- global_settings = {
				--     save_on_toggle = false,
				--     save_on_change = true,
				--     enter_sendcmd = false,
				--     tmux_autoclose_windows = false,
				--     excluded_filetypes = { "harpoon"},
				--     mark_branch = false,
				-- }
			})
			require("telescope").load_extension("harpoon")
		end,
	},
	{
		"winston0410/range-highlight.nvim",
        -- WARN: range-highlight would cause performance issue in cmdline
		enabled = false,
		dependencies = { "winston0410/cmd-parser.nvim" },
		lazy = true,
        keys = { ":" },
		config = function()
			require("range-highlight").setup({})
		end,
	},
	{
		"nacro90/numb.nvim",
        -- WARN: numb.nvim would cause performance issue in cmdline
		enabled = false,
		lazy = true,
        keys = { ":" },
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			})
		end,
	},
	{
		"roobert/search-replace.nvim",
		lazy = true,
        cmd = {
            "SearchReplaceSingleBufferVisualSelection",
            "SearchReplaceWithinVisualSelection",
            "SearchReplaceWithinVisualSelectionCWord",
            "SearchReplaceSingleBufferSelections",
            "SearchReplaceSingleBufferCWord",
            "SearchReplaceSingleBufferCWORD",
            "SearchReplaceSingleBufferCExpr",
            "SearchReplaceSingleBufferCFile",
            "SearchReplaceMultiBufferSelections",
            "SearchReplaceMultiBufferOpen",
            "SearchReplaceMultiBufferCWord",
            "SearchReplaceMultiBufferCWORD",
            "SearchReplaceMultiBufferCExpr",
            "SearchReplaceMultiBufferCFile",
        },
		config = function()
			require("search-replace").setup({
				default_replace_single_buffer_options = "gcI",
				default_replace_multi_buffer_options = "egcI",
			})
		end,
	},
	{
		"LeonHeidelbach/trailblazer.nvim",
		enabled = ENABLE_EXT,
		lazy = true,
        keys = { "<A-s>", "<A-d>" },
		config = function()
			-- local HOME = os.getenv("HOME")
			require("trailblazer").setup({
				auto_save_trailblazer_state_on_exit = false,
				auto_load_trailblazer_state_on_enter = false,
				-- custom_session_storage_dir = HOME .. "/.local/share/trail_blazer_sessions/",
				trail_options = {
					mark_symbol = "•", --  will only be used if trail_mark_symbol_line_indicators_enabled = true
					newest_mark_symbol = "󰝥", -- disable this mark symbol by setting its value to ""
					cursor_mark_symbol = "󰺕", -- disable this mark symbol by setting its value to ""
					next_mark_symbol = "󰬦", -- disable this mark symbol by setting its value to ""
					previous_mark_symbol = "󰬬", -- disable this mark symbol by setting its value to ""
				},
				mappings = {
					nv = {
						motions = {
							new_trail_mark = "<A-s>",
							track_back = "<A-d>",
							peek_move_next_down = "<A-J>",
							peek_move_previous_up = "<A-K>",
							move_to_nearest = "<A-n>",
							toggle_trail_mark_list = "<A-o>",
						},
						actions = {
							delete_all_trail_marks = "<A-L>",
							paste_at_last_trail_mark = "<A-p>",
							paste_at_all_trail_marks = "<A-P>",
							set_trail_mark_select_mode = "<A-t>",
							switch_to_next_trail_mark_stack = "<A-.>",
							switch_to_previous_trail_mark_stack = "<A-,>",
							set_trail_mark_stack_sort_mode = "<A-S>",
						},
					},
				},
				quickfix_mappings = { -- rename this to "force_quickfix_mappings" to completely override default mappings and not merge with them
					-- nv = {
					-- 	motions = {
					-- 		qf_motion_move_trail_mark_stack_cursor = "<CR>",
					-- 	},
					-- 	actions = {
					-- 		qf_action_delete_trail_mark_selection = "d",
					-- 		qf_action_save_visual_selection_start_line = "v",
					-- 	},
					-- 	alt_actions = {
					-- 		qf_action_save_visual_selection_start_line = "V",
					-- 	},
					-- },
					-- v = {
					-- 	actions = {
					-- 		qf_action_move_selected_trail_marks_down = "<C-j>",
					-- 		qf_action_move_selected_trail_marks_up = "<C-k>",
					-- 	},
					-- },
				},
			})
		end,
	},
	{
		"chrisgrieser/nvim-recorder",
		lazy = true,
        keys = { "q", "Q", "<A-q>", "cq", "yq" },
		config = function()
			require("recorder").setup({
				slots = { "u", "i", "o" },
				mapping = {
					startStopRecording = "q",
					playMacro = "Q",
					switchSlot = "<A-q>",
					editMacro = "cq",
					yankMacro = "yq",
					-- addBreakPoint = "##",
				},
				-- clear = false,
				-- logLevel = vim.log.levels.INFO,
				-- dapSharedKeymaps = false,
			})
		end,
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("various-textobjs").setup({
				useDefaultKeymaps = true,
				-- lookForwardLines = 5,
			})
			-- -- example: `?` for diagnostic textobj
			vim.keymap.set({ "o", "x" }, "?", function()
				require("various-textobjs").diagnostic()
			end)

			-- example: `an` for outer subword, `in` for inner subword
			vim.keymap.set({ "o", "x" }, "aS", function()
				require("various-textobjs").subword(false)
			end)
			vim.keymap.set({ "o", "x" }, "iS", function()
				require("various-textobjs").subword(true)
			end)

			-- -- exception: indentation textobj requires two parameters, the first for
			-- -- exclusion of the starting border, the second for the exclusion of ending
			-- -- border
			-- vim.keymap.set({ "o", "x" }, "ii", function()
			-- 	require("various-textobjs").indentation(true, true)
			-- end)
			-- vim.keymap.set({ "o", "x" }, "ai", function()
			-- 	require("various-textobjs").indentation(false, true)
			-- end)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
		event = { "User FileOpened" },
		after = "nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
							["id"] = "@conditional.inner",
							["ad"] = "@conditional.outer",
						},
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						include_surrounding_whitespace = false,
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
							--
							-- You can use regex matching and/or pass a list in a "query" key to group multiple queires.
							["]o"] = "@loop.*",
							-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							--
							-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
						-- Below will go to either the start or the end, whichever is closer.
						-- Use if you want more granular movements
						-- Make it even more gradual by adding multiple queries and regex.
						goto_next = {
							["]d"] = "@conditional.outer",
						},
						goto_previous = {
							["[d"] = "@conditional.outer",
						},
					},
					-- swap = {
					-- 	enable = false,
					-- 	swap_next = {
					-- 		["<leader>a"] = "@parameter.inner",
					-- 	},
					-- 	swap_previous = {
					-- 		["<leader>A"] = "@parameter.inner",
					-- 	},
					-- },
				},
			})
			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

			-- Repeat movement with ; and ,
			-- ensure ; goes forward and , goes backward regardless of the last direction
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

			-- vim way: ; goes to the direction you were moving.
			-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
			-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

			-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
			-- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
			-- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
			-- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
			-- vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
		end,
	},
	{
		"RRethy/nvim-treesitter-textsubjects",
		lazy = true,
		event = { "User FileOpened" },
		after = "nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
				textsubjects = {
					enable = true,
					prev_selection = ",",
					keymaps = {
						["."] = "textsubjects-smart",
						[";"] = "textsubjects-container-outer",
						["i;"] = "textsubjects-container-inner",
					},
				},
			})
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

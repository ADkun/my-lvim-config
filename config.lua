-- vim options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
vim.opt.cursorcolumn = true

-- nightfox dayfox dawnfox duskfox nordfox terafox carbonfox
-- OceanicNext
-- onedark onelight onedark_vivid onedark_dark
-- one_monokai
lvim.colorscheme = "onedark"
local COLOR_TRANS = false

-- general
lvim.log.level = "warn"
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
	{
		command = "beautysh",
		filetypes = { "sh" },
	},
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
	{
		command = "markdownlint",
		filetypes = { "markdown", "md" },
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
	{
		command = "markdownlint",
		filetypes = { "markdown", "md" },
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
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("filetype").setup({
				overrides = {
					extensions = {
						-- Set the filetype of *.pn files to potion
						pn = "potion",
						h = "cpp",
					},
					literal = {
					},
					complex = {
						-- Set the filetype of any full filename matching the regex to gitconfig
						[".*git/config"] = "gitconfig", -- Included in the plugin
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
		lazy = true,
		cmd = { "TroubleToggle", "Trouble", "TroubleRefresh" },
		config = function()
			require("trouble").setup()
		end,
	},
	{
		"ggandor/leap.nvim",
		lazy = true,
		keys = { "E", "R", "W", "dE", "dR", "yE", "yR", "cE", "cR" },
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
		keys = { "f", "F", "t", "T" },
		dependencies = { "ggandor/leap.nvim" },
		config = function()
			require("flit").setup({
				keys = { f = "f", F = "F", t = "t", T = "T" },
				labeled_modes = "v",
				multiline = true,
				opts = {},
			})
		end,
	},
	{
		"phaazon/hop.nvim",
		lazy = true,
		keys = { "r" },
		config = function()
			require("hop").setup({ })
			vim.api.nvim_set_keymap("n", "r", "<cmd>HopChar1<cr>", { silent = true })
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		lazy = true,
		event = { "BufRead" },
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
		"kylechui/nvim-surround",
		-- ysiw)  ys$" ds]  cs'" dsf
		lazy = true,
		keys = { "cs", "ds", "ys" },
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"windwp/nvim-spectre",
		-- Replace all
		lazy = true,
		cmd = "Spectre",
		config = function()
			require("spectre").setup()
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
		event = "InsertEnter",
		config = function()
			require("better_escape").setup({
				mapping = { "jk", "jl" },
				timeout = 200,
				clear_empty_lines = false,
				keys = "<Esc>",
			})
		end,
	},
	{
		"ibhagwan/smartyank.nvim",
		lazy = true,
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("smartyank").setup()
		end,
	},
	{
		"chentoast/marks.nvim",
		-- Marks management
		lazy = true,
		event = { "BufRead", "BufNewFile" },
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
		"cpea2506/one_monokai.nvim",
		lazy = lvim.colorscheme ~= "one_monokai",
		config = function()
			require("one_monokai").setup({
				transparent = COLOR_TRANS,
			})
		end,
	},
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000,
		lazy = lvim.colorscheme ~= "onedark"
			and lvim.colorscheme ~= "onelight"
			and lvim.colorscheme ~= "onedark_vivid"
			and lvim.colorscheme ~= "onedark_dark",
		config = function()
			require("onedarkpro").setup({
                options = {
                    transparency = COLOR_TRANS,
                    cursorline = true,
                }
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		lazy = true,
		-- event = "VeryLazy",
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
		"s1n7ax/nvim-window-picker",
		lazy = true,
		event = "WinNew",
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
		"roobert/search-replace.nvim",
		lazy = true,
		cmd = {
			"SearchReplaceSingleBufferVisualSelection",
			"SearchReplaceSingleBufferOpen",
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
			})
		end,
	},
	{
		"f-person/git-blame.nvim",
		lazy = true,
		cmd = "GitBlameToggle",
		config = function()
			vim.cmd("highlight default link gitblame SpecialComment")
		end,
	},
	{
		"tpope/vim-repeat",
		lazy = true,
		keys = ".",
	},
	{
		"sindrets/diffview.nvim",
		lazy = true,
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
			"DiffviewFileHistory",
		},
		dependencies = { "nvim-lua/plenary.nvim" },
	},
    {
        "junegunn/vim-easy-align",
        lazy = true,
        event = { "BufRead", "BufNewFile" },
        config = function ()
            vim.cmd([[
                xmap ga <Plug>(EasyAlign)
                nmap ga <Plug>(EasyAlign)
            ]])
        end
    },
    {
        "Exafunction/codeium.vim",
        lazy = true,
        event = { "InsertEnter" },
        cmd = { "Codeium" },
        config = function ()
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set('i', '<C-v>', function () return vim.fn['codeium#Accept']() end, { expr = true })
            vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
            vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
            vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
            vim.keymap.set('n', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
            vim.keymap.set('i', '<c-s>', function() return vim.fn['codeium#Complete']() end, { expr = true })
        end
    },
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>

local function set_keymap()
	local keymap = lvim.builtin.which_key.mappings
	local vkeymap = lvim.builtin.which_key.vmappings
	keymap["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
	keymap["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
	keymap["o"] = { name = "+Custom" }
	keymap["ow"] = { "<cmd>setlocal wrap!<cr>", "Toggle Soft Wrap" }

	keymap["os"] = { name = "+Spectre" }
	keymap["oss"] = { "<cmd>lua require('spectre').open()<cr>", "Spectre Open" }
	vkeymap["osw"] = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Spectre in Visual Word" }
	vkeymap["osv"] = { "<esc><cmd>lua require('spectre').open_visual()<CR>", "Spectre in Visual" }
	keymap["osf"] = { "viw<cmd>lua require('spectre').open_file_search()<CR>", "Spectre in File" }

	-- Diagnostic
	keymap["n"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" }
	keymap["v"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" }

	keymap["on"] = { name = "+Notify" }
	keymap["onn"] = { "<cmd>Notifications<cr>", "Show Notifications" }
	keymap["onm"] = { "<cmd>messages<cr>", "Show Messages" }

	keymap["om"] = { name = "+Marks" }
	keymap["oma"] = { "<cmd>MarksListAll<CR>", "Show All Marks" }
	keymap["omb"] = { "<cmd>MarksListBuf<CR>", "Show Marks in Buffer" }
	keymap["omg"] = { "<cmd>MarksListGlobal<CR>", "Show Marks Global" }

	keymap["ol"] = { "<cmd>e<CR>", "Reload File" }
	keymap["of"] = { "<cmd>pwd<CR>", "Show Current Folder" }
	keymap["oo"] = { "<cmd>SymbolsOutline<cr>", "Toggle Symbols Outline" }
	keymap["oi"] = { "<cmd>LspInstall<cr>", "LspInstall" }

    keymap["oc"] = { "<cmd>Codeium Auth<cr>", "Codeium Auth" }

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

	-- diffview
	keymap["od"] = { name = "+Diffview" }
	keymap["odo"] = { "<cmd>DiffviewOpen<cr>", "Open" }
	keymap["odmo"] = { ":DiffviewOpen ", "Open with args" }
	keymap["odc"] = { "<cmd>DiffviewClose<cr>", "Close the current diffview" }
	keymap["odt"] = { "<cmd>DiffviewToggleFiles<cr>", "Toggle the file panel" }
	keymap["odf"] = { "<cmd>DiffviewFocusFiles<cr>", "Focus to the file panel" }
	keymap["odr"] = { "<cmd>DiffviewRefresh<cr>", "Update" }
	keymap["odh"] = { "<cmd>DiffviewFileHistory<cr>", "File history" }
	keymap["odmh"] = { ":DiffviewFileHistory ", "File history with args" }
	vkeymap["ods"] = { ":'<,'>DiffviewFileHistory<cr>", "File history select" }

	keymap["gt"] = { "<cmd>GitBlameToggle<cr>", "Toggle Git Blame" }

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
end
set_keymap()

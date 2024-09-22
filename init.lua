-- vim.opt if for things you would set in vimscript. vim.g is for things you'd let.
vim.g.mapleader = " "
vim.cmd("set hidden")
require("config.lazy")
vim.cmd("colorscheme kanagawa-dragon")

local function mapper(mode, input, exec, opts)
    vim.keymap.set(mode, input, exec, opts)
end

local function nmap(input, exec, opts)
    mapper('n', input, exec, opts)
end

local function vmap(input, exec, opts)
    mapper('v', input, exec, opts)
end

nmap('h', 'h', { noremap = false })
nmap('H', '_', { noremap = false })
nmap('n', 'j', { noremap = false })
nmap('N', '5j', { noremap = false })
nmap('e', 'k', { noremap = true })
nmap('E', '5k', { noremap = true })
nmap('i', 'l', { noremap = true })
nmap('I', '$', { noremap = true })
nmap('k', 'i', { noremap = true })
nmap('l', 'u', { noremap = true })
nmap('L', '<C-r>', { noremap = true })

vmap('n', 'j', { noremap = false })
vmap('N', '3j', { noremap = false })
vmap('e', 'k', { noremap = true })
vmap('E', '3k', { noremap = false })
vmap('i', 'l', { noremap = true })
vmap('I', '$', { noremap = true })

-- coc-clangd
local keyset = vim.keymap.set
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
	vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
	vim.fn.CocActionAsync('doHover')
    else
	vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true, desc = "Rename the file under the cursor"})

keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true, desc = "Move to last diagnostic"})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true, desc = "Move to next diagnostic"})

keyset("n", "gd", "<Plug>(coc-definition)", {silent = true, desc = "Go to definition"})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true, desc = "Go to type definition"})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true, desc = "Go to implementation"})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true, desc = "Go to references"})

-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- telescope.nvim
local builtin = require('telescope.builtin')
require("telescope").load_extension "file_browser"

keyset('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
keyset('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope recent files' })
keyset('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
keyset('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
keyset('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
keyset("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {desc = "Telescope file browser in current folder"})
keyset("n", "<leader>fco", ":Telescope file_browser path='~/.config/nvim/' select_buffer=true<CR>", {desc = "Telescope file browser in config folder"})
keyset("n", "<leader>fcm", ":Telescope cmake_tools<CR>", {desc = "Telescope cmake_tools"})

vim.opt.shiftwidth = 4

-- toggleterm.lua
require("toggleterm").setup{}
keyset('n', '<leader>rh', ":ToggleTerm size=20 direction=horizontal<CR>", { desc = 'Toggle terminal' })
keyset('n', '<leader>rv', ":ToggleTerm size=90 direction=vertical<CR>", { desc = 'Toggle terminal' })

function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Window Commands
keyset('n', '<leader>ws', '<C-w>s', { desc = 'Split window horizontally' })
keyset('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' })
keyset('n', '<leader>wh', '<C-w>h', { desc = 'Move to the left window' })
keyset('n', '<leader>wn', '<C-w>j', { desc = 'Move to lower window'})
keyset('n', '<leader>we', '<C-w>k', { desc = 'Move to upper window' })
keyset('n', '<leader>wi', '<C-w>l', { desc = 'Move to right window' })
keyset('n', '<leader>ww', '<C-w>w', { desc = 'Swap to last used window' })
keyset('n', '<leader>wq', '<C-w>q', { desc = 'Quit the window' })
keyset('n', '<leader>w.', '<C-w>10>', { desc = 'Quit the window' })
keyset('n', '<leader>w,', '<C-w>10<', { desc = 'Quit the window' })
-- Cmake Tools
local osys = require("cmake-tools.osys")
require("cmake-tools").setup {
    cmake_dap_configuration = { -- debug settings for cmake
	name = "c",
	type = "codelldb",
	request = "launch",
	stopOnEntry = false,
	runInTerminal = true,
	console = "integratedTerminal",
    },
    cmake_executor={name="overseer", opts={
	new_task_opts = {
	    strategy = {
		"toggleterm",
		direction = "vertical",
	    }
	},
    }},
    cmake_runner = {
	name = "overseer",
	opts = {
	    new_task_opts = {
		strategy = {
		    "toggleterm",
		    direction = "vertical",
		}
	    },
	}
    }
}

require('overseer').setup()

keyset('n', '<leader>ovr', ":OverseerRun<CR>", { desc = 'Run task under cursor' })
keyset('n', '<leader>cmf', ":CMakeRunCurrentFile<CR>", { desc = 'Run the current file in CMake' })
keyset('n', '<leader>cmr', ":CMakeRun<CR>", { desc = 'Run an executable in CMake' })
keyset('n', '<leader>cmb', ":CMakeBuildCurrentFile<CR>", { desc = 'Build the current file in CMake' })
keyset('n', '<leader>cmd', ":CMakeDebug<CR>", { desc = 'Debug the current file in CMake' })
keyset('n', '<leader>ovt', ":OverseerToggle<CR>", { desc = 'Toggle terminal' })

-- CodeLLDB
local dap = require('dap')
dap.adapters.codelldb = {
    type = 'server',
    port = "13000",
    executable = {
	-- CHANGE THIS to your path!
	command = '/Users/neocodes/codelldb-aarch64-darwin/extension/adapter/codelldb',
	args = {"--port", "13000"},
    }
}

keyset('n', '<leader>dpt', ":DapToggleBreakpoint<CR>", { desc = 'Toggle breakpoint', silent = true })

-- Post Commands
vim.cmd("imap <C-n> <Plug>(coc-snippets-expand-jump)")
vim.cmd("nnoremap <leader>dpe <Cmd>lua require('dapui').eval()<CR>")

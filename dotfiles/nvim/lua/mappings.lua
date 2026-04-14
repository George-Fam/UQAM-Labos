---------------------------------------------------------
-- Base NvChad mappings
------------------------------------------------------------
require "nvchad.mappings"

------------------------------------------------------------
-- Custom Mappings
------------------------------------------------------------

local map = vim.keymap.set

-- Enter command mode quickly
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Exit insert mode quickly
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Save in any mode
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

------------------------------------------------------------
-- Window Navigation (Alt + W / A / S / D)
------------------------------------------------------------
map("n", "<A-a>", "<C-w>h", { desc = "Move to left window" })
map("n", "<A-s>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<A-w>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<A-d>", "<C-w>l", { desc = "Move to right window" })
map("t", "<A-a>", "<cmd>wincmd h<CR>",
    { desc = "Move to left window (terminal)" })
map("t", "<A-s>", "<cmd>wincmd j<CR>",
    { desc = "Move to lower window (terminal)" })
map("t", "<A-w>", "<cmd>wincmd k<CR>",
    { desc = "Move to upper window (terminal)" })
map("t", "<A-d>", "<cmd>wincmd l<CR>",
    { desc = "Move to right window (terminal)" })

------------------------------------------------------------
-- Window Resizing (Alt + Shift + W/A/S/D)
------------------------------------------------------------
map("n", "<A-S-w>", ":resize -2<CR>", { desc = "Resize window up" })
map("n", "<A-S-s>", ":resize +2<CR>", { desc = "Resize window down" })
map("n", "<A-S-d>", ":vertical resize -2<CR>",
    { desc = "Resize window right" })
map("n", "<A-S-a>", ":vertical resize +2<CR>",
    { desc = "Resize window left" })

------------------------------------------------------------
-- Text Editing Enhancements
------------------------------------------------------------
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line(s) down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line(s) up" })
map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlights" })

------------------------------------------------------------
-- Window Management (Splits)
-----------------------------------------------------------
map("n", "<leader>s", "<nop>", { desc = " Window Splits" })
map("n", "<leader>sv", "<C-w>v", { desc = "Vertical split" })
map("n", "<leader>sh", "<C-w>s", { desc = "Horizontal split" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
map("n", "<leader>sx", ":close<CR>", { desc = "Close split" })

------------------------------------------------------------
-- File Explorer and Search (NvimTree / Telescope)
------------------------------------------------------------
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

map("n", "<leader>f", "<nop>", { desc = " Finders" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>",
    { desc = "Find files" })
map("n", "<leader>fa",
    "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
    { desc = "Find all files" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>",
    { desc = "Recent files" })
map("n", "<leader>fc", "<cmd>Telescope colorscheme<CR>",
    { desc = "Color schemes" })

------------------------------------------------------------
-- Search and Replace
------------------------------------------------------------
map("n", "<leader>S", "<nop>", { desc = " Substitution" })
map("n", "<leader>Sr", ":%s///g<Left><Left>", { desc = "Substitute globally" })
map("v", "<leader>Sr", '"sy:%s/<C-r>s//g<Left><Left>',
    { desc = "Substitute selection" })

------------------------------------------------------------
-- LSP (Language Server Protocol)
------------------------------------------------------------
map("n", "<leader>l", "<nop>", { desc = " LSP Actions" })
map("n", "<leader>lD", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>lR", vim.lsp.buf.references, { desc = "List references" })
map("n", "<leader>ld", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
map("v", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>lr", '<cmd>lua require("renamer").rename()<CR>',
    { desc = "NVRename", noremap = true, silent = true })
map("v", "<leader>lr", '<cmd>lua require("renamer").rename()<CR>',
    { desc = "NVRename", noremap = true, silent = true })
map("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end,
    { desc = "Format buffer" })
map("n", "<leader>lI", vim.lsp.buf.implementation,
    { desc = "Go to implementation" })

------------------------------------------------------------
-- Tab and Buffer Shortcuts
------------------------------------------------------------
map("n", "<TAB>", ":bn<CR>", { desc = "Next buffer (tab)" })
map("n", "<S-TAB>", ":bp<CR>", { desc = "Previous buffer (tab)" })
map("n", "<leader>b", "<Nop>",
    { desc = " Buffer Actions", noremap = true, silent = true })
map("n", "<leader>bb", ":enew<CR>",
    { desc = "New buffer", noremap = true, silent = true })
map("n", "<leader>bx", ":bd<CR>",
    { desc = "Close buffer", noremap = true, silent = true })
------------------------------------------------------------
-- Git
------------------------------------------------------------
map("n", "<leader>g", "<nop>", { desc = " Git" })

map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>",
    { desc = "telescope git branches", noremap = true, silent = true })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", {
  desc = "telescope git commits", noremap = true, silent = true })

map("n", "<leader>gs", "<cmd>Telescope git_status<CR>",
    { noremap = true, silent = true ,  desc = "telescope git status" })
map("n", "<leader>gt", "<cmd>Telescope git_stash<CR>",
    { noremap = true, silent = true ,  desc = "telescope git stash" })
map("n", "<leader>gd", "<cmd>Telescope git_diff<CR>",
    { noremap = true, silent = true ,  desc = "telescope diff" })

map("n", "<leader>gp", "<cmd>Git push<CR>",
    { noremap = true, silent = true ,  desc = "telescope git push" })
map("n", "<leader>gP", "<cmd>Git pull<CR>",
    { noremap = true, silent = true ,  desc = "telescope git pull" })
map("n", "<leader>ga", "<cmd>Git add %<CR>",
    { noremap = true, silent = true ,  desc = "telescope git add %" })
map("n", "<leader>gA", "<cmd>Git add .<CR>",
    { noremap = true, silent = true ,  desc = "telescope git add ." })

------------------------------------------------------------
-- Category Labels
------------------------------------------------------------
map("n", "<leader>t", "<nop>", { desc = " NvChad Themes" })
map("n", "<leader>c", "<nop>", { desc = " NvCheatSheet" })
map("n", "<leader>w", "<nop>", { desc = " LSP WorkSpace & Whichkey" })

------------------------------------------------------------
-- Safe LSP-Aware Remaps (fix lazy-load conflicts)
------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local bufnr = event.buf
        vim.defer_fn(function()
        -- vim.keymap.del("n", "<leader>v")
        pcall(vim.keymap.del, "n", "<leader>ds")
        pcall(vim.keymap.del, "n", "<leader>cm")
        pcall(vim.keymap.del, "n", "<leader>ma")
        pcall(vim.keymap.del, "n", "<leader>pt")
        pcall(vim.keymap.del, "n", "<leader>rn")
        pcall(vim.api.nvim_buf_del_keymap, bufnr, "n", "<leader>d")
        pcall(vim.api.nvim_buf_del_keymap, bufnr, "n", "<leader>ra")
        pcall(vim.api.nvim_buf_del_keymap, bufnr, "n", "<leader>ca")
            vim.keymap.set("n", "<leader>sh", "<c-w>s", { buffer = bufnr,
                desc = "horizontal split" })

        end, 100)
    end,
})

local which_key = require("which-key")
local telescope_bi = require('telescope.builtin')

local function find_files_from_current_dir()
    telescope_bi.find_files({ cwd = vim.fn.expand('%:p:h') })
end

local function live_grep_from_current_dir()
    telescope_bi.live_grep({ cwd = vim.fn.expand('%:p:h') })
end

local non_lsp_mappings = {
    ["<leader>"] = {
        e = { vim.cmd.Ex, "Open file explorer" },
        p = { "\"_dP", "Paste without overwrite" },
        ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Toggle comment" },
        s = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and replace word under cursor" },
        ["ff"] = { find_files_from_current_dir, "Telescope Find Files" },
        ["fg"] = { live_grep_from_current_dir, "Telescope Live Grep" },
        ["fF"] = { telescope_bi.find_files, "Telescope Find Files" },
        ["fG"] = { telescope_bi.live_grep, "Telescope Live Grep" },
        t = { ":ToDoTxtCapture<CR>", "New todo" },
        T = { ":ToDoTxtTasksToggle<CR>", "Toggle sidebar" },
    },
    J = { "mzJ`z", "Join lines and keep cursor position" },
    ["<C-d>"] = { "<C-d>zz", "Half page down and center" },
    ["<C-u>"] = { "<C-u>zz", "Half page up and center" },
    n = { "nzzzv", "Next search result and center" },
    N = { "Nzzzv", "Previous search result and center" },
    Q = { "<nop>", "Disable Ex mode" },
}

which_key.register(non_lsp_mappings)

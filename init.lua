vim.g.mapleader = " " -- Set leader key before Lazy

require("jacob.lazy_init")
require("jacob.remap")
require("jacob.set")

vim.lsp.config("roslyn", {
    on_attach = function(_, bufnr)
        local which_key = require("which-key")

        local non_lsp_mappings = {
            ["<leader>"] = {
                h = { function ()
                    local opts = {noremap = true, silent = true}
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>h',
                        '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
                end, "See squiggle" },
            },
        }

        which_key.register(non_lsp_mappings)
    end,
    settings = {
        ["csharp|completion"] = {
            dotnet_show_name_completion_suggestions = true,
        },
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
        },
    },
})
vim.lsp.inlay_hint.enable()


-- Helper to close all other windows
local function close_all_windows_except_main()
    local main_win = vim.api.nvim_get_current_win()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if win ~= main_win then
            vim.api.nvim_win_close(win, true)
        end
    end
end

-- Layout 2x2 grid
function SetupGrid2x2()
    local win_count = #vim.api.nvim_list_wins()
    if win_count == 6 then
        local current_win = vim.api.nvim_get_current_win()

        vim.cmd('wincmd l')
        vim.cmd('wincmd l')
        vim.cmd('wincmd k')

        vim.cmd('quit')
        vim.cmd('wincmd j')
        vim.cmd('quit')

        vim.api.nvim_set_current_win(current_win)
    else
        close_all_windows_except_main()
        vim.cmd('vsplit')
        vim.cmd('split')
        vim.cmd('wincmd l')
        vim.cmd('split')
        vim.cmd('wincmd h')
    end
    -- Now 2x2 grid is set
end

-- Layout 3x2 grid
function SetupGrid3x2()
    local win_count = #vim.api.nvim_list_wins()
    if win_count == 4 then
        local current_win = vim.api.nvim_get_current_win()

        vim.cmd('wincmd l')
        vim.cmd('wincmd k')

        vim.cmd('vsplit')
        vim.cmd('wincmd j')
        vim.cmd('vsplit')

        vim.api.nvim_set_current_win(current_win)
    else
        SetupGrid2x2()
        vim.cmd('wincmd l')
        vim.cmd('vsplit')
        vim.cmd('wincmd j')
        vim.cmd('vsplit')
        vim.cmd('wincmd h')
        vim.cmd('wincmd k')
        -- Now 3x2 grid is set
    end
end

vim.api.nvim_create_user_command('To22Grid', SetupGrid2x2, {})
vim.api.nvim_create_user_command('To32Grid', SetupGrid3x2, {})

-- Optional: Auto start in 2x2
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.schedule(SetupGrid2x2)
    end,
})

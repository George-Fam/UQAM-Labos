require "nvchad.options"

-- add yours here!
    local o = vim.opt
    o.tabstop = 4
    o.shiftwidth = 4
    o.smarttab = true
    o.expandtab = true
    o.smartindent = true
    o.relativenumber = true
    vim.g.riscv_asm_all_enable = true
-- o.cursorlineopt ='both' -- to enable cursorline!
    o.list = true
    o.listchars = {
        tab = '>.',     -- show tab as ">."
        trail = '.',    -- show trailing spaces as "."
        space = '.',    -- show spaces as "."
    }
    o.colorcolumn = "80"


return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = {
            format_on_save = function()
                return {
                    timeout_ms = 1000,
                    lsp_fallback = false,
                }
            end,

            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
                h = { "clang_format" },
                hpp = { "clang_format" },
                java = { "clang-format" },
                sh = { "beautysh" },
                bash = { "beautysh" },
                html = { "prettierd" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                markdown = { "prettierd" },
                python = { "isort", "black" },
                ps1 = { "psscriptanalyzer" },
                ocaml = { "ocamlformat" },
                lua = { "stylua" },
                json = { "prettierd" },
            },

            formatters = {
                clang_format = {
                    command = "clang-format",
                },
                psscriptanalyzer = {
                    command = "pwsh",
                    stdin = true,
                    args = {
                        "-NoLogo",
                        "-NoProfile",
                        "-Command",
                        [[
                        Import-Module PSScriptAnalyzer

                        $settings = @{
                            Rules = @{
                                PSUseConsistentIndentation = @{
                                    Enable = $true
                                    IndentationSize = 4
                                    PipelineIndentation = 'IncreaseIndentationForFirstPipeline'
                                    Kind = 'space'
                                }
                                PSUseConsistentWhitespace = @{
                                    Enable = $true
                                }
                                PSPlaceOpenBrace = @{
                                    Enable = $true
                                    PlaceOpenBraceOnSameLine = $true
                                }
                            }
                        }

                        $formatted = Invoke-Formatter `
                            -ScriptDefinition ([Console]::In.ReadToEnd()) `
                            -Settings $settings

                        # Remove trailing newline added by Invoke-Formatter
                        $formatted.TrimEnd("`r", "`n")
                        ]],
                    },
                },
                ocamlformat = {
                    command = "ocamlformat",
                    args = {
                        "--enable-outside-detected-project",
                        "-i",
                        "$FILENAME",
                    },
                    stdin = false,
                },
                stylua = {
                    command = "stylua",
                    args = {
                        "--indent-type",
                        "Spaces",
                        "--indent-width",
                        "4",
                        "--stdin-filepath",
                        "$FILENAME",
                        "-",
                    },
                    stdin = true,
                },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "henry-hsieh/riscv-asm-vim",
        ft = { "riscv_asm" },
    },
    {
        "goldos24/rainbow-variables-nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        lazy = false,
        config = function()
            require("rainbow-variables-nvim").start_with_config {
                reduce_color_collisions = true,
                semantic_background_colors = false,
                palette = {
                    "#cca650",
                    "#50a6fe",
                    "#ffa6fe",
                    "#ffc66b",
                    "#c600ff",
                    "#aaffaa",
                    "#bbbbbb",
                    "#009900",
                    "#995500",
                    "#009977",
                    "#bbbb00",
                    "#66ffff",
                    "#ff9999",
                    "#ffff66",
                    --'#3355aa','#00ff44',
                },
            }
        end,
    },
    {
        "jemag/telescope-diff.nvim",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
        },
    },
    {
        "godlygeek/tabular",
        cmd = { "Tabularize" },
    },
    {
        "pocco81/high-str.nvim",
        keys = {
            {
                "<F3>",
                ":<C-u>HSHighlight 1<CR>",
                mode = "v",
                noremap = true,
                silent = true,
                desc = "Highlight text",
            },
            {
                "<F4>",
                ":<C-u>HSRmHighlight<CR>",
                mode = "v",
                noremap = true,
                silent = true,
                desc = "Remove highlight",
            },
        },
        config = function()
            require("high-str").setup()
        end,
    },
    {
        "lervag/vimtex",
        ft = "tex",
        init = function()
            vim.g.vimtex_view_method = "zathura" -- or "sioyek", "skim", "sumatrapdf"
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    --{
    --  "m-demare/hlargs.nvim",
    --  event = "BufReadPost",
    --  dependencies = { "nvim-treesitter/nvim-treesitter" },
    --  config = function()
    --    require("hlargs").setup {
    --      color = "#E0AF68", -- optional base color
    --    }
    --
    --    -- Re-attach Treesitter for hlargs after Treesitter loads
    --    vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "InsertLeave" }, {
    --      callback = function()
    --        require("hlargs").enable()
    --      end,
    --    })
    --  end,
    --},

    -- {
    -- 	"nvim-treesitter/nvim-treesitter",
    -- 	opts = {
    -- 		ensure_installed = {
    -- 			"vim", "lua", "vimdoc",
    --      "html", "css"
    -- 		},
    -- 	},
    -- },
}

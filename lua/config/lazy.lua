local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
vim.g.python3_host_prog = "~/.virtualenvs/Pyenvmain/bin/python"

require("lazy").setup({
    spec = {
        -- add LazyVim and import its plugins

        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        { import = "lazyvim.plugins.extras.ui.mini-animate" },
        -- import/override with your plugins
        { import = "plugins" },

        {
            "catppuccin/nvim",
            name = "catppuccin",
            lazy = false, -- Ensure it loads at startup
            priority = 1000, -- Load before other plugins
            config = function()
                require("catppuccin").setup({
                    flavour = "mocha", -- Choose from: latte, frappe, macchiato, mocha
                    transparent_background = true, -- Set to true for transparency
                    term_colors = true, -- Enable terminal colors
                    integrations = {
                        cmp = true, -- Enable nvim-cmp integration
                        treesitter = true, -- Enable Treesitter integration
                        telescope = true, -- Enable Telescope integration
                        native_lsp = {
                            enabled = true, -- Enable LSP integration
                            virtual_text = {
                                errors = { "italic" }, -- Italicize LSP errors
                                hints = { "italic" }, -- Italicize LSP hints
                                warnings = { "italic" }, -- Italicize LSP warnings
                                information = { "italic" }, -- Italicize LSP info
                            },
                        },
                    },
                })
            end,
        },
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = { colorscheme = { "catppuccin" } },
    checker = {
        enabled = true, -- check for plugin updates periodically
        notify = false, -- notify on update
    }, -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

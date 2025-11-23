return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",

    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            version = "^1.0.0",
        },
    },

    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        telescope.setup({})
        telescope.load_extension("live_grep_args")

        -- Normal keymaps
        vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
        vim.keymap.set("n", "<C-p>", builtin.git_files, {})

        vim.keymap.set(
            "n",
            "<leader>ps",
            telescope.extensions.live_grep_args.live_grep_args,
            {}
        )

        vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
    end,
}


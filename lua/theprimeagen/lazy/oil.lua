return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    default_file_explorer = true,
    -- Columns to display in the file list
    columns = {
      "icon",
    },
    -- Skip the confirmation popup for simple operations
    skip_confirm_for_simple_edits = true,
    -- Set to true to watch the filesystem for changes and reload oil
    watch_for_changes = true,
  },
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}

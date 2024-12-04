-- return {
--   "3fonov/dbt-nvim",
--   config = function()
--     -- DBT
--     -- vim.keymap.set('n', '<leader>dc', ':DbtCompile<CR>', { noremap = true, silent = true })
--     -- vim.keymap.set('n', '<leader>dy', ':DbtModelYaml<CR>', { noremap = true, silent = true })
--     -- vim.keymap.set('n', '<leader>dr', ':DbtRun<CR>', { noremap = true, silent = true })
--     -- vim.keymap.set('n', '<leader>df', ':DbtRunFull<CR>', { noremap = true, silent = true })
--     -- vim.keymap.set('n', '<leader>dt', ':DbtTest<CR>', { noremap = true, silent = true })
--     -- vim.keymap.set("n", "<leader>fd+", require("dbt-nvim").list_downstream_models, { noremap = true, silent = true })
--     -- vim.keymap.set("n", "<leader>fd-", require("dbt-nvim").list_upstream_models, { noremap = true, silent = true })
--     vim.keymap.set("n", "<leader>fd-", ":DbtListDownstreamModels<CR>", { noremap = true, silent = true })
--   end,
-- }
return {
  "PedramNavid/dbtpal",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  ft = { "sql", "md", "yaml" },
  keys = {
    -- { "<leader>drf", "<cmd>DbtRun<cr>" },
    -- { "<leader>drp", "<cmd>DbtRunAll<cr>" },
    -- { "<leader>dtf", "<cmd>DbtTest<cr>" },
    { "<leader>fdm", "<cmd>lua require('dbtpal.telescope').dbt_picker()<cr>" },
    { "<leader>fd-", "<cmd>lua require('dbtpal.telescope').dbt_picker_upstream()<cr>" },
    { "<leader>fd+", "<cmd>lua require('dbtpal.telescope').dbt_picker_downstream()<cr>" },
  },
  config = function()
    require("dbtpal").setup({
      path_to_dbt = "dbt",
      -- path_to_dbt_project = "./udisc_dbt/",
      path_to_dbt_profiles_dir = vim.fn.expand("~/.dbt"),
      extended_path_search = true,
      protect_compiled_files = true,
    })
    require("telescope").load_extension("dbtpal")
  end,
}

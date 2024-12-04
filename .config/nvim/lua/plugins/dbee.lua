-- return {}
return {
  "kndndrj/nvim-dbee",
  -- ft = "sql",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    require("dbee").install()
  end,
  config = function()
    -- require("dbee").setup({})
    require("dbee").setup({
      sources = {
        require("dbee.sources").MemorySource:new({
          {
            id = "duck-in-memory",
            name = "duck-in-memory",
            type = "duck",
            url = "",
          },
        }),
      },
    })
  end,
}
-- return {
--   "kndndrj/nvim-dbee",
--   dependencies = {
--     "MunifTanjim/nui.nvim",
--   },
--   build = function()
--     -- Install tries to automatically detect the install method.
--     -- if it fails, try calling it with one of these parameters:
--     --    "curl", "wget", "bitsadmin", "go"
--     require("dbee").install()
--   end,
--   config = function()
--     require("dbee").setup({
--       sources = {
--         require("dbee.sources").MemorySource:new({
--           {
--             id = "duckeee", -- only mandatory if you edit a file by hand. IT'S YOUR JOB TO KEEP THESE UNIQUE!
--             name = "Local Duck",
--             type = "duck", -- type of database driver
--             url = "",
--           },
--           -- ...
--         }),
--         -- require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
--         -- require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
--       },
--       -- ...
--     })
--   end,
-- }

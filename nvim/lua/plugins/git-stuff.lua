return {
  "tpope/vim-fugitive",
  lazy = false,

  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- Dependency for Telescope
  },
  config = function()
    local builtin = require("telescope.builtin")

    -- Git pickers with Telescope
    vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git Status" })       -- Show changed files
    vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git Commits" })     -- Show commit history
    vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git Branches" })   -- Show branches
    vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Git Files" })         -- Show tracked files
    vim.keymap.set("n", "<leader>gB", builtin.git_bcommits, { desc = "Buffer Commits" }) -- Show commits for current file

    -- Preview Git Diff with Fugitive
    vim.keymap.set("n", "<leader>gd", function()
      vim.cmd("Gvdiffsplit") -- Opens diff view with Fugitive
    end, { desc = "Git Diff" })

    -- Open Fugitive with Telescope Picker
    vim.keymap.set("n", "<leader>gS", function()
      vim.cmd("Telescope git_status")
      vim.cmd("G") -- Open Fugitive after selecting a file
    end, { desc = "Git Status with Fugitive" })

    -- Open Fugitive Blame in Preview
    vim.keymap.set("n", "<leader>gb", function()
      vim.cmd("G blame") -- Opens inline Git blame
    end, { desc = "Git Blame" })

    --Open Telescope on Fugitive Buffer
    vim.keymap.set("n", "<leader>tf", function()
      builtin.current_buffer_fuzzy_find()
    end, { desc = "Search in Git Buffer" })
  end
}

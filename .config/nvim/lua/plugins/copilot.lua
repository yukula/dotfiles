return {
  ---  { "gptlang/CopilotChat.nvim" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    cond = function()
      return not vim.fn.has("wsl")
    end,
    config = function()
      require("copilot").setup({
        -- disable suggestions; copilot used by `cmp`
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
}

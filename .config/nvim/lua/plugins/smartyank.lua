return {
    "ibhagwan/smartyank.nvim",
    lazy = false,
    config = function()
        require("smartyank").setup({
            highlight = { timeout = 100 },
            osc52 = {
                silent = true
            }
        })
    end
}

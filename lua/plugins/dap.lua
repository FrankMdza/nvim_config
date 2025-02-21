return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap_python = require("dap-python")
    dap_python.setup("~/.virtualenvs/Pyenvmain/bin/python3") -- Change to your Python path if needed

    vim.keymap.set("n", "<leader>db", function()
      require("dap").toggle_breakpoint()
    end, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dc", function()
      require("dap").continue()
    end, { desc = "Continue Debugging" })
  end,
}

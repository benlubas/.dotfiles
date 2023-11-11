local function keys(str)
  return function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", true)
  end
end
return {
  -- "quarto-dev/quarto-nvim",
  "benlubas/quarto-nvim",
  dev = true,
  dependencies = {
    "jmbuhr/otter.nvim",
    "benlubas/nvim-cmp",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "benlubas/hydra.nvim",
  },
  ft = { "quarto", "markdown" },
  config = function()
    local quarto = require("quarto")
    quarto.setup({
      keymap = {
        hover = "H",
        definition = "gd",
        rename = "<leader>rn",
        references = "gr",
      },
      codeRunner = {
        enabled = true,
        ft_runners = {
          bash = "slime",
        },
        default_method = "molten",
      },
    })

    vim.keymap.set("n", "<localleader>qp", quarto.quartoPreview, { desc = "Preview the Quarto document", silent = true, noremap = true })
    -- to create a cell in insert mode, I have the ` snippet
    vim.keymap.set("n", "<localleader>cc", "i```{}\r```<up><right>", { desc = "Create a new code cell", silent = true })
    vim.keymap.set("n", "<localleader>cs", "i```\r\r```{}<left>", { desc = "Split code cell", silent = true, noremap = true })

    -- for more keybinds that I would use in a quarto document, see the configuration for molten

    -- hydra
    local hydra = require("hydra")
    hydra({
      name = "QuartoNavigator",
      hint = [[
      _j_/_k_: move down/up _o_/_O_: add cell after/before
      _r_: run cell  _l_: run line  _R_: run above
      ^^                _<esc>_/_q_: exit ]],
      config = {
        color = "pink",
        invoke_on_body = true,
        hint = {
          border = "rounded",
        },
      },
      mode = { "n" },
      body = "<localleader>j",
      heads = {
        { "j", keys("]b"), { remap = true, noremap = false } },
        { "k", keys("[b"), { remap = true, noremap = false } },
        { "o", keys("/```<CR><leader><leader>fo<CR>`<c-j>"), { exit = true } },
        { "O", keys("?```{<CR><leader><leader>f<leader>kO<CR>`<c-j>"), { exit = true } },
        { "r", ":QuartoSend<CR>" },
        { "l", ":QuartoSendLine<CR>" },
        { "R", ":QuartoSendAbove<CR>" },
        { "<esc>", nil, { exit = true } },
        { "q", nil, { exit = true } },
      },
    })
  end,
}

return {
  "mbbill/undotree",
  event = "BufRead",
  config = function()
    vim.keymap.set('n', 'su', vim.cmd.UndotreeToggle)
  end
}

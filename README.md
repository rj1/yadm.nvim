# yadm.nvim

This neovim plugin allows you to manage your
[yadm](https://github.com/TheLocehiliosan/yadm) dotfiles repo with
[fugitive.vim](https://github.com/tpope/vim-fugitive) in neovim as if it were
any other repository.

## default/example configuration

```lua
require("yadm").setup({
    yadm_dir = vim.fn.expand("$XDG_DATA_HOME/yadm/repo.git"),
})
```

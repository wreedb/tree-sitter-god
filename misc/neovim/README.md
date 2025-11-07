<!--
SPDX-FileCopyrightText: 2025 2025 Will Reed <wreed@disroot.org>

SPDX-License-Identifier: LGPL-3.0-or-later
-->

Neovim setup
============

Requires [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter), and it must be the `main` branch; see their 
[README](https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md) for information about what is different, as the master branch is deprecated, but still the default.

---
You will want to add the following to your neovim configuration, such as `~/.config/nvim/init.lua`.
Additionally, this must be placed ***after*** you have called `nvim-treesitter`'s `setup()` function.

```lua
local rev = "<git tag revision>"
vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
        require "nvim.treesitter.parsers".god = {
            install_info = {
                url = "https://github.com/wreedb/tree-sitter-god",
                revision = rev,
                branch = "main",
                queries = "queries"
            }
        }
    end
})
```

To obtain the revision hash by going to the main repository page, selecting 
a tag (recommended: the most recent tag), then clicking on the button 
displaying the number of commits, which is just above the file listing, and 
finally, use the copy-symbol button on the top commit to copy the revision to 
your clipboard.


Next, you will want to make an `ftplugin` file, and place it in your neovim 
configuration directory, in a subdirectory called `ftplugin`:
```lua
-- ~/.config/nvim/ftplugin/god.lua
vim.treesitter.start()
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
```

Then, to associate the `.god` file extension, place the following in your 
neovim configuration (it doesn't particularly matter where you put this, 
as long as it loads):
```lua
vim.filetype.add {
    extension = {
        god = "god"
    }
}
```

On the off-chance that it didn't automatically install the grammar, use 
command mode to enter:
```
:TSUpdate god
```

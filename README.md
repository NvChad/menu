# Menu (WIP)
Menu ui for neovim ( supports nested menus ) 

## Install

```lua
{ "nvchad/volt" , lazy = true },
{ "nvchad/menu" , lazy = true },
```

## Usage
- options is a table or string, if string then it will look at the table from menus* module of this repo
```lua
require("menu").open(options, opts) 
```
- opts : { mouse = true, border = false }

### Examples
```lua
-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open("default")
end, {})

-- mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})
```

Check example of [defaults menu](https://github.com/NvChad/menu/blob/main/lua/menus/default.lua)

## Screenshots

![image](https://github.com/user-attachments/assets/c8402279-b86d-432f-ad11-14a76c887ab1)
![image](https://github.com/user-attachments/assets/d70430e1-74d2-40dd-ba60-0b8919d53af6)

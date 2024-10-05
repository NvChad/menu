# Menu
Menu ui for neovim ( supports nested menus ) 

![image](https://github.com/user-attachments/assets/c8402279-b86d-432f-ad11-14a76c887ab1)
![image](https://github.com/user-attachments/assets/6da0b1a6-54c5-4ecc-ab06-fce1f17595ac)
![image](https://github.com/user-attachments/assets/d70430e1-74d2-40dd-ba60-0b8919d53af6)

https://github.com/user-attachments/assets/89d96170-e039-4d3d-9640-0fdc3358a833

## Install

```lua
{ "nvchad/volt" , lazy = true },
{ "nvchad/menu" , lazy = true },
```

## Usage
```lua
require("menu").open(options, opts) 
```
- options is a table or string, if string then it will look at the table from menus* module of this repo
- opts : { mouse = true, border = false }

### Examples

- Keyboard users can run the mapping when inside the menu, mouse users can click.
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

Check example of [defaults menu](https://github.com/NvChad/menu/blob/main/lua/menus/default.lua) to see know syntax of options table.

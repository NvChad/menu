# Menu
Menu ui for neovim ( supports nested menus ) 

![image](https://github.com/user-attachments/assets/c8402279-b86d-432f-ad11-14a76c887ab1)
![image](https://github.com/user-attachments/assets/6da0b1a6-54c5-4ecc-ab06-fce1f17595ac)
![image](https://github.com/user-attachments/assets/d70430e1-74d2-40dd-ba60-0b8919d53af6)

https://github.com/user-attachments/assets/89d96170-e039-4d3d-9640-0fdc3358a833

## Install

```lua
{ "nvzone/volt" , lazy = true },
{ "nvzone/menu" , lazy = true },
```

## Usage
```lua
require("menu").open(options, opts) 
```
- options is a table or string, if string then it will look at the table from menus* module of this repo
- opts : { mouse = true, border = false }"

### For keyboard users
- Use `h` `l` to move between windows 
- Use `q` to close the window
- Press the keybind defined for menu item or scroll to it and press enter, to execute it

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

## :gift_heart: Support

If you like NvChad or its plugins and would like to support it via donation

[![kofi](https://img.shields.io/badge/Ko--fi-F16061?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ko-fi.com/siduck)
[![paypal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://paypal.me/siduck13)
[![buymeacoffee](https://img.shields.io/badge/Buy_Me_A_Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://www.buymeacoffee.com/siduck)
[![patreon](https://img.shields.io/badge/Patreon-F96854?style=for-the-badge&logo=patreon&logoColor=white)](https://www.patreon.com/siduck)

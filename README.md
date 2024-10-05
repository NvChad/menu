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

### Why?

I know a lot of you all would be infuriated by this plugin. here are some reasons for me to use it:

- There are times when i'd want to perform some action but i dont want to set command/mapping for it, like one of those gitsigns commands, they're very useful and so many commands but i rarely use them. So a menu option with quick mouse click 
or menu opened from keybind would suffice!

- I already got so many keybinds, I dont want to add more if I dont use it too frequently so I could use this menu!

- I use my pc for more than 10 hours a day ( including, for the remote job I got ) and my keyboard usage is very high cuz of Vim so at times my fingers hurt and using mouse would tone it down.

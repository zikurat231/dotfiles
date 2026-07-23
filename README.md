# dotfiles

🛠️ My personal development environment configurations.

## What's inside

- 🐚 `zsh` — shell and Oh My Zsh
- ✏️ `nvim` — Neovim
- 🖥️ `tmux` — terminal multiplexer
- 🐱 `kitty` — terminal emulator
- ⌨️ `kanata` — keyboard layers
- 🪟 `omarchy` — keybindings and input settings

## Installation

Review the configs first, then create symbolic links to the required files in
your home directory. For example:

```sh
ln -s "$(pwd)/tmux/tmux.conf" ~/.tmux.conf
ln -s "$(pwd)/nvim/init.lua" ~/.config/nvim/init.lua
```

> ⚠️ Some settings depend on locally installed apps, fonts, and tools.

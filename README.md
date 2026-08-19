# dotfiles

🛠️ My personal development environment configurations.

## What's inside

- 🐚 `zsh` — shell and Oh My Zsh
- ✏️ `nvim` — Neovim
- 🖥️ `tmux` — terminal multiplexer
- 🐱 `kitty` — terminal emulator
- ⌨️ `neru` — keyboard-driven mouse navigation
- ⌨️ `kanata` — keyboard layers
- 🪟 `omarchy` — keybindings and input settings

## How it works

This repository is structured for use with
[GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a
separate Stow package, and its contents mirror the target path relative to
`$HOME`.

For example, the file:

```text
nvim/.config/nvim/init.lua
```

is linked to:

```text
~/.config/nvim/init.lua
```

This makes it possible to install, update, or remove each group of configuration
files independently.

## Installation

Install [GNU Stow](https://www.gnu.org/software/stow/).

On macOS:

```sh
brew install stow
```

On Debian or Ubuntu:

```sh
sudo apt-get update
sudo apt-get install stow
```

Clone the repository and enter its directory:

```sh
git clone <repository-url> ~/dotfiles
cd ~/dotfiles
```

Create symlinks for the packages you want to use:

```sh
stow --target="$HOME" nvim kitty neru tmux zsh
```

Linux-specific packages can be linked in the same way:

```sh
stow --target="$HOME" kanata omarchy
```

Stow will stop if a target file already exists. Move or back up the existing
file first, then run the command again.

To update existing symlinks after changing the package layout:

```sh
stow --restow --target="$HOME" nvim kitty neru tmux zsh
```

To remove symlinks created for a package:

```sh
stow --delete --target="$HOME" nvim
```

## Neru

The Neru config uses `F18` for recursive grid, `F19` for hints with a pending
left click, and `F20` for scroll mode. `Cmd+Shift+G` opens the regular grid.

Validate and apply config changes with:

```sh
neru config validate
neru config reload
```

On the first launch, grant Neru the macOS permissions it requests. See the
[Neru documentation](https://github.com/y3owk1n/neru) for other installation
methods and platform-specific setup.

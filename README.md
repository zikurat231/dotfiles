# dotfiles

🛠️ My personal development environment configurations.

## What's inside

- 🐚 `zsh` — shell and Oh My Zsh
- ✏️ `nvim` — Neovim
- 🖥️ `tmux` — terminal multiplexer
- 🐱 `kitty` — terminal emulator
- ⌨️ `neru` — keyboard-driven mouse navigation
- ⌨️ `kanata` — keyboard layers
- ⌨️ `karabiner` — keyboard customization on macOS
- 🖱️ `linearmouse` — shared mouse behavior on macOS
- 🪟 `omarchy` — keybindings and input settings

## How it works

This repository is structured for use with
[GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a
separate Stow package. Packages containing application configs mirror
`~/.config`; packages containing home-directory dotfiles mirror `$HOME`.

For example, the file:

```text
nvim/nvim/init.lua
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

Create `~/.config`, then link application configs with `~/.config` as the Stow
target:

```sh
mkdir -p ~/.config
stow --target ~/.config nvim kitty neru karabiner linearmouse
```

Linux-specific application configs use the same target:

```sh
stow --target ~/.config kanata omarchy
```

Link dotfiles that belong directly in the home directory separately:

```sh
stow --target "$HOME" tmux zsh powerlevel10k
```

Stow will stop if a target file already exists. Move or back up the existing
file first, then run the command again.

To update existing symlinks after changing the package layout:

```sh
stow --restow --target ~/.config nvim kitty neru karabiner linearmouse
stow --restow --target "$HOME" tmux zsh powerlevel10k
```

To remove symlinks created for a package:

```sh
stow --delete --target ~/.config nvim
```

## Neovim setup on macOS

The configuration requires Neovim 0.12 or newer. The primary setup targets C++.
Install the editor, search tools, Clang tooling, and Tree-sitter build
requirements before the first launch:

```sh
xcode-select --install

brew install \
  neovim ripgrep tree-sitter-cli \
  llvm

brew install --cask font-meslo-lg-nerd-font
```

Homebrew installs LLVM as a keg-only package. Make its commands available in
the shell environment:

```sh
export PATH="$(brew --prefix llvm)/bin:$PATH"
```

Install other language servers and formatters only on machines that need them.
For Go:

```sh
brew install go
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
```

For Python:

```sh
brew install basedpyright ruff
```

For Protocol Buffers:

```sh
brew install rust protobuf pkgconf
cargo install protols
export PATH="$HOME/.cargo/bin:$PATH"
```

Optional formatters for shell scripts and Lua can be installed separately:

```sh
brew install shfmt stylua
```

Verify that the tools used by the configuration are available:

```sh
nvim --version
command -v rg tree-sitter clangd clang-format
```

For each optional language installed on the current machine, also verify its
tools, for example with `command -v gopls`,
`command -v basedpyright-langserver`, or `command -v protols`.

The tracked `nvim-pack-lock.json` keeps plugin revisions identical between
machines. On the first launch, `vim.pack` installs those revisions and
`nvim-treesitter` installs the configured language parsers. Clangd is always
enabled; Go, Python, and Protocol Buffers language servers are enabled only
when their executables are available on `PATH`.

## macOS input-source shortcut

The tmux prefix is `Control+Space`. On every new Mac, open:

```text
System Settings > Keyboard > Keyboard Shortcuts > Input Sources
```

Disable **Select the previous input source** (`Control+Space`) to keep that
shortcut available to tmux.

The same setting can be applied from the terminal using macOS symbolic-hotkey
ID `60`:

```sh
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 \
  '{ enabled = 0; value = { parameters = (32, 49, 262144); type = standard; }; }'
```

Log out and back in, or restart macOS, after applying the terminal version.
This numeric ID is an internal macOS representation, so the GUI method is
preferable if a future macOS release changes its behaviour.

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

## LinearMouse

The LinearMouse config applies the same pointer and scrolling behavior to every
device in the `mouse` category, while leaving trackpads unaffected.

Install the package on macOS with:

```sh
stow --target ~/.config linearmouse
```

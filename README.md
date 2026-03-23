# 🏠 dotfiles

> Fast, minimal, framework-free macOS development environment.
>
> **42ms** first prompt · **0.03s** shell startup · zero frameworks · one command bootstrap

<br>

## ✨ What's Inside

### Zsh — Custom prompt, no frameworks

A hand-built zsh config that's faster than bare zsh with no plugins. No oh-my-zsh, no starship, no powerlevel10k — just ~250 lines of optimized zsh.

**Prompt features:**
- 🔀 Async git status via [gitstatus](https://github.com/romkatv/gitstatus) — branch, staged, modified, untracked, ahead/behind, conflicts
- 🎯 Project detection — Nerd Font icons for 40+ project types (Svelte, Next.js, Rust, Go, Python, Docker, Terraform...)
- ⏱️ Command timer — shows elapsed time for commands over 3 seconds
- 📁 Context-aware directory icons — home, temp workspace, or folder
- 🐍 Python venv indicator
- 🔒 SSH awareness
- 📋 Background jobs counter
- ❌ Exit code display

**Shell features:**
- 🔤 Fuzzy command-not-found — swap detection (`gti` → `git`), fzf fuzzy fallback, install hints
- ⌨️ Ctrl+F fix — re-runs last mistyped command with correction
- 🗂️ `tmp` workspace system — throwaway directories with fzf picker, auto-cleaned on reboot
- 🍺 Auto Brewfile sync — `brew install` automatically updates the Brewfile
- 📌 Directory bookmarks — `~code`, `~dots`, `~dl`, `~tmp`
- 🔢 Directory stack — `d` to view, `1`-`9` to jump
- 🛡️ Safety — `NO_CLOBBER`, `NO_RM_STAR_SILENT`

**Performance tricks:**
- `zsh-defer` — plugins load after first prompt renders
- Cached bundle — `mise`, `zoxide`, `atuin`, `fzf`, `bun` inits compiled into one file
- Auto-regen — bundle rebuilds weekly in the background
- Named colors only in prompt — avoids hex brace parsing overhead
- `chpwd` hooks — project detection and git checks only run on directory change

### Terminal — [Ghostty](https://ghostty.org)
- FiraCode Nerd Font
- Dracula color scheme

### Editor — [Neovim](https://neovim.io) (LazyVim)
- `init.lua` bootstrap — plugins install automatically on first launch

### Window Manager — [AeroSpace](https://github.com/nikitabobko/AeroSpace)
- Tiling window manager for macOS

### Multiplexer — [tmux](https://github.com/tmux/tmux)
- Catppuccin theme
- TPM plugin manager — plugins install with `prefix + I`

### Tools
| Command | Tool | Replaces |
|---------|------|----------|
| `ls` | [eza](https://github.com/eza-community/eza) | `ls` |
| `cat` | [bat](https://github.com/sharkdp/bat) | `cat` |
| `du` | [dust](https://github.com/bootandy/dust) | `du` |
| `ps` | [procs](https://github.com/dalance/procs) | `ps` |
| `vim` | [neovim](https://neovim.io) | `vim` |
| `cd` | [zoxide](https://github.com/ajeetdsouza/zoxide) | `cd` (via `z`) |
| `lg` | [lazygit](https://github.com/jesseduffield/lazygit) | git TUI |
| `ld` | [lazydocker](https://github.com/jesseduffield/lazydocker) | docker TUI |
| `zi` | zoxide interactive | fuzzy directory jump |

<br>

## 🚀 Bootstrap a New Machine

```bash
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# 2. Install chezmoi and pull dotfiles
brew install chezmoi
chezmoi init --apply haydenkoch

# 3. Install all packages
brew bundle --file=~/.config/Brewfile

# 4. Generate zsh cache
exec zsh
regen && reload
```

That's it. Full environment in 4 steps.

<br>

## 📁 Structure

```
~/
├── .zshenv                          ← ZDOTDIR pointer + XDG env vars
├── .hushlogin                       ← silence macOS login banner
│
├── .config/
│   ├── zsh/
│   │   ├── .zshrc                   ← main shell config
│   │   ├── .zprofile                ← Homebrew shellenv
│   │   ├── project-icons.zsh        ← project type detection rules
│   │   ├── tmp.zsh                  ← workspace system
│   │   ├── local.zsh                ← machine overrides (not tracked)
│   │   ├── plugins/zsh-defer/       ← deferred loading
│   │   └── generated/               ← auto-built cache (not tracked)
│   │       ├── bundle.zsh           ← combined tool inits
│   │       ├── bundle.zsh.zwc       ← compiled bundle
│   │       ├── .zcompdump           ← completion dump
│   │       └── compcache/           ← completion cache
│   │
│   ├── ghostty/config               ← terminal config
│   ├── nvim/init.lua                ← neovim (LazyVim)
│   ├── aerospace/aerospace.toml     ← window manager
│   ├── tmux/tmux.conf               ← multiplexer
│   ├── git/config                   ← git config
│   ├── git/ignore                   ← global gitignore
│   ├── bat/config                   ← bat theme
│   ├── btop/btop.conf               ← system monitor
│   ├── karabiner/karabiner.json     ← keyboard
│   ├── mise/config.toml             ← tool versions
│   ├── gh/config.yml                ← GitHub CLI
│   └── Brewfile                     ← package manifest
│
└── .local/bin/
    └── halp                         ← quick reference script
```

<br>

## 🔧 Day-to-Day Usage

### Shell Commands

```bash
halp              # show all commands, aliases, and keybindings
regen             # rebuild zsh plugin cache
reload            # restart shell (exec zsh)

mkcd <dir>        # mkdir + cd in one step
take <url|dir>    # git clone + cd, or mkdir + cd
port <number>     # show what's listening on a TCP port

tmp               # interactive workspace picker (fzf)
tmp <name>        # create or cd into named workspace
tmp ls            # list all workspaces
tmp cd [name]     # cd into workspace (fzf picker if no name)
tmp rm [name]     # delete workspace (fzf multi-select if no name)
tmp clean         # delete all workspaces
```

### Keybindings

| Key | Action |
|-----|--------|
| `↑` / `↓` | History search (prefix match) |
| `Ctrl+F` | Fix last mistyped command |
| `Ctrl+Z` | Toggle suspend/resume |
| `Ctrl+L` | Clear screen |
| `Ctrl+W` | Delete word backward |
| `Alt+B` / `Alt+F` | Move word backward/forward |
| `Alt+D` | Delete word forward |

### Brewfile Sync

The Brewfile updates automatically on any `brew install`, `brew uninstall`, or `brew upgrade`. No manual steps needed.

To restore packages on a new machine:

```bash
brew bundle --file=~/.config/Brewfile
```

<br>

## ✏️ Editing Dotfiles

```bash
# edit directly — changes are live immediately
nvim ~/.config/zsh/.zshrc
reload

# sync changes to chezmoi
chezmoi re-add ~/.config/zsh/.zshrc

# or edit through chezmoi
chezmoi edit ~/.config/zsh/.zshrc
chezmoi apply

# check what's changed
chezmoi diff

# push updates
cd ~/.local/share/chezmoi
git add -A && git commit -m "description" && git push
```

### Machine-Local Overrides

Create `~/.config/zsh/local.zsh` for per-machine customizations. This file is sourced but never tracked by chezmoi.

```bash
# example: work machine PATH
path=(/opt/work-tools/bin $path)

# example: different editor
export EDITOR="code"
```

### Adding a New Project Type

Edit `~/.config/zsh/project-icons.zsh` and add a line — first match wins:

```zsh
'remix.config.ts|'$'\ue71e''|cyan'
```

Format: `filename|nerd-font-icon|color`

Find icons at [nerdfonts.com/cheat-sheet](https://www.nerdfonts.com/cheat-sheet).

<br>

## 📊 Performance

| Metric | Before | After |
|--------|--------|-------|
| Startup (cold) | 290ms | 20ms |
| Startup (warm) | 90ms | 10ms |
| First prompt | 116ms | 42ms |
| Input lag | 10ms | 7ms |

Measured with [zsh-bench](https://github.com/romkatv/zsh-bench) and `/usr/bin/time`.

<br>

## 🎨 Theme

[Dracula](https://draculatheme.com) everywhere — terminal, editor, tmux, bat, btop, fzf.

<br>

## 📜 License

These are my personal dotfiles. Fork and adapt freely.

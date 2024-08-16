# Tmux Configuration with Zsh Goodness

Unlock the full potential of your terminal with this meticulously crafted tmux configuration, accompanied by a versatile Zsh script for effortlessly launching websites and applications. 🔥

## Table of Contents

- [Tmux Configuration with Zsh Goodness](#tmux-configuration-with-zsh-goodness)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Screenshots](#screenshots)
    - [✨ New Look (Colson TMUX)](#-new-look-colson-tmux)
    - [💎 Old Look (Colson TMUX)](#-old-look-colson-tmux)
  - [Prerequisites](#prerequisites)
  - [Getting Started](#getting-started)
    - [Installation](#installation)
    - [Install Tmux Plugins](#install-tmux-plugins)
  - [Usage](#usage)
  - [Key Bindings](#key-bindings)
  - [Customization](#customization)

## Features

1. **Enhanced Tmux Configuration**: Elevate your terminal experience with a comprehensive tmux setup tailored for efficiency.
2. **Web and App Launcher**: Seamlessly launch websites and applications through an intuitive Zsh script.
3. **Plugin Management with TPM**: Utilizes [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm) for hassle-free tmux plugin management.
4. **Catppuccin Theme**: Elevate aesthetics with the visually pleasing Catppuccin theme.

## Screenshots

### ✨ New Look (Colson TMUX)

![colson tmux](https://i.imgur.com/0L5W67y.png)

![colson tmux](https://i.imgur.com/vTT8rNM.png)

![colson tmux](https://i.imgur.com/8vwzLQO.png)

![colson tmux](https://i.imgur.com/rO18Azi.png)

![colson tmux](https://i.imgur.com/AJz6jJs.png)

![colson tmux](https://i.imgur.com/5t1E1wZ.png)

![colson tmux](https://i.imgur.com/upWkGmY.png)

![colson tmux](https://i.imgur.com/0OLvIgL.png)

### 💎 Old Look (Colson TMUX)

![colson tmux](https://i.imgur.com/wDSlYW4.png)

![tmux colson](https://i.imgur.com/FBIWhK8.png)

![tmux colson](https://i.imgur.com/f4QwGKs.png)

![tmux colson](https://i.imgur.com/lrMnRga.png)

## Prerequisites

Before diving in, ensure you have the following prerequisites:

- [tmux](https://github.com/tmux/tmux): Ensure tmux is installed on your system.
- [fzf](https://github.com/junegunn/fzf): Install the fuzzy finder tool for interactive selection.

## Getting Started

### Installation

1. Begin by installing TPM (Tmux Plugin Manager):

   ```shell
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

2. Clone this repository into your home directory:

   ```shell
   git clone https://github.com/colson0x1/tmux ~/.config/tmux
   ```

3. Reload your tmux environment to apply the configuration:

   ```shell
   tmux source-file ~/.config/tmux/tmux.conf
   ```

4. Make the `goto.sh` script executable:

   ```shell
   chmod +x ~/.config/tmux/goto.sh
   ```

5. Add `.zshrc` to root on your machine:

   ```shell
   cat ~/.config/tmux/.zshrc >> ~/.zshrc
   ```

6. Restart your Terminal.

   ```shell
   $ source ~/.zshrc
   $ zshrl
   $ tmuxrl
   ```

7. You're all set! Launch websites and applications using `goto.sh`.
   ```
   <leader>+o
   ```
   NOTE: Leader in tmux is: `Ctrl+Space`

### Install Tmux Plugins

1. Open tmux:
   ```shell
   tmux
   ```
2. Navigate to the tmux directory:
   ```shell
   cd ~/.config/tmux
   ```
3. Use Neovim to open the configuration:
   ```shell
   nvim .
   ```
4. Go to `tmux.conf`:
   ```shell
   leader+shift+i
   ```
   (Note: Leader key is `Ctrl+Space`, so use `Ctrl+Space` and `Shift+i`)

## Usage

- Press `ctrl+space` to activate the leader key.
- Switch between windows with `M-K` and `M-J`.
- Split the terminal horizontally (`leader + -`) and vertically (`leader + |`).
- Launch websites and apps with `leader + o`.
- Customize website and app choices in `goto.sh`.

## Key Bindings

Master these key bindings for efficient tmux navigation:

- **Leader Key**: `ctrl+space`
- **Window Switching**: `Shift+Alt+j` and `Shift+Alt+k`
- **Horizontal Split**: `leader + -`
- **Vertical Split**: `leader + |`
- **Launch Websites and Apps**: `leader + o`

## Customization

Tailor your tmux configuration and the list of websites and applications in `goto.sh` to match your preferences. Dive into the endless possibilities of customization and make your terminal truly yours. Additionally, explore the power of Zsh with a rich set of aliases and Git shortcuts in the included `.zshrc` file.

Peace!

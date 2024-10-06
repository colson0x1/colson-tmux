# Tmux Configuration with Zsh Goodness (colson-tmux npm)

Unlock the full potential of your terminal with this meticulously crafted tmux configuration, accompanied by a versatile Zsh script for effortlessly launching websites and applications. 🔥

## Installation through NPM

Ensure **Tmux** is installed on your machine!  
`Tmux leader key`-> **`Ctrl + Space`**

```shell
$ npx colson-tmux
$ cd ~/.config/tmux
$ nvim .
```

Navigate to `tmux.conf`  
Execute this command in normal mode!

```
<leader> + shit + i
```

Restart **terminal** to load **Tmux**!

```
$ zshrl
$ tmuxrl
```

#### If you've already installed this before then for the latest pull, do:

```
$ npx colson-tmux@latest
```

#### `NOTE`: Read the documentation below for indepth wisdom on proper installation and uses!

## Table of Contents

- [Tmux Configuration with Zsh Goodness (colson-tmux npm)](#tmux-configuration-with-zsh-goodness-colson-tmux-npm)
  - [Installation through NPM](#installation-through-npm)
    - [If you've already installed this before then for the latest pull, do:](#if-youve-already-installed-this-before-then-for-the-latest-pull-do)
    - [`NOTE`: Read the documentation below for indepth wisdom on proper installation and uses!](#note-read-the-documentation-below-for-indepth-wisdom-on-proper-installation-and-uses)
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
  - [Customization](#customization)
  - [🔥 **Alias/Command for Engineers**](#-aliascommand-for-engineers)
    - [**Zsh \& Tmux Commands**](#zsh--tmux-commands)
    - [**Tmux Specific Commands**](#tmux-specific-commands)
    - [**Git Aliases**](#git-aliases)
    - [**Docker Aliases**](#docker-aliases)
    - [**Kubernetes Aliases**](#kubernetes-aliases)
    - [**Development Tool Aliases**](#development-tool-aliases)
    - [**Miscellaneous**](#miscellaneous)

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
   git clone https://github.com/colson0x1/colson-tmux ~/.config/tmux
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

- **Leader Key**: `ctrl+space`
- **Window Switching**: `Shift+Alt+j` and `Shift+Alt+k`
- **Horizontal Split**: `leader + -`
- **Vertical Split**: `leader + |`
- **Launch Websites and Apps**: `leader + o`

`NOTE`: Make sure `fzf` is installed on your machine for **`<leader> + o`** to work!!

```shell
$ sudo pacman -S fzf
```

## Customization

Tailor your tmux configuration and the list of websites and applications in `goto.sh` to match your preferences. Dive into the endless possibilities of customization and make your terminal truly yours. Additionally, explore the power of Zsh with a rich set of aliases and Git shortcuts in the included `.zshrc` file.

---

## 🔥 **Alias/Command for Engineers**

This package also provides configurations and command aliases for `Tmux`, `Zsh`, `Git`, `Docker`, `Kubernetes`, and other development tools, aiming to improve software development productivity.

### **Zsh & Tmux Commands**

| Alias/Command                                  | Description                          |
| ---------------------------------------------- | ------------------------------------ |
| `tl`                                           | List all tmux sessions               |
| `ts [session_name]`                            | Start a new tmux session             |
| `ta [session_name]`                            | Attach to an existing tmux session   |
| `tk [session_name]`                            | Kill a tmux session                  |
| `tr [current_session_name] [new_session_name]` | Rename existing tmux session         |
| `nv`                                           | Open Neovim in the current directory |
| `nvv`                                          | Open Neovim with sudo privileges     |
| `cl`                                           | Clear the terminal screen            |
| `tmuxrl`                                       | Reload the tmux configuration        |
| `zshrl`                                        | Reload the Zsh configuration         |
| `vim`                                          | Alias for opening Neovim             |

### **Tmux Specific Commands**

| **Command/Binding**    | **Description**                                                                 |
| ---------------------- | ------------------------------------------------------------------------------- |
| `<leader> + -`         | Split the current pane horizontally                                             |
| `<leader> + \|`        | Split the current pane vertically                                               |
| `Shift+Alt+J`          | Move to the next window                                                         |
| `Shift+Alt+K`          | Move to the previous window                                                     |
| `<leader> + r`         | Rename current window                                                           |
| `<leader> + n`         | Switch to next window                                                           |
| `<leader> + p`         | Switch to previous window                                                       |
| `<leader> + s`         | Switch sessions                                                                 |
| `<leader> + shift + S` | Save tmux sessions (tmux-resurrect) even after machine restarts                 |
| `<leader> + shift + R` | Restore the last saved tmux session (tmux-resurrect) even after restarting      |
| `<leader> + o`         | Trigger the custom `goto.sh` script for opening websites and apps from terminal |
| `<Ctrl> + d`           | Close current window                                                            |
| `<leader> + d`         | Exit Tmux sesion                                                                |

### **Git Aliases**

| Alias/Command                   | Description                                    |
| ------------------------------- | ---------------------------------------------- |
| `gst`                           | Show the current git status                    |
| `gd`                            | Show the git diff                              |
| `ga`                            | Stage all changes                              |
| `gaf [file1] [file2] ..`        | Stage specific files                           |
| `gc [message]`                  | Commit changes with a message                  |
| `gpm`                           | Push changes to the `main` branch              |
| `gpmf`                          | Force push changes to the `main` branch        |
| `gl`                            | Show a readable git log                        |
| `gg`                            | Show a colorful and condensed git log          |
| `gunt`                          | Show untracked files                           |
| `gcan`                          | Amend the last commit with same commit message |
| `gcam [message]`                | Amend the last commit with new commit message  |
| `gcb [branch_name]`             | Create and checkout a new branch               |
| `gco [branch_name]`             | Switch to an existing branch                   |
| `grh`                           | Reset the current branch to the latest commit  |
| `grh1`                          | Reset the last branch to the latest commit     |
| `gs`                            | Abbreviated git status                         |
| `gb`                            | List branches sorted by most recent commit     |
| `gd [fileName or path to file]` | Show the git diff for a specific file          |
| `gds`                           | Side-by-side git diff                          |
| `gwd`                           | Show a colorful word-diff                      |
| `gp`                            | Push the current branch                        |
| `gpl`                           | Pull the latest changes from the remote        |
| `gf`                            | Fetch changes from the remote                  |
| `gsmst`                         | Check the status of all submodules             |
| `gasm`                          | Stage all changes, including submodules        |
| `gri`                           | Interactive rebase                             |

Add `vimdiff` as default for diff!

```
$ git config --global diff.tool vimdiff
$ git config --global difftool.prompt false
```

Now, `gds` works :)

\+ Also make **Git** use `main` as the default branch as opposed to classic `master` convention!

```
$ git config --global init.defaultBranch main
```

### **Docker Aliases**

| Alias/Command     | Description                                         |
| ----------------- | --------------------------------------------------- |
| `d`               | Alias for Docker                                    |
| `dps`             | List Docker containers                              |
| `di`              | List Docker images                                  |
| `db [tag]`        | Build a Docker image with a tag                     |
| `dr [container]`  | Run a Docker container                              |
| `dex [container]` | Execute a command inside a running Docker container |
| `dst [container]` | Stop a running Docker container                     |
| `drm [container]` | Remove a Docker container                           |
| `drmi [image]`    | Remove a Docker image                               |

### **Kubernetes Aliases**

| Alias/Command     | Description                                  |
| ----------------- | -------------------------------------------- |
| `k`               | Alias for kubectl                            |
| `kgp`             | Get all Kubernetes pods                      |
| `kgs`             | Get all Kubernetes services                  |
| `kga`             | Get all Kubernetes resources                 |
| `kd [resource]`   | Describe a Kubernetes resource               |
| `kdel [resource]` | Delete a Kubernetes resource                 |
| `kaf [file]`      | Apply a Kubernetes configuration from a file |
| `kl [pod]`        | Show logs of a Kubernetes pod                |
| `ke [pod]`        | Execute a command inside a Kubernetes pod    |
| `kns [namespace]` | Switch Kubernetes namespace                  |

### **Development Tool Aliases**

| Alias/Command | Description                                   |
| ------------- | --------------------------------------------- |
| `cra`         | Create a new React app using Create React App |
| `cva`         | Create a new VITE app                         |
| `cna`         | Create a new Next.js app                      |
| `bun`         | Run Bun package manager                       |

### **Miscellaneous**

| Alias/Command             | Description                     |
| ------------------------- | ------------------------------- |
| `gcloud`                  | Google Cloud SDK configuration  |
| `eval "$(ng completion)"` | Load Angular CLI autocompletion |
| `bindkey -v`              | Enable Vim key bindings in Zsh  |

---

Peace!

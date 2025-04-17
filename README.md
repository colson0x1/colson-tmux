# Tmux Configuration with Zsh Goodness (colson-tmux npm)

Unlock the full potential of your terminal with this meticulously crafted tmux configuration, accompanied by a versatile Zsh script for effortlessly launching websites and applications. 🔥

![colson tmux npm on arch linux machine](https://i.imgur.com/5c6IRsM.png)

![colson tmux npm](https://i.imgur.com/3PiJBBO.png)

## Make ZSH default shell

```shell
$ sudo pacman -S zsh
$ which zsh
// Output -> /usr/bin/zsh

// Make ZSH as default!
$ chsh -s /usr/bin/zsh
// OR
$ chsh -s $(which zsh)

// Now Restart your machine
$ reboot
// Verify SHELL
$ echo $SHELL
```

## Installation through NPM

Ensure **Tmux** is installed on your machine!

`Tmux leader key`-> **`Ctrl + Space`**

```shell
// Install Tmux
$ sudo pacman -S tmux

// Install colson-tmux
$ npx colson-tmux
$ cd ~/.config/tmux
$ tmux
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
    - [💎 NEW LOOK (Colson TMUX, December 5th, 2024)](#-new-look-colson-tmux-december-5th-2024)
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
  - [Concurrent Services Execution with one go!](#concurrent-services-execution-with-one-go)
    - [**Manual Execution!**](#manual-execution)
    - [**Command File Example**](#command-file-example)
    - [**Concurrency in Action!!**](#concurrency-in-action)
  - [🛳️ Docker Maintenance Cron Job ⏰](#️-docker-maintenance-cron-job-)
    - [Installation](#installation-1)
      - [Arch Linux](#arch-linux)
      - [macOS](#macos)
    - [Creating the Cleanup Script](#creating-the-cleanup-script)
    - [Setting Permissions](#setting-permissions)
    - [Scheduling with Crontab](#scheduling-with-crontab)
    - [Verifying Schedule](#verifying-schedule)
    - [Testing Your Setup](#testing-your-setup)
      - [Test Script Execution](#test-script-execution)
      - [Test Cron Job Configuration](#test-cron-job-configuration)
    - [Troubleshooting](#troubleshooting)
      - [Check Cron Service](#check-cron-service)
      - [Check Cron Logs](#check-cron-logs)
      - [Common Issues](#common-issues)
  - [🐳 Docker Daemon Configuration](#-docker-daemon-configuration)
  - [🧬 Multi Branch Rebaser @ TYPEMUSE](#-multi-branch-rebaser--typemuse)
    - [**@ Approach 1**](#-approach-1)
    - [**🔥 @ Approach 2**](#--approach-2)
      - [All \* Branches](#all--branches)
      - [Specifying Branches](#specifying-branches)
  - [📡 Machine IP Address Tool](#-machine-ip-address-tool)

## Features

1. **Enhanced Tmux Configuration**: Elevate your terminal experience with a comprehensive tmux setup tailored for efficiency.
2. **Web and App Launcher**: Seamlessly launch websites and applications through an intuitive Zsh script.
3. **Plugin Management with TPM**: Utilizes [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm) for hassle-free tmux plugin management.
4. **Catppuccin Theme**: Elevate aesthetics with the visually pleasing Catppuccin theme.

## Screenshots

### 💎 NEW LOOK (Colson TMUX, December 5th, 2024)

![colson tmux npm](https://i.imgur.com/3PiJBBO.png)

![colson tmux npm](https://i.imgur.com/IUGEkgN.png)

![colson tmux npm](https://i.imgur.com/RcETNS3.png)

![colson tmux npm](https://i.imgur.com/2GtP3Cr.png)

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
| `tc [session_name]`                            | Switch between sessions              |
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
| `gr <branch-name>`              | Git rebase                                     |
| `gri <branch-name>`             | Interactive rebase                             |

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

## Concurrent Services Execution with one go!

```shell
cd ~
mkdir -p ~/bin
```

Refactor commands in the `services-start-command.txt` file which is located at `~/.config/tmux`!

Make `start-services.sh` executable!

```shell
cd ~/.config/tmux
chmod +x start-services.sh
cp start-services.sh ~/bin/start-services
zshrl

```

**Uses:**

Here, `<session-name>` is the name of the `Tmux` session that will be created (or attached to, if it already exists).
And `services-start-commands.txt` is the text file that contains the list of commands to run in separate windows inside the `Tmux` session!

```shell
ss <session-name> <services-start-commands-file>

```

**services start ->**
`ss="~/.config/tmux/start-services.sh"`

**services start commands ->**
`ssc="~/.config/tmux/services-start-commands.txt"`

### **Manual Execution!**

```shell
cd ~/.config/tmux
chmod +x start-services.sh
zshrl
# Restart the Terminal
cd ~/.config/tmux
./start-services.sh <session-name> <command-file-txt-path>
# Example
./start-services.sh TYPEMUSE ~/.config/tmux/services-start-commands.txt
```

### **Command File Example**

**`services-start-command.txt`**

```shell
cd ~/prod/TYPEMUSE/typemuse-web && pnpm dev
cd ~/prod/TYPEMUSE/typemuse-web && pnpm web:dev:tunnel
cd ~/prod/TYPEMUSE/auth-service && pnpm start:dev
cd ~/prod/TYPEMUSE/game-service && pnpm start:dev
cd ~/prod/TYPEMUSE/leaderboard-service && pnpm start:dev
cd ~/prod/TYPEMUSE/messaging-service && go run .
cd ~/prod/TYPEMUSE/payment-service && pnpm start:dev
cd ~/prod/TYPEMUSE/transaction-service && go run .
cd ~/prod/TYPEMUSE/social-network-service && pnpm start:dev
cd ~/prod/TYPEMUSE/react-native-app && pnpm start:dev
cd ~/prod/TYPEMUSE/electron-desktop-app && pnpm start:dev
cd ~/prod/TYPEMUSE/admin-service && pnpm start:dev
cd ~/prod/TYPEMUSE/dashboard-service && pnpm start:dev
cd ~/prod/TYPEMUSE/notification-service && pnpm start:dev
cd ~/prod/TYPEMUSE/multiplayer-service && pnpm start:dev
cd ~/prod/TYPEMUSE/account-service && pnpm start:dev
cd ~/prod/TYPEMUSE/order-service && pnpm start:dev
cd ~/prod/TYPEMUSE/subscription-service && pnpm start:dev
cd ~/prod/TYPEMUSE/event-bus-service && pnpm start:dev
```

### **Concurrency in Action!!**

`NOTE`: Make sure you have done this first!

```shell
cd ~/.config/tmux
chmod +x start-services.sh
```

Now restart the terminal and use the pattern below!

**`ss`** -> Start Services

**`ssc`** -> Start Services Commands

```shell
ss <session-name> ssc
```

**EXAMPLE:**

```shell
ss TYPEMUSE ssc
```

## 🛳️ Docker Maintenance Cron Job ⏰

Scheduling automatic Docker cleanup tasks using cron on Arch Linux and macOS.

### Installation

#### Arch Linux

```bash
# Install cronie package
sudo pacman -S cronie

# Enable and start the service
sudo systemctl enable --now cronie

# Verify service status
sudo systemctl status cronie
```

#### macOS

```bash
# macOS has cron pre-installed, no installation needed
# Verify it's running
pgrep cron
```

### Creating the Cleanup Script

```bash
# Create directory
sudo mkdir -p /opt/docker-maintenance

# Create script file
sudo nvim /opt/docker-maintenance/docker-cleanup.sh
```

Add the content thats in `tmux/docker-cleanup.sh` into your script thats located at `/opt/docker-maintenance/docker-cleanup.sh`:

### Setting Permissions

```bash
# Make script executable
sudo chmod +x /opt/docker-maintenance/docker-cleanup.sh

# Verify permissions
ls -la /opt/docker-maintenance/docker-cleanup.sh
# Should show: -rwxr-xr-x
```

### Scheduling with Crontab

```bash
# Edit root's crontab with Neovim
sudo EDITOR=nvim crontab -e
```

Add this line to run cleanup every Sunday at 2 AM:

```
0 2 * * 0 /opt/docker-maintenance/docker-cleanup.sh
```

### Verifying Schedule

```bash
# List scheduled cron jobs
sudo crontab -l

# Should show your entry:
# 0 2 * * 0 /opt/docker-maintenance/docker-cleanup.sh
```

### Testing Your Setup

#### Test Script Execution

```bash
# Run script manually
sudo /opt/docker-maintenance/docker-cleanup.sh

# Check log file
sudo cat /var/log/docker-maintenance/docker-cleanup-$(date +%Y-%m-%d).log
```

You should see something like this!

```
[sudo] password for colson:
➜  docker-maintenance sudo cat /var/log/docker-maintenance/docker-cleanup-$(date +%Y-%m-%d).log

[sudo] password for colson:
[2025-04-02 10:08:33] Starting weekly Docker cleanup
[2025-04-02 10:08:33] Initial disk usage:
[2025-04-02 10:13:46] Pruning Docker system...
[2025-04-02 10:13:53] Pruning builder cache...
DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
            Install the buildx component to build images with BuildKit:
            https://docs.docker.com/go/buildx/

Deleted build cache objects:
prf49e5wwszakjm898ebw5tzy
po67ng1m0ro8x8z2buwpyka13
rpabj5ogylhph4ajmtbeiaw1u
4x9c3x4ve2u3thvl5a8bsr86x
mibkugj0j8skks1kew0ok5vhl
lxn3r4tv8ubg9o0g8wal6hd3s
hfqvaes0jzfdzfgptoac8xm5f
0hbakjahz1rq9ck9z8lf08gj6
nm9xqsjbf493u3yrzp7rvh3sv
qnblrkgy8zxlhlxpxlyhio2r3
wlgjzsygj6ca7qse01h7rslon
ac0ftzxuye9cfr6rn03e85gzt
nkzke8qa4wfnbs83jvsykqqix
mwlbpszruzn41vzg7pt78y1mr
qk5uzmel14czh8gqynng565nj
uzuyeevp6sj92qt7b6fsytbb5
v1mj7k8hxub4nuij1d8mvaacn
h9e40amajnnjo5rz4379cybdc
rydwmnuku2nls213yv6llxevk
udeum1vajqkmamlfmbydmd977
l2iyignfbv8697kbkyiszou99
unqny6n0mp191wle6k6g7w6t8
ipil0rd2hldcj7jtq14770k5m
m7gz5geztx33b6zedu3wkp98x
fswfmryuje9dngqcxzzilpkzn
uwai76t79n1y6sy4wdbqdl2im
k72cbmxz1960cd5ytxnxz36ym
756mj7g2197vupivtqztn0zvf
u3lr96l8zcg03xnu8gjl2ze1x
nw5frhqkeidblk2i9tdyqehbd
wac50qxjqg7z8jqermm5vg5hm
j78wpq65ilg1cbekr93pe9gcg
p9ppg3u3kzcd5779go9dmh53o
5fxmj2ep7yjcerz9jmxxlhhnk
hxvbdbpbjd2rriqg4ec20wfi4
qwop3yas4aex6nmcsazq3loc3
dhsdj8aye16q0njkhb5j8jytb
gt5xp7t9vwrdywoa2gb02pyw3
mjru7unojgi0cwapfieeo4kxe
nacuhe7vjo5pctq13315lmn4u
8he3woftx0ir9ytxhr3gc0d0q
qa4aihz7e86ffbodksagvvxqi
mfkcme9jd7l8a4w7jeli908vs
2zi75q5agzewquh450w5ep3qv
vyjsfsbbk80m8ndzexw6im3ey
ciyvt5jqhdr49kgboo4m72inp
ejpkbsrjsr5p3601a5f5c1i1u
qyv23c3wmytad0xrhb8kknylw
wvedvjre4g34bnzom03rbs4ex
jqnog6lp7m3xr75ocpmgds7hb
3bnwpxocijdvu8xqjk75ri4m7
c0v8h8y6l0oirm8g3py8d3hb8
paevcrcwlv91vjfazuztxbixp
irv1ngqqsvy5wxs7ffirjmat8
xm21xrb34idyiyfen1snkcvfg
d850ufu62f28nqpp33c11rhhg
nh2z0miicgettg5cwxhitq3xt
xw3sjapj27fh6ajjg8s25u20b
bg6hqtu4gnuusxpqdhboqif7n

Total reclaimed space: 821.4MB
[2025-04-02 10:14:38] Final disk usage:
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          14        14        7.729GB   218.8MB (2%)
Containers      14        14        17.28MB   0B (0%)
Local Volumes   3         3         47.79MB   0B (0%)
Build Cache     0         0         0B        0B
[2025-04-02 10:23:11] Cleanup completed
------------------------------------------
[2025-04-02 10:26:05] Starting weekly Docker cleanup
[2025-04-02 10:26:05] Initial disk usage:
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          14        14        7.729GB   218.8MB (2%)
Containers      14        14        17.3MB    0B (0%)
Local Volumes   3         3         47.79MB   0B (0%)
Build Cache     0         0         0B        0B
[2025-04-02 10:27:05] Pruning Docker system...
Total reclaimed space: 0B
[2025-04-02 10:27:06] Pruning builder cache...
DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
            Install the buildx component to build images with BuildKit:
            https://docs.docker.com/go/buildx/

Total reclaimed space: 0B
[2025-04-02 10:27:06] Final disk usage:
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          14        14        7.729GB   218.8MB (2%)
Containers      14        14        17.31MB   0B (0%)
Local Volumes   3         3         47.79MB   0B (0%)
Build Cache     0         0         0B        0B
[2025-04-02 10:28:54] Cleanup completed
------------------------------------------
➜  docker-maintenance

```

#### Test Cron Job Configuration

```bash
# Arch Linux
sudo run-parts --test /etc/cron.daily

# macOS
sudo /usr/lib/cron/tabs/
```

### Troubleshooting

#### Check Cron Service

```bash
# Arch Linux
sudo systemctl status cronie

# macOS
sudo launchctl list | grep cron
```

#### Check Cron Logs

```bash
# Arch Linux
sudo journalctl -u cronie

# macOS
grep cron /var/log/system.log
```

#### Common Issues

1. **Script not running**: Check script permissions and path
2. **No logs created**: Ensure log directory is writable
3. **Editor issues**: Use `export EDITOR=nvim` before running `crontab -e`

---

## 🐳 Docker Daemon Configuration

I've engineered this Docker daemon with a performance-first, production-ready approach. So what I've done is, implemented overlay2 storage driver for optimal performance while enabling comprehensive log management with rotation, compression, and K8s-aware environment variables.

For CI/CD efficiency, I've activated BuildKit with automatic garbage collection, keeping storage clean at 20GB. In addition, I optimized network operations with redundant DNS (Google/Cloudflare), concurrent transfers (10 parallel downloads/uploads), and exposed metrics on port 9323 for comprehensive monitoring.

So this configuration ensures high availability through live-restore capability, allowing container operations to continue during daemon updates. Furthermore, I've optimized System resource management with systemd cgroups integration, custom data root, generous 1GB default shared memory, and increased file handle limits (64K) to prevent resource exhaustion during peak loads.

This configuration balances performance, observability, and reliability while enabling experimental features for future-proofing container infrastructure.

Here's the implementation:

1 .Create the folder if it does not exist:

```shell
$ sudo mkdir -p /etc/docker/
```

2 .Create the daemon configuration file if it does not exist:

```shell
$ sudo nvim /etc/docker/daemon.json
```

3. Copy the content of this file `~/.config/tmux/daemon.json` to the global Docker configuration at `/etc/docker/daemon.json`.

```shell
$ sudo cp ~/.config/tmux/daemon.json /etc/docker/daemon.json
```

4. Stop Docker services:

```shell
$ sudo systemctl stop docker.service
$ sudo systemctl stop docker.socket
$ sudo systemctl stop containerd.service
```

5. Restart Docker Daemon & Services (This will recreate the directory structure):

```
$ sudo systemctl daemon-reload
$ sudo systemctl start docker
$ sudo systemctl status docker
```

6. Verify Docker is working:

```shell
$ docker info
$ docker run hello-world
$ docker ps
```

---

## 🧬 Multi Branch Rebaser @ TYPEMUSE

### **@ Approach 1**

Add the content of this file `~/.config/tmux/.gitconfig` to the global Git configuration at
`~/.gitconfig`.

And then you can use it like this:

Quick Info -> **`rba`** stands for **Rebase ALL**.

```
# Rebase all feature branches
$ git rba

# Rebase specific branches
$ git rba feature/payment-ui feature/payment-backend feature/analytics
```

### **🔥 @ Approach 2**

<!-- 1. First make the `rebase-typemuse.sh` script executable: -->
<!---->
<!-- ```shell -->
<!-- $ cd ~/.config/tmux -->
<!-- $ sudo chmod +x typemuse-branch-reconciliation-engine.sh -->
<!-- ``` -->

**Run** the script:

#### All \* Branches

```
$ tmrebase
or
$ tmr
```

#### Specifying Branches

```
# Rebase specific branches
$ tmrebase feature/payment-ui feature/user-auth feature/analytics
or
$ tmr feature/login feature/dashboard
```

OR run manually:

```
# Rebase all branches (with interactive selection)
$ ./rebase-typemuse.sh

# Rebase specific branches
$ ./rebase-typemuse.sh feature/payment-ui feature/payment-backend
```

---

## 📡 Machine IP Address Tool

Run **`1.1.1.1`** or **`xip`** to get your machine's **private** & **public** **IP** addresses.

---

Peace!

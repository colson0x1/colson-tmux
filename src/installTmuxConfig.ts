import fs from 'fs-extra';
import path from 'path';
import { getHomeDirectory, runCommand } from './utils.js';
import { fileURLToPath } from 'url';
import os from 'os';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const TMUX_CONFIG_PATH = path.join(getHomeDirectory(), '.config', 'tmux');
const LOCAL_TMUX_CONFIG = path.join(__dirname, '..', 'tmux');
const ZSHRC_PATH = path.join(getHomeDirectory(), '.zshrc');

const isZshInstalled = (): boolean => {
  try {
    runCommand('zsh --version');
    return true;
  } catch {
    return false;
  }
};

const isOhMyZshInstalled = (): boolean => {
  return fs.existsSync(path.join(getHomeDirectory(), '.oh-my-zsh'));
};

const installOhMyZsh = (): void => {
  console.log('Installing Oh My Zsh...');
  runCommand(
    'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended',
  );
  console.log('Oh My Zsh installed successfully.');
};

export const installTmuxConfig = async (): Promise<void> => {
  console.log('Starting the setup process...');

  if (!isZshInstalled()) {
    console.error('Zsh is not installed. Please install Zsh and try again.');
    process.exit(1);
  }

  if (!isOhMyZshInstalled()) {
    installOhMyZsh();
  } else {
    console.log('Oh My Zsh is already installed.');
  }

  console.log('Installing Tmux configuration...');
  await fs.ensureDir(TMUX_CONFIG_PATH);

  await fs.copy(LOCAL_TMUX_CONFIG, TMUX_CONFIG_PATH, {
    overwrite: true,
    filter: (src) => !src.includes('.zshrc'), // Exclude .zshrc from this copy
  });
  console.log('Tmux configuration copied to ~/.config/tmux');

  await fs.copy(path.join(LOCAL_TMUX_CONFIG, '.zshrc'), ZSHRC_PATH, {
    overwrite: true,
  });
  console.log('.zshrc file copied to home directory.');

  const tpmDir = path.join(getHomeDirectory(), '.tmux/plugins/tpm');
  if (!fs.existsSync(tpmDir)) {
    console.log('Cloning Tmux Plugin Manager (TPM)...');
    runCommand(
      'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm',
    );
    console.log('TPM installed.');
  } else {
    console.log('TPM is already installed.');
  }

  // console.log('Setup complete. Tmux environment is ready!');
};

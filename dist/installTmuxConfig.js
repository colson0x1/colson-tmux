import fs from 'fs-extra';
import path from 'path';
import { getHomeDirectory, runCommand } from './utils.js';
import { fileURLToPath } from 'url';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const TMUX_CONFIG_PATH = path.join(getHomeDirectory(), '.config', 'tmux');
const LOCAL_TMUX_CONFIG = path.join(__dirname, '..', 'tmux');
const ZSHRC_PATH = path.join(getHomeDirectory(), '.zshrc');
export const installTmuxConfig = async () => {
    console.log('Installing tmux configuration...');
    await fs.ensureDir(TMUX_CONFIG_PATH);
    await fs.copy(LOCAL_TMUX_CONFIG, TMUX_CONFIG_PATH, {
        overwrite: true,
        filter: (src) => !src.includes('.zshrc'),
    });
    console.log('tmux configuration copied to ~/.config/tmux');
    await fs.copy(path.join(LOCAL_TMUX_CONFIG, '.zshrc'), ZSHRC_PATH, {
        overwrite: true,
    });
    console.log('.zshrc file copied to home directory.');
    const tpmDir = path.join(getHomeDirectory(), '.tmux/plugins/tpm');
    if (!fs.existsSync(tpmDir)) {
        console.log('Cloning Tmux Plugin Manager (TPM)...');
        runCommand('git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm');
        console.log('TPM installed.');
    }
    else {
        console.log('TPM is already installed.');
    }
};

#!/usr/bin/env node

import { installTmuxConfig } from './installTmuxConfig.js';

const greetUser = (): void => {
  const greeting = `
  \x1b[1;34m@ Introducing \x1b[38;5;32mCOLSON TMUX 💎\x1b[0m
  \x1b[1;35mOptimized Tmux + ZSH Configuration for Software Engineers 🚀\x1b[0m
  \x1b[38;5;214mAuthor: Colson\x1b[0m

  \x1b[1;37mVisit the official repository for more information:
  https://github.com/colson0x1/colson-tmux\x1b[0m

  \x1b[1;33mStreamline terminal workflows with a professional-grade Tmux environment for maximum productivity.\x1b[0m
  `;
  console.log(greeting);
};

(async () => {
  greetUser();
  try {
    await installTmuxConfig();
    console.log('Tmux configuration installed successfully!');
  } catch (error) {
    console.error('Failed to install Tmux configuration:', error);
  }
})();

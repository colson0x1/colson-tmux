import { execSync } from 'child_process';
import os from 'os';

export const getHomeDirectory = (): string => {
  return os.homedir();
};

export const runCommand = (command: string): void => {
  execSync(command, { stdio: 'inherit' });
};

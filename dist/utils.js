import { execSync } from 'child_process';
import os from 'os';
export const getHomeDirectory = () => {
    return os.homedir();
};
export const runCommand = (command) => {
    execSync(command, { stdio: 'inherit' });
};

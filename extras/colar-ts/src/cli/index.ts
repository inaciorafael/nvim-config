import fs from 'fs'
import { generateInterfaces } from '../core/generate'

export function start() {
  const input = fs.readFileSync(0, 'utf-8');
  const json = JSON.parse(input);

  const interfaces = generateInterfaces('Root', json);

  console.log(interfaces.reverse().join('\n\n'));
}

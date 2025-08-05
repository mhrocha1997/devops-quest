import { Injectable } from '@nestjs/common';
import { createWriteStream } from 'fs';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World!';
  }
  getExample(): string {
    return "I'm on K8S!!!";
  }

  writeFile(): string {
    const file = createWriteStream('teste.txt');

    for (let x = 0; x <= 10000; x++) {
      file.write('Writing...\n');
    }
    file.end();
    return 'File Written';
  }
}

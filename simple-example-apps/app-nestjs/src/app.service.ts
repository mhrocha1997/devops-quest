import { Injectable } from '@nestjs/common';
import { metrics } from './infra/tracer';
import { createWriteStream } from 'fs';

@Injectable()
export class AppService {
  getHello(): string {
    const metric = metrics.getMeter('app-nestjs')
    const successMetrics = metric.createCounter('hello-success')
    successMetrics.add(1)
    return 'Hello from NestJs!';
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

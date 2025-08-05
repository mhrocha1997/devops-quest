import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { logger } from './infra/logger'

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    logger.info("Hello")
    return this.appService.getHello();
  }

  @Get('/example-k8s')
  getExample(): string {
    return this.appService.getExample();
  }

  @Get('/write-file')
  writeFile(): string {
    return this.appService.writeFile();
  }
}

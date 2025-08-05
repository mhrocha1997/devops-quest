import {sdk} from './infra/tracer'
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { logger } from './infra/logger'

sdk.start();
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  logger.info("App running!!")
  await app.listen(3001);
}
bootstrap();

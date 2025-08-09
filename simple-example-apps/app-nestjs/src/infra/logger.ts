import pino from 'pino'

const logger = pino({
  level: 'debug',
  transport: {
    targets: [
      {
        target: 'pino-pretty',
        level: 'error',
        options: {
          name: 'dev-terminal',
          colorize: true,
          levelFirst: true,
          include: 'level,time',
          translateTime: 'yyyy-mm-dd HH:MM:ss Z'
        }
      }
    ]
  }
})

export { logger }
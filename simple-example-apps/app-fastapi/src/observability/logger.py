import sys
import os

from loguru import logger

LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")

logger.remove(0)
logger.add(sys.stderr, format="{time:MMMM D, YYYY > HH:mm:ss!UTC} | {level} | {message}", serialize=True, level=LOG_LEVEL)

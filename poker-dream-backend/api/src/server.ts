import app from './app';
import { env } from './config/env';
import { disconnectDatabase } from './config/database';
import logger from './utils/logger';

const server = app.listen(env.PORT, () => {
  logger.info(`🚀 Server is running on port ${env.PORT}`);
  logger.info(`📝 Environment: ${env.NODE_ENV}`);
  logger.info(`🔗 API URL: ${env.API_URL}`);
  logger.info(`📊 Admin URL: ${env.ADMIN_URL}`);
});

// Graceful shutdown
const gracefulShutdown = async (signal: string) => {
  logger.info(`${signal} received, closing server gracefully`);

  server.close(async () => {
    logger.info('HTTP server closed');

    try {
      await disconnectDatabase();
      logger.info('Database connection closed');
      process.exit(0);
    } catch (error) {
      logger.error('Error during graceful shutdown:', error);
      process.exit(1);
    }
  });

  // Force shutdown after 10 seconds
  setTimeout(() => {
    logger.error('Forced shutdown after timeout');
    process.exit(1);
  }, 10000);
};

process.on('SIGTERM', () => gracefulShutdown('SIGTERM'));
process.on('SIGINT', () => gracefulShutdown('SIGINT'));

// Handle uncaught exceptions
process.on('uncaughtException', (error) => {
  logger.error('Uncaught Exception:', error);
  process.exit(1);
});

process.on('unhandledRejection', (reason, promise) => {
  logger.error('Unhandled Rejection at:', promise, 'reason:', reason);
  process.exit(1);
});

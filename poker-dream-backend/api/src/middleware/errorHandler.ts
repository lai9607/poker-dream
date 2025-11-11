import { Request, Response, NextFunction } from 'express';
import { ZodError } from 'zod';
import logger from '../utils/logger';
import { env } from '../config/env';

export class AppError extends Error {
  constructor(
    public statusCode: number,
    public message: string,
    public isOperational = true
  ) {
    super(message);
    Object.setPrototypeOf(this, AppError.prototype);
  }
}

export const errorHandler = (
  err: Error,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  logger.error(`Error: ${err.message}`, { error: err, path: req.path });

  // Zod validation errors
  if (err instanceof ZodError) {
    return res.status(400).json({
      error: 'Validation error',
      details: err.errors,
    });
  }

  // Application errors
  if (err instanceof AppError) {
    return res.status(err.statusCode).json({
      error: err.message,
    });
  }

  // Prisma errors
  if (err.name === 'PrismaClientKnownRequestError') {
    return res.status(400).json({
      error: 'Database error',
      message: env.NODE_ENV === 'development' ? err.message : 'An error occurred',
    });
  }

  // Default error
  return res.status(500).json({
    error: 'Internal server error',
    message: env.NODE_ENV === 'development' ? err.message : 'Something went wrong',
  });
};

export const notFoundHandler = (req: Request, res: Response) => {
  res.status(404).json({
    error: 'Not found',
    message: `Route ${req.originalUrl} not found`,
  });
};

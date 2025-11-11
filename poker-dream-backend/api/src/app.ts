import express, { Application } from 'express';
import cors from 'cors';
import helmet from 'helmet';
import cookieParser from 'cookie-parser';
import rateLimit from 'express-rate-limit';
import path from 'path';
import { env } from './config/env';
import { errorHandler, notFoundHandler } from './middleware/errorHandler';
import logger from './utils/logger';

// Import routes
import authRoutes from './modules/auth/auth.routes';
import tournamentRoutes from './modules/tournaments/tournaments.routes';
import newsRoutes from './modules/news/news.routes';
import videoRoutes from './modules/videos/videos.routes';
import uploadRoutes from './modules/upload/upload.routes';

const app: Application = express();

// Security middleware
app.use(helmet());
app.use(
  cors({
    origin: env.ALLOWED_ORIGINS.split(','),
    credentials: true,
  })
);

// Rate limiting
const limiter = rateLimit({
  windowMs: env.RATE_LIMIT_WINDOW_MS,
  max: env.RATE_LIMIT_MAX_REQUESTS,
  message: 'Too many requests from this IP, please try again later',
});
app.use('/api', limiter);

// Body parsing middleware
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));
app.use(cookieParser());

// Serve static files from uploads directory
app.use('/uploads', express.static(path.join(process.cwd(), 'uploads')));

// Request logging
app.use((req, res, next) => {
  logger.info(`${req.method} ${req.path}`, {
    method: req.method,
    path: req.path,
    ip: req.ip,
  });
  next();
});

// Health check
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    environment: env.NODE_ENV,
  });
});

// API routes
app.use('/api/auth', authRoutes);
app.use('/api/tournaments', tournamentRoutes);
app.use('/api/news', newsRoutes);
app.use('/api/videos', videoRoutes);
app.use('/api/upload', uploadRoutes);
// app.use('/api/players', playerRoutes);
// app.use('/api/standings', standingRoutes);
// app.use('/api/alerts', alertRoutes);
// app.use('/api/users', userRoutes);
// app.use('/api/sponsors', sponsorRoutes);

// 404 handler
app.use(notFoundHandler);

// Error handler (must be last)
app.use(errorHandler);

export default app;

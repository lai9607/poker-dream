import { Response, NextFunction } from 'express';
import { authService } from './auth.service';
import { registerSchema, loginSchema, refreshTokenSchema } from './auth.schema';
import { AuthRequest } from '../../middleware/auth';

export class AuthController {
  async register(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = registerSchema.parse(req.body);
      const result = await authService.register(validatedData);

      res.status(201).json({
        message: 'User registered successfully',
        data: result,
      });
    } catch (error) {
      next(error);
    }
  }

  async login(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = loginSchema.parse(req.body);
      const result = await authService.login(validatedData);

      res.status(200).json({
        message: 'Login successful',
        data: result,
      });
    } catch (error) {
      next(error);
    }
  }

  async refreshToken(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = refreshTokenSchema.parse(req.body);
      const result = await authService.refreshToken(validatedData.refreshToken);

      res.status(200).json({
        message: 'Token refreshed successfully',
        data: result,
      });
    } catch (error) {
      next(error);
    }
  }

  async getMe(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      if (!req.user) {
        return res.status(401).json({ error: 'Unauthorized' });
      }

      const user = await authService.getMe(req.user.userId);

      res.status(200).json({
        data: user,
      });
    } catch (error) {
      next(error);
    }
  }

  async logout(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      // In a production app, you might want to blacklist the token
      res.status(200).json({
        message: 'Logout successful',
      });
    } catch (error) {
      next(error);
    }
  }
}

export const authController = new AuthController();

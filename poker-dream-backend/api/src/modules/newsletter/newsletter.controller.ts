import { Response, NextFunction } from 'express';
import { newsletterService } from './newsletter.service';
import { subscribeSchema, unsubscribeSchema } from './newsletter.schema';
import { AuthRequest } from '../../middleware/auth';

export class NewsletterController {
  async subscribe(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = subscribeSchema.parse(req.body);
      const subscription = await newsletterService.subscribe(validatedData);

      res.status(201).json({
        message: 'Successfully subscribed to newsletter',
        data: {
          email: subscription.email,
          subscribedAt: subscription.subscribedAt,
        },
      });
    } catch (error) {
      next(error);
    }
  }

  async unsubscribe(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = unsubscribeSchema.parse(req.body);
      await newsletterService.unsubscribe(validatedData);

      res.status(200).json({
        message: 'Successfully unsubscribed from newsletter',
      });
    } catch (error) {
      next(error);
    }
  }

  async getSubscribers(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const isActive = req.query.isActive === 'true' ? true : req.query.isActive === 'false' ? false : undefined;
      const result = await newsletterService.getSubscribers(isActive);

      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }

  async getStats(_req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const stats = await newsletterService.getStats();

      res.status(200).json({
        data: stats,
      });
    } catch (error) {
      next(error);
    }
  }
}

export const newsletterController = new NewsletterController();

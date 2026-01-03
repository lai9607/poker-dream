import { prisma } from '../../config/database';
import { AppError } from '../../middleware/errorHandler';
import { SubscribeInput, UnsubscribeInput } from './newsletter.schema';

export class NewsletterService {
  async subscribe(data: SubscribeInput) {
    // Check if already subscribed
    const existing = await prisma.newsletterSubscription.findUnique({
      where: { email: data.email },
    });

    if (existing) {
      if (existing.isActive) {
        throw new AppError(400, 'Email is already subscribed');
      }
      // Reactivate subscription
      const subscription = await prisma.newsletterSubscription.update({
        where: { email: data.email },
        data: {
          isActive: true,
          unsubscribedAt: null,
          name: data.name,
        },
      });
      return subscription;
    }

    const subscription = await prisma.newsletterSubscription.create({
      data,
    });

    return subscription;
  }

  async unsubscribe(data: UnsubscribeInput) {
    const existing = await prisma.newsletterSubscription.findUnique({
      where: { email: data.email },
    });

    if (!existing) {
      throw new AppError(404, 'Email not found in subscription list');
    }

    if (!existing.isActive) {
      throw new AppError(400, 'Email is already unsubscribed');
    }

    const subscription = await prisma.newsletterSubscription.update({
      where: { email: data.email },
      data: {
        isActive: false,
        unsubscribedAt: new Date(),
      },
    });

    return subscription;
  }

  async getSubscribers(isActive?: boolean) {
    const where: any = {};
    if (isActive !== undefined) {
      where.isActive = isActive;
    }

    const [subscribers, total, active] = await Promise.all([
      prisma.newsletterSubscription.findMany({
        where,
        orderBy: { subscribedAt: 'desc' },
      }),
      prisma.newsletterSubscription.count(),
      prisma.newsletterSubscription.count({ where: { isActive: true } }),
    ]);

    return {
      data: subscribers,
      stats: {
        total,
        active,
        inactive: total - active,
      },
    };
  }

  async getStats() {
    const [total, active] = await Promise.all([
      prisma.newsletterSubscription.count(),
      prisma.newsletterSubscription.count({ where: { isActive: true } }),
    ]);

    return {
      total,
      active,
      inactive: total - active,
    };
  }
}

export const newsletterService = new NewsletterService();

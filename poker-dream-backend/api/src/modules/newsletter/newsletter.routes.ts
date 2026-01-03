import { Router } from 'express';
import { newsletterController } from './newsletter.controller';
import { authenticate, authorize } from '../../middleware/auth';

const router = Router();

// Public routes
router.post('/subscribe', newsletterController.subscribe.bind(newsletterController));
router.post('/unsubscribe', newsletterController.unsubscribe.bind(newsletterController));

// Protected routes (Admin only)
router.get(
  '/subscribers',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  newsletterController.getSubscribers.bind(newsletterController)
);

router.get(
  '/stats',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  newsletterController.getStats.bind(newsletterController)
);

export default router;

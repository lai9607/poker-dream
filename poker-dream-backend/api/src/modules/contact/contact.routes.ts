import { Router } from 'express';
import { contactController } from './contact.controller';
import { authenticate, authorize } from '../../middleware/auth';

const router = Router();

// Public routes
router.post('/', contactController.create.bind(contactController));

// Protected routes (Admin only)
router.get(
  '/',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  contactController.findAll.bind(contactController)
);

router.get(
  '/stats',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  contactController.getStats.bind(contactController)
);

router.get(
  '/:id',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  contactController.findById.bind(contactController)
);

router.put(
  '/:id/status',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  contactController.updateStatus.bind(contactController)
);

router.delete(
  '/:id',
  authenticate,
  authorize('SUPER_ADMIN'),
  contactController.delete.bind(contactController)
);

export default router;

import { Router } from 'express';
import { sponsorsController } from './sponsors.controller';
import { authenticate, authorize } from '../../middleware/auth';

const router = Router();

// Public routes
router.get('/', sponsorsController.findAll.bind(sponsorsController));
router.get('/:id', sponsorsController.findById.bind(sponsorsController));

// Protected routes (Admin only)
router.post(
  '/',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  sponsorsController.create.bind(sponsorsController)
);

router.put(
  '/reorder',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  sponsorsController.reorder.bind(sponsorsController)
);

router.put(
  '/:id',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  sponsorsController.update.bind(sponsorsController)
);

router.delete(
  '/:id',
  authenticate,
  authorize('SUPER_ADMIN'),
  sponsorsController.delete.bind(sponsorsController)
);

export default router;

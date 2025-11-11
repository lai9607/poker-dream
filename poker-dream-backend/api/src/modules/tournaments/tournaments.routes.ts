import { Router } from 'express';
import { tournamentsController } from './tournaments.controller';
import { authenticate, authorize } from '../../middleware/auth';

const router = Router();

// Public routes
router.get('/', tournamentsController.findAll.bind(tournamentsController));
router.get('/upcoming', tournamentsController.getUpcoming.bind(tournamentsController));
router.get('/live', tournamentsController.getLive.bind(tournamentsController));
router.get('/stats', tournamentsController.getStats.bind(tournamentsController));
router.get('/:id', tournamentsController.findById.bind(tournamentsController));

// Protected routes (Admin only)
router.post(
  '/',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  tournamentsController.create.bind(tournamentsController)
);

router.put(
  '/:id',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  tournamentsController.update.bind(tournamentsController)
);

router.delete(
  '/:id',
  authenticate,
  authorize('SUPER_ADMIN'),
  tournamentsController.delete.bind(tournamentsController)
);

export default router;

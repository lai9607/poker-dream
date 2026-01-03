import { Router } from 'express';
import { playersController } from './players.controller';
import { authenticate, authorize } from '../../middleware/auth';

const router = Router();

// Public routes
router.get('/', playersController.findAll.bind(playersController));
router.get('/leaderboard', playersController.getLeaderboard.bind(playersController));
router.get('/countries', playersController.getCountries.bind(playersController));
router.get('/:id', playersController.findById.bind(playersController));
router.get('/:id/stats', playersController.getPlayerStats.bind(playersController));

// Protected routes (Admin only)
router.post(
  '/',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  playersController.create.bind(playersController)
);

router.put(
  '/:id',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  playersController.update.bind(playersController)
);

router.delete(
  '/:id',
  authenticate,
  authorize('SUPER_ADMIN'),
  playersController.delete.bind(playersController)
);

export default router;

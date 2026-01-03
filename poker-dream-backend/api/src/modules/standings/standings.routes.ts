import { Router } from 'express';
import { standingsController } from './standings.controller';
import { authenticate, authorize } from '../../middleware/auth';

const router = Router();

// Public routes
router.get('/tournament/:tournamentId', standingsController.getByTournament.bind(standingsController));
router.get('/tournament/:tournamentId/live', standingsController.getLiveStandings.bind(standingsController));
router.get('/player/:playerId', standingsController.getByPlayer.bind(standingsController));
router.get('/:id', standingsController.findById.bind(standingsController));

// Protected routes (Admin only)
router.post(
  '/',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  standingsController.create.bind(standingsController)
);

router.post(
  '/bulk',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  standingsController.bulkCreate.bind(standingsController)
);

router.put(
  '/:id',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  standingsController.update.bind(standingsController)
);

router.delete(
  '/:id',
  authenticate,
  authorize('SUPER_ADMIN'),
  standingsController.delete.bind(standingsController)
);

export default router;

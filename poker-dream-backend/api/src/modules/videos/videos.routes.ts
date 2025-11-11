import { Router } from 'express';
import { VideosController } from './videos.controller';
import { authenticate, authorize } from '../../middleware/auth';

const router = Router();
const videosController = new VideosController();

// Public routes
router.get('/', videosController.findAll.bind(videosController));
router.get('/:id', videosController.findById.bind(videosController));
router.post('/:id/view', videosController.incrementViewCount.bind(videosController));

// Protected routes (admin only)
router.post('/', authenticate, authorize(['ADMIN', 'SUPER_ADMIN']), videosController.create.bind(videosController));
router.put('/:id', authenticate, authorize(['ADMIN', 'SUPER_ADMIN']), videosController.update.bind(videosController));
router.delete('/:id', authenticate, authorize(['ADMIN', 'SUPER_ADMIN']), videosController.delete.bind(videosController));

export default router;

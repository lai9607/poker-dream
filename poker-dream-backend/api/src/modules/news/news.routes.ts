import { Router } from 'express';
import { NewsController } from './news.controller';
import { authenticate, authorize } from '../../middleware/auth';

const router = Router();
const newsController = new NewsController();

// Public routes
router.get('/', newsController.findAll.bind(newsController));
router.get('/:id', newsController.findById.bind(newsController));

// Protected routes (admin only)
router.post('/', authenticate, authorize(['ADMIN', 'SUPER_ADMIN', 'EDITOR']), newsController.create.bind(newsController));
router.put('/:id', authenticate, authorize(['ADMIN', 'SUPER_ADMIN', 'EDITOR']), newsController.update.bind(newsController));
router.delete('/:id', authenticate, authorize(['ADMIN', 'SUPER_ADMIN']), newsController.delete.bind(newsController));

export default router;

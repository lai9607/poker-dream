import { Router } from 'express';
import { galleriesController } from './galleries.controller';
import { authenticate, authorize } from '../../middleware/auth';

const router = Router();

// Public routes
router.get('/', galleriesController.findAllGalleries.bind(galleriesController));
router.get('/type/:type', galleriesController.findByType.bind(galleriesController));
router.get('/:id', galleriesController.findGalleryById.bind(galleriesController));

// Protected routes (Admin only)
router.post(
  '/',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  galleriesController.createGallery.bind(galleriesController)
);

router.put(
  '/:id',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  galleriesController.updateGallery.bind(galleriesController)
);

router.delete(
  '/:id',
  authenticate,
  authorize('SUPER_ADMIN'),
  galleriesController.deleteGallery.bind(galleriesController)
);

// Photo routes
router.post(
  '/photos',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  galleriesController.addPhoto.bind(galleriesController)
);

router.post(
  '/photos/bulk',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  galleriesController.bulkAddPhotos.bind(galleriesController)
);

router.put(
  '/photos/:id',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  galleriesController.updatePhoto.bind(galleriesController)
);

router.delete(
  '/photos/:id',
  authenticate,
  authorize('SUPER_ADMIN'),
  galleriesController.deletePhoto.bind(galleriesController)
);

router.put(
  '/:galleryId/reorder',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  galleriesController.reorderPhotos.bind(galleriesController)
);

export default router;

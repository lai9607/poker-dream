import { Router } from 'express';
import { UploadController } from './upload.controller';
import { upload } from './upload.middleware';

const router = Router();
const uploadController = new UploadController();

// Upload single image
router.post('/image', upload.single('image'), uploadController.uploadImage);

// Delete image
router.delete('/image/:filename', uploadController.deleteImage);

export default router;

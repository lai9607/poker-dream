import { Response, NextFunction } from 'express';
import { galleriesService } from './galleries.service';
import {
  createGallerySchema,
  updateGallerySchema,
  createPhotoSchema,
  updatePhotoSchema,
  bulkCreatePhotosSchema,
  galleryQuerySchema
} from './galleries.schema';
import { AuthRequest } from '../../middleware/auth';
import { z } from 'zod';

export class GalleriesController {
  async createGallery(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = createGallerySchema.parse(req.body);
      const gallery = await galleriesService.createGallery(validatedData);

      res.status(201).json({
        message: 'Gallery created successfully',
        data: gallery,
      });
    } catch (error) {
      next(error);
    }
  }

  async findAllGalleries(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const query = galleryQuerySchema.parse(req.query);
      const result = await galleriesService.findAllGalleries(query);

      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }

  async findGalleryById(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const gallery = await galleriesService.findGalleryById(req.params.id);

      res.status(200).json({
        data: gallery,
      });
    } catch (error) {
      next(error);
    }
  }

  async findByType(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const galleries = await galleriesService.findByType(req.params.type.toUpperCase());

      res.status(200).json({
        data: galleries,
      });
    } catch (error) {
      next(error);
    }
  }

  async updateGallery(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = updateGallerySchema.parse(req.body);
      const gallery = await galleriesService.updateGallery(req.params.id, validatedData);

      res.status(200).json({
        message: 'Gallery updated successfully',
        data: gallery,
      });
    } catch (error) {
      next(error);
    }
  }

  async deleteGallery(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      await galleriesService.deleteGallery(req.params.id);

      res.status(200).json({
        message: 'Gallery deleted successfully',
      });
    } catch (error) {
      next(error);
    }
  }

  async addPhoto(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = createPhotoSchema.parse(req.body);
      const photo = await galleriesService.addPhoto(validatedData);

      res.status(201).json({
        message: 'Photo added successfully',
        data: photo,
      });
    } catch (error) {
      next(error);
    }
  }

  async bulkAddPhotos(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = bulkCreatePhotosSchema.parse(req.body);
      const gallery = await galleriesService.bulkAddPhotos(validatedData);

      res.status(201).json({
        message: 'Photos added successfully',
        data: gallery,
      });
    } catch (error) {
      next(error);
    }
  }

  async updatePhoto(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = updatePhotoSchema.parse(req.body);
      const photo = await galleriesService.updatePhoto(req.params.id, validatedData);

      res.status(200).json({
        message: 'Photo updated successfully',
        data: photo,
      });
    } catch (error) {
      next(error);
    }
  }

  async deletePhoto(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      await galleriesService.deletePhoto(req.params.id);

      res.status(200).json({
        message: 'Photo deleted successfully',
      });
    } catch (error) {
      next(error);
    }
  }

  async reorderPhotos(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const schema = z.object({
        photoIds: z.array(z.string().uuid()),
      });
      const { photoIds } = schema.parse(req.body);
      const gallery = await galleriesService.reorderPhotos(req.params.galleryId, photoIds);

      res.status(200).json({
        message: 'Photos reordered successfully',
        data: gallery,
      });
    } catch (error) {
      next(error);
    }
  }
}

export const galleriesController = new GalleriesController();

import { z } from 'zod';

export const createGallerySchema = z.object({
  type: z.enum(['TOURNAMENT', 'CHAMPION', 'EVENT', 'GENERAL']),
  title: z.string().min(2, 'Title must be at least 2 characters'),
  description: z.string().optional(),
  date: z.string().datetime().optional(),
});

export const updateGallerySchema = createGallerySchema.partial();

export const createPhotoSchema = z.object({
  galleryId: z.string().uuid('Invalid gallery ID'),
  imageUrl: z.string().url('Invalid image URL'),
  caption: z.string().optional(),
  displayOrder: z.number().int().min(0).default(0),
});

export const updatePhotoSchema = z.object({
  imageUrl: z.string().url('Invalid image URL').optional(),
  caption: z.string().optional(),
  displayOrder: z.number().int().min(0).optional(),
});

export const bulkCreatePhotosSchema = z.object({
  galleryId: z.string().uuid('Invalid gallery ID'),
  photos: z.array(z.object({
    imageUrl: z.string().url('Invalid image URL'),
    caption: z.string().optional(),
    displayOrder: z.number().int().min(0).optional(),
  })),
});

export const galleryQuerySchema = z.object({
  type: z.enum(['TOURNAMENT', 'CHAMPION', 'EVENT', 'GENERAL']).optional(),
  page: z.string().transform(Number).default('1'),
  limit: z.string().transform(Number).default('10'),
});

export type CreateGalleryInput = z.infer<typeof createGallerySchema>;
export type UpdateGalleryInput = z.infer<typeof updateGallerySchema>;
export type CreatePhotoInput = z.infer<typeof createPhotoSchema>;
export type UpdatePhotoInput = z.infer<typeof updatePhotoSchema>;
export type BulkCreatePhotosInput = z.infer<typeof bulkCreatePhotosSchema>;
export type GalleryQueryInput = z.infer<typeof galleryQuerySchema>;

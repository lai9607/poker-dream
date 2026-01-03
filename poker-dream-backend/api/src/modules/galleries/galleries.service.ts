import { prisma } from '../../config/database';
import { AppError } from '../../middleware/errorHandler';
import {
  CreateGalleryInput,
  UpdateGalleryInput,
  CreatePhotoInput,
  UpdatePhotoInput,
  BulkCreatePhotosInput,
  GalleryQueryInput
} from './galleries.schema';

export class GalleriesService {
  async createGallery(data: CreateGalleryInput) {
    const gallery = await prisma.gallery.create({
      data: {
        ...data,
        date: data.date ? new Date(data.date) : undefined,
      },
    });
    return gallery;
  }

  async findAllGalleries(query: GalleryQueryInput) {
    const { type, page, limit } = query;
    const skip = (page - 1) * limit;

    const where: any = {};
    if (type) {
      where.type = type;
    }

    const [galleries, total] = await Promise.all([
      prisma.gallery.findMany({
        where,
        skip,
        take: limit,
        orderBy: { date: 'desc' },
        include: {
          photos: {
            take: 4,
            orderBy: { displayOrder: 'asc' },
          },
          _count: {
            select: {
              photos: true,
            },
          },
        },
      }),
      prisma.gallery.count({ where }),
    ]);

    return {
      data: galleries,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findGalleryById(id: string) {
    const gallery = await prisma.gallery.findUnique({
      where: { id },
      include: {
        photos: {
          orderBy: { displayOrder: 'asc' },
        },
      },
    });

    if (!gallery) {
      throw new AppError(404, 'Gallery not found');
    }

    return gallery;
  }

  async findByType(type: string) {
    const galleries = await prisma.gallery.findMany({
      where: { type: type as any },
      orderBy: { date: 'desc' },
      include: {
        photos: {
          orderBy: { displayOrder: 'asc' },
        },
        _count: {
          select: {
            photos: true,
          },
        },
      },
    });

    return galleries;
  }

  async updateGallery(id: string, data: UpdateGalleryInput) {
    const exists = await prisma.gallery.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Gallery not found');
    }

    const gallery = await prisma.gallery.update({
      where: { id },
      data: {
        ...data,
        date: data.date ? new Date(data.date) : undefined,
      },
    });

    return gallery;
  }

  async deleteGallery(id: string) {
    const exists = await prisma.gallery.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Gallery not found');
    }

    await prisma.gallery.delete({
      where: { id },
    });
  }

  async addPhoto(data: CreatePhotoInput) {
    const gallery = await prisma.gallery.findUnique({
      where: { id: data.galleryId },
    });

    if (!gallery) {
      throw new AppError(404, 'Gallery not found');
    }

    const photo = await prisma.galleryPhoto.create({
      data,
    });

    return photo;
  }

  async bulkAddPhotos(data: BulkCreatePhotosInput) {
    const gallery = await prisma.gallery.findUnique({
      where: { id: data.galleryId },
    });

    if (!gallery) {
      throw new AppError(404, 'Gallery not found');
    }

    // Get current max displayOrder
    const lastPhoto = await prisma.galleryPhoto.findFirst({
      where: { galleryId: data.galleryId },
      orderBy: { displayOrder: 'desc' },
    });

    const startOrder = lastPhoto ? lastPhoto.displayOrder + 1 : 0;

    await prisma.galleryPhoto.createMany({
      data: data.photos.map((photo, index) => ({
        galleryId: data.galleryId,
        imageUrl: photo.imageUrl,
        caption: photo.caption,
        displayOrder: photo.displayOrder ?? startOrder + index,
      })),
    });

    return this.findGalleryById(data.galleryId);
  }

  async updatePhoto(id: string, data: UpdatePhotoInput) {
    const exists = await prisma.galleryPhoto.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Photo not found');
    }

    const photo = await prisma.galleryPhoto.update({
      where: { id },
      data,
    });

    return photo;
  }

  async deletePhoto(id: string) {
    const exists = await prisma.galleryPhoto.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Photo not found');
    }

    await prisma.galleryPhoto.delete({
      where: { id },
    });
  }

  async reorderPhotos(galleryId: string, photoIds: string[]) {
    const gallery = await prisma.gallery.findUnique({
      where: { id: galleryId },
    });

    if (!gallery) {
      throw new AppError(404, 'Gallery not found');
    }

    const updates = photoIds.map((id, index) =>
      prisma.galleryPhoto.update({
        where: { id },
        data: { displayOrder: index },
      })
    );

    await prisma.$transaction(updates);

    return this.findGalleryById(galleryId);
  }
}

export const galleriesService = new GalleriesService();

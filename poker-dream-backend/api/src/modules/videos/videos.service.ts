import { prisma } from '../../config/database';
import { AppError } from '../../middleware/errorHandler';
import { CreateVideoInput, UpdateVideoInput, VideoQueryInput } from './videos.schema';

export class VideosService {
  async create(data: CreateVideoInput) {
    const video = await prisma.videoHighlight.create({
      data,
      include: {
        tournament: true,
      },
    });
    return video;
  }

  async findAll(query: VideoQueryInput) {
    const { page, limit, tournamentId } = query;
    const skip = (page - 1) * limit;

    const where: any = {};

    if (tournamentId) {
      where.tournamentId = tournamentId;
    }

    const [videos, total] = await Promise.all([
      prisma.videoHighlight.findMany({
        where,
        skip,
        take: limit,
        orderBy: { publishedAt: 'desc' },
        include: {
          tournament: {
            select: {
              id: true,
              name: true,
            },
          },
        },
      }),
      prisma.videoHighlight.count({ where }),
    ]);

    return {
      data: videos,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findById(id: string) {
    const video = await prisma.videoHighlight.findUnique({
      where: { id },
      include: {
        tournament: {
          select: {
            id: true,
            name: true,
          },
        },
      },
    });

    if (!video) {
      throw new AppError('Video not found', 404);
    }

    return video;
  }

  async update(id: string, data: UpdateVideoInput) {
    try {
      const video = await prisma.videoHighlight.update({
        where: { id },
        data,
        include: {
          tournament: true,
        },
      });
      return video;
    } catch (error) {
      throw new AppError('Video not found', 404);
    }
  }

  async delete(id: string) {
    try {
      await prisma.videoHighlight.delete({
        where: { id },
      });
    } catch (error) {
      throw new AppError('Video not found', 404);
    }
  }

  async incrementViewCount(id: string) {
    const video = await prisma.videoHighlight.update({
      where: { id },
      data: {
        viewCount: {
          increment: 1,
        },
      },
    });
    return video;
  }
}

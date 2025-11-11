import { prisma } from '../../config/database';
import { AppError } from '../../middleware/errorHandler';
import { CreateNewsInput, UpdateNewsInput, NewsQueryInput } from './news.schema';

export class NewsService {
  async create(data: CreateNewsInput) {
    const news = await prisma.newsArticle.create({
      data: {
        ...data,
        publishedAt: data.publishedAt ? new Date(data.publishedAt) : data.isPublished ? new Date() : null,
      },
    });
    return news;
  }

  async findAll(query: NewsQueryInput) {
    const { page, limit, category, isPublished, search } = query;
    const skip = (page - 1) * limit;

    const where: any = {};

    if (category) {
      where.category = category;
    }

    if (isPublished !== undefined) {
      where.isPublished = isPublished;
    }

    if (search) {
      where.OR = [
        { title: { contains: search, mode: 'insensitive' } },
        { summary: { contains: search, mode: 'insensitive' } },
        { content: { contains: search, mode: 'insensitive' } },
      ];
    }

    const [news, total] = await Promise.all([
      prisma.newsArticle.findMany({
        where,
        skip,
        take: limit,
        orderBy: { publishedAt: 'desc' },
      }),
      prisma.newsArticle.count({ where }),
    ]);

    return {
      data: news,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findById(id: string) {
    const news = await prisma.newsArticle.findUnique({
      where: { id },
    });

    if (!news) {
      throw new AppError('News article not found', 404);
    }

    return news;
  }

  async update(id: string, data: UpdateNewsInput) {
    try {
      const news = await prisma.newsArticle.update({
        where: { id },
        data: {
          ...data,
          publishedAt: data.publishedAt ? new Date(data.publishedAt) : undefined,
        },
      });
      return news;
    } catch (error) {
      throw new AppError('News article not found', 404);
    }
  }

  async delete(id: string) {
    try {
      await prisma.newsArticle.delete({
        where: { id },
      });
    } catch (error) {
      throw new AppError('News article not found', 404);
    }
  }
}

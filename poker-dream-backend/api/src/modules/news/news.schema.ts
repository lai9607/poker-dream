import { z } from 'zod';

export const createNewsSchema = z.object({
  title: z.string().min(3, 'Title must be at least 3 characters'),
  summary: z.string().optional(),
  content: z.string().min(10, 'Content must be at least 10 characters'),
  imageUrl: z.string().url('Must be a valid URL').optional(),
  category: z.enum(['TOURNAMENTS', 'INDUSTRY', 'STRATEGY', 'PLAYER_INTERVIEW', 'GENERAL']).default('GENERAL'),
  author: z.string().optional(),
  isPublished: z.boolean().default(false),
  publishedAt: z.string().datetime().optional(),
});

export const updateNewsSchema = createNewsSchema.partial();

export const newsQuerySchema = z.object({
  page: z.string().transform(Number).default('1'),
  limit: z.string().transform(Number).default('10'),
  category: z.enum(['TOURNAMENTS', 'INDUSTRY', 'STRATEGY', 'PLAYER_INTERVIEW', 'GENERAL']).optional().or(z.literal('')).transform(val => val === '' ? undefined : val),
  isPublished: z.string().transform(val => val === 'true' ? true : val === 'false' ? false : undefined).optional(),
  search: z.string().optional().or(z.literal('')).transform(val => val === '' ? undefined : val),
});

export type CreateNewsInput = z.infer<typeof createNewsSchema>;
export type UpdateNewsInput = z.infer<typeof updateNewsSchema>;
export type NewsQueryInput = z.infer<typeof newsQuerySchema>;

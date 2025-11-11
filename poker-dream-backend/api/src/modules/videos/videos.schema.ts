import { z } from 'zod';

export const createVideoSchema = z.object({
  title: z.string().min(3, 'Title must be at least 3 characters'),
  description: z.string().optional(),
  videoUrl: z.string().url('Must be a valid URL'),
  thumbnailUrl: z.string().url('Must be a valid URL').optional(),
  durationSeconds: z.number().int().positive().optional(),
  tournamentId: z.string().uuid().optional(),
});

export const updateVideoSchema = createVideoSchema.partial();

export const videoQuerySchema = z.object({
  page: z.string().transform(Number).default('1'),
  limit: z.string().transform(Number).default('10'),
  tournamentId: z.string().uuid().optional().or(z.literal('')).transform(val => val === '' ? undefined : val),
});

export type CreateVideoInput = z.infer<typeof createVideoSchema>;
export type UpdateVideoInput = z.infer<typeof updateVideoSchema>;
export type VideoQueryInput = z.infer<typeof videoQuerySchema>;

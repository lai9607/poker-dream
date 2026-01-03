import { z } from 'zod';

export const createPlayerSchema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  country: z.string().optional(),
  countryCode: z.string().length(2, 'Country code must be 2 characters').optional(),
  flagUrl: z.string().url().optional(),
  profileImageUrl: z.string().url().optional(),
  bio: z.string().optional(),
});

export const updatePlayerSchema = createPlayerSchema.partial();

export const playerQuerySchema = z.object({
  page: z.string().transform(Number).default('1'),
  limit: z.string().transform(Number).default('10'),
  search: z.string().optional().or(z.literal('')).transform(val => val === '' ? undefined : val),
  country: z.string().optional().or(z.literal('')).transform(val => val === '' ? undefined : val),
});

export const leaderboardQuerySchema = z.object({
  page: z.string().transform(Number).default('1'),
  limit: z.string().transform(Number).default('50'),
  year: z.string().optional().or(z.literal('')).transform(val => val === '' ? undefined : val),
});

export type CreatePlayerInput = z.infer<typeof createPlayerSchema>;
export type UpdatePlayerInput = z.infer<typeof updatePlayerSchema>;
export type PlayerQueryInput = z.infer<typeof playerQuerySchema>;
export type LeaderboardQueryInput = z.infer<typeof leaderboardQuerySchema>;

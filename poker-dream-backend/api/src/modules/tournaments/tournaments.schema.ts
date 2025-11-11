import { z } from 'zod';

export const createTournamentSchema = z.object({
  name: z.string().min(3, 'Name must be at least 3 characters'),
  description: z.string().optional(),
  startDate: z.string().datetime().optional(),
  endDate: z.string().datetime().optional(),
  location: z.string().optional(),
  venue: z.string().optional(),
  status: z.enum(['UPCOMING', 'LIVE', 'COMPLETED', 'CANCELLED']).default('UPCOMING'),
  prizePool: z.number().positive().optional(),
  buyIn: z.number().positive().optional(),
  totalEntries: z.number().int().min(0).default(0),
  bannerImageUrl: z.string().url().optional(),
});

export const updateTournamentSchema = createTournamentSchema.partial();

export const tournamentQuerySchema = z.object({
  status: z.enum(['UPCOMING', 'LIVE', 'COMPLETED', 'CANCELLED']).optional().or(z.literal('')).transform(val => val === '' ? undefined : val),
  page: z.string().transform(Number).default('1'),
  limit: z.string().transform(Number).default('10'),
  search: z.string().optional().or(z.literal('')).transform(val => val === '' ? undefined : val),
});

export type CreateTournamentInput = z.infer<typeof createTournamentSchema>;
export type UpdateTournamentInput = z.infer<typeof updateTournamentSchema>;
export type TournamentQueryInput = z.infer<typeof tournamentQuerySchema>;

import { z } from 'zod';

export const createStandingSchema = z.object({
  tournamentId: z.string().uuid('Invalid tournament ID'),
  playerId: z.string().uuid('Invalid player ID'),
  rank: z.number().int().positive('Rank must be a positive number'),
  chips: z.number().int().min(0, 'Chips cannot be negative'),
  isSurvivor: z.boolean().default(false),
  prizeAmount: z.number().min(0).optional(),
});

export const updateStandingSchema = z.object({
  rank: z.number().int().positive('Rank must be a positive number').optional(),
  chips: z.number().int().min(0, 'Chips cannot be negative').optional(),
  isSurvivor: z.boolean().optional(),
  prizeAmount: z.number().min(0).optional(),
});

export const bulkCreateStandingsSchema = z.object({
  tournamentId: z.string().uuid('Invalid tournament ID'),
  standings: z.array(z.object({
    playerId: z.string().uuid('Invalid player ID'),
    rank: z.number().int().positive(),
    chips: z.number().int().min(0),
    isSurvivor: z.boolean().default(false),
    prizeAmount: z.number().min(0).optional(),
  })),
});

export const standingsQuerySchema = z.object({
  tournamentId: z.string().uuid().optional(),
  playerId: z.string().uuid().optional(),
  page: z.string().transform(Number).default('1'),
  limit: z.string().transform(Number).default('50'),
});

export type CreateStandingInput = z.infer<typeof createStandingSchema>;
export type UpdateStandingInput = z.infer<typeof updateStandingSchema>;
export type BulkCreateStandingsInput = z.infer<typeof bulkCreateStandingsSchema>;
export type StandingsQueryInput = z.infer<typeof standingsQuerySchema>;

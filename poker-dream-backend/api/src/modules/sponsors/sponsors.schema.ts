import { z } from 'zod';

export const createSponsorSchema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  logoUrl: z.string().url('Invalid logo URL'),
  websiteUrl: z.string().url('Invalid website URL').optional(),
  displayOrder: z.number().int().min(0).default(0),
  isActive: z.boolean().default(true),
});

export const updateSponsorSchema = createSponsorSchema.partial();

export const sponsorQuerySchema = z.object({
  isActive: z.string().optional().transform(val => val === 'true' ? true : val === 'false' ? false : undefined),
});

export type CreateSponsorInput = z.infer<typeof createSponsorSchema>;
export type UpdateSponsorInput = z.infer<typeof updateSponsorSchema>;
export type SponsorQueryInput = z.infer<typeof sponsorQuerySchema>;

import { z } from 'zod';

export const createContactSchema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  email: z.string().email('Invalid email address'),
  company: z.string().optional(),
  subject: z.string().min(5, 'Subject must be at least 5 characters'),
  message: z.string().min(10, 'Message must be at least 10 characters'),
  type: z.enum(['GENERAL', 'PARTNERSHIP', 'MEDIA', 'CAREER', 'SUPPORT']).default('GENERAL'),
});

export const updateContactStatusSchema = z.object({
  status: z.enum(['NEW', 'IN_PROGRESS', 'RESOLVED', 'ARCHIVED']),
});

export const contactQuerySchema = z.object({
  status: z.enum(['NEW', 'IN_PROGRESS', 'RESOLVED', 'ARCHIVED']).optional(),
  type: z.enum(['GENERAL', 'PARTNERSHIP', 'MEDIA', 'CAREER', 'SUPPORT']).optional(),
  page: z.string().transform(Number).default('1'),
  limit: z.string().transform(Number).default('20'),
});

export type CreateContactInput = z.infer<typeof createContactSchema>;
export type UpdateContactStatusInput = z.infer<typeof updateContactStatusSchema>;
export type ContactQueryInput = z.infer<typeof contactQuerySchema>;

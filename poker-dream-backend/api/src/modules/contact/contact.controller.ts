import { Response, NextFunction } from 'express';
import { contactService } from './contact.service';
import { createContactSchema, updateContactStatusSchema, contactQuerySchema } from './contact.schema';
import { AuthRequest } from '../../middleware/auth';

export class ContactController {
  async create(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = createContactSchema.parse(req.body);
      const submission = await contactService.create(validatedData);

      res.status(201).json({
        message: 'Your message has been received. We will get back to you soon.',
        data: {
          id: submission.id,
          createdAt: submission.createdAt,
        },
      });
    } catch (error) {
      next(error);
    }
  }

  async findAll(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const query = contactQuerySchema.parse(req.query);
      const result = await contactService.findAll(query);

      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }

  async findById(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const submission = await contactService.findById(req.params.id);

      res.status(200).json({
        data: submission,
      });
    } catch (error) {
      next(error);
    }
  }

  async updateStatus(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = updateContactStatusSchema.parse(req.body);
      const submission = await contactService.updateStatus(req.params.id, validatedData);

      res.status(200).json({
        message: 'Contact status updated successfully',
        data: submission,
      });
    } catch (error) {
      next(error);
    }
  }

  async delete(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      await contactService.delete(req.params.id);

      res.status(200).json({
        message: 'Contact submission deleted successfully',
      });
    } catch (error) {
      next(error);
    }
  }

  async getStats(_req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const stats = await contactService.getStats();

      res.status(200).json({
        data: stats,
      });
    } catch (error) {
      next(error);
    }
  }
}

export const contactController = new ContactController();

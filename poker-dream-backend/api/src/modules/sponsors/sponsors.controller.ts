import { Response, NextFunction } from 'express';
import { sponsorsService } from './sponsors.service';
import { createSponsorSchema, updateSponsorSchema, sponsorQuerySchema } from './sponsors.schema';
import { AuthRequest } from '../../middleware/auth';
import { z } from 'zod';

export class SponsorsController {
  async create(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = createSponsorSchema.parse(req.body);
      const sponsor = await sponsorsService.create(validatedData);

      res.status(201).json({
        message: 'Sponsor created successfully',
        data: sponsor,
      });
    } catch (error) {
      next(error);
    }
  }

  async findAll(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const query = sponsorQuerySchema.parse(req.query);
      const sponsors = await sponsorsService.findAll(query);

      res.status(200).json({
        data: sponsors,
      });
    } catch (error) {
      next(error);
    }
  }

  async findById(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const sponsor = await sponsorsService.findById(req.params.id);

      res.status(200).json({
        data: sponsor,
      });
    } catch (error) {
      next(error);
    }
  }

  async update(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = updateSponsorSchema.parse(req.body);
      const sponsor = await sponsorsService.update(req.params.id, validatedData);

      res.status(200).json({
        message: 'Sponsor updated successfully',
        data: sponsor,
      });
    } catch (error) {
      next(error);
    }
  }

  async delete(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      await sponsorsService.delete(req.params.id);

      res.status(200).json({
        message: 'Sponsor deleted successfully',
      });
    } catch (error) {
      next(error);
    }
  }

  async reorder(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const schema = z.object({
        sponsorIds: z.array(z.string().uuid()),
      });
      const { sponsorIds } = schema.parse(req.body);
      const sponsors = await sponsorsService.reorder(sponsorIds);

      res.status(200).json({
        message: 'Sponsors reordered successfully',
        data: sponsors,
      });
    } catch (error) {
      next(error);
    }
  }
}

export const sponsorsController = new SponsorsController();

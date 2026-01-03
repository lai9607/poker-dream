import { Response, NextFunction } from 'express';
import { standingsService } from './standings.service';
import { createStandingSchema, updateStandingSchema, bulkCreateStandingsSchema } from './standings.schema';
import { AuthRequest } from '../../middleware/auth';

export class StandingsController {
  async create(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = createStandingSchema.parse(req.body);
      const standing = await standingsService.create(validatedData);

      res.status(201).json({
        message: 'Standing created successfully',
        data: standing,
      });
    } catch (error) {
      next(error);
    }
  }

  async bulkCreate(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = bulkCreateStandingsSchema.parse(req.body);
      const standings = await standingsService.bulkCreate(validatedData);

      res.status(201).json({
        message: 'Standings created successfully',
        data: standings,
      });
    } catch (error) {
      next(error);
    }
  }

  async findById(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const standing = await standingsService.findById(req.params.id);

      res.status(200).json({
        data: standing,
      });
    } catch (error) {
      next(error);
    }
  }

  async update(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = updateStandingSchema.parse(req.body);
      const standing = await standingsService.update(req.params.id, validatedData);

      res.status(200).json({
        message: 'Standing updated successfully',
        data: standing,
      });
    } catch (error) {
      next(error);
    }
  }

  async delete(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      await standingsService.delete(req.params.id);

      res.status(200).json({
        message: 'Standing deleted successfully',
      });
    } catch (error) {
      next(error);
    }
  }

  async getByTournament(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const limit = req.query.limit ? Number(req.query.limit) : 100;
      const standings = await standingsService.getByTournament(req.params.tournamentId, limit);

      res.status(200).json({
        data: standings,
      });
    } catch (error) {
      next(error);
    }
  }

  async getByPlayer(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const standings = await standingsService.getByPlayer(req.params.playerId);

      res.status(200).json({
        data: standings,
      });
    } catch (error) {
      next(error);
    }
  }

  async getLiveStandings(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const result = await standingsService.getLiveStandings(req.params.tournamentId);

      res.status(200).json({
        data: result,
      });
    } catch (error) {
      next(error);
    }
  }
}

export const standingsController = new StandingsController();

import { Response, NextFunction } from 'express';
import { tournamentsService } from './tournaments.service';
import { createTournamentSchema, updateTournamentSchema, tournamentQuerySchema } from './tournaments.schema';
import { AuthRequest } from '../../middleware/auth';

export class TournamentsController {
  async create(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = createTournamentSchema.parse(req.body);
      const tournament = await tournamentsService.create(validatedData);

      res.status(201).json({
        message: 'Tournament created successfully',
        data: tournament,
      });
    } catch (error) {
      next(error);
    }
  }

  async findAll(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const query = tournamentQuerySchema.parse(req.query);
      const result = await tournamentsService.findAll(query);

      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }

  async findById(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const tournament = await tournamentsService.findById(req.params.id);

      res.status(200).json({
        data: tournament,
      });
    } catch (error) {
      next(error);
    }
  }

  async update(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = updateTournamentSchema.parse(req.body);
      const tournament = await tournamentsService.update(req.params.id, validatedData);

      res.status(200).json({
        message: 'Tournament updated successfully',
        data: tournament,
      });
    } catch (error) {
      next(error);
    }
  }

  async delete(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      await tournamentsService.delete(req.params.id);

      res.status(200).json({
        message: 'Tournament deleted successfully',
      });
    } catch (error) {
      next(error);
    }
  }

  async getUpcoming(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const limit = req.query.limit ? Number(req.query.limit) : 10;
      const tournaments = await tournamentsService.getUpcoming(limit);

      res.status(200).json({
        data: tournaments,
      });
    } catch (error) {
      next(error);
    }
  }

  async getLive(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const tournaments = await tournamentsService.getLive();

      res.status(200).json({
        data: tournaments,
      });
    } catch (error) {
      next(error);
    }
  }

  async getStats(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const stats = await tournamentsService.getStats();

      res.status(200).json({
        data: stats,
      });
    } catch (error) {
      next(error);
    }
  }
}

export const tournamentsController = new TournamentsController();

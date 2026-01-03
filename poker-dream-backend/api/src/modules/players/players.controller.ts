import { Response, NextFunction } from 'express';
import { playersService } from './players.service';
import { createPlayerSchema, updatePlayerSchema, playerQuerySchema, leaderboardQuerySchema } from './players.schema';
import { AuthRequest } from '../../middleware/auth';

export class PlayersController {
  async create(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = createPlayerSchema.parse(req.body);
      const player = await playersService.create(validatedData);

      res.status(201).json({
        message: 'Player created successfully',
        data: player,
      });
    } catch (error) {
      next(error);
    }
  }

  async findAll(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const query = playerQuerySchema.parse(req.query);
      const result = await playersService.findAll(query);

      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }

  async findById(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const player = await playersService.findById(req.params.id);

      res.status(200).json({
        data: player,
      });
    } catch (error) {
      next(error);
    }
  }

  async update(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = updatePlayerSchema.parse(req.body);
      const player = await playersService.update(req.params.id, validatedData);

      res.status(200).json({
        message: 'Player updated successfully',
        data: player,
      });
    } catch (error) {
      next(error);
    }
  }

  async delete(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      await playersService.delete(req.params.id);

      res.status(200).json({
        message: 'Player deleted successfully',
      });
    } catch (error) {
      next(error);
    }
  }

  async getLeaderboard(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const query = leaderboardQuerySchema.parse(req.query);
      const result = await playersService.getLeaderboard(query);

      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }

  async getPlayerStats(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const year = req.query.year as string | undefined;
      const result = await playersService.getPlayerStats(req.params.id, year);

      res.status(200).json({
        data: result,
      });
    } catch (error) {
      next(error);
    }
  }

  async getCountries(_req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const countries = await playersService.getCountries();

      res.status(200).json({
        data: countries,
      });
    } catch (error) {
      next(error);
    }
  }
}

export const playersController = new PlayersController();

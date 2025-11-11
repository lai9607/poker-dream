import { Request, Response, NextFunction } from 'express';
import { VideosService } from './videos.service';
import { createVideoSchema, updateVideoSchema, videoQuerySchema } from './videos.schema';

const videosService = new VideosService();

export class VideosController {
  async create(req: Request, res: Response, next: NextFunction) {
    try {
      const validatedData = createVideoSchema.parse(req.body);
      const video = await videosService.create(validatedData);
      res.status(201).json(video);
    } catch (error) {
      next(error);
    }
  }

  async findAll(req: Request, res: Response, next: NextFunction) {
    try {
      const validatedQuery = videoQuerySchema.parse(req.query);
      const result = await videosService.findAll(validatedQuery);
      res.json(result);
    } catch (error) {
      next(error);
    }
  }

  async findById(req: Request, res: Response, next: NextFunction) {
    try {
      const video = await videosService.findById(req.params.id);
      res.json(video);
    } catch (error) {
      next(error);
    }
  }

  async update(req: Request, res: Response, next: NextFunction) {
    try {
      const validatedData = updateVideoSchema.parse(req.body);
      const video = await videosService.update(req.params.id, validatedData);
      res.json(video);
    } catch (error) {
      next(error);
    }
  }

  async delete(req: Request, res: Response, next: NextFunction) {
    try {
      await videosService.delete(req.params.id);
      res.status(204).send();
    } catch (error) {
      next(error);
    }
  }

  async incrementViewCount(req: Request, res: Response, next: NextFunction) {
    try {
      const video = await videosService.incrementViewCount(req.params.id);
      res.json(video);
    } catch (error) {
      next(error);
    }
  }
}

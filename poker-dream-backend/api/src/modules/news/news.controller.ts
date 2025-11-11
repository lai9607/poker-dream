import { Request, Response, NextFunction } from 'express';
import { NewsService } from './news.service';
import { createNewsSchema, updateNewsSchema, newsQuerySchema } from './news.schema';

const newsService = new NewsService();

export class NewsController {
  async create(req: Request, res: Response, next: NextFunction) {
    try {
      const validatedData = createNewsSchema.parse(req.body);
      const news = await newsService.create(validatedData);
      res.status(201).json(news);
    } catch (error) {
      next(error);
    }
  }

  async findAll(req: Request, res: Response, next: NextFunction) {
    try {
      const validatedQuery = newsQuerySchema.parse(req.query);
      const result = await newsService.findAll(validatedQuery);
      res.json(result);
    } catch (error) {
      next(error);
    }
  }

  async findById(req: Request, res: Response, next: NextFunction) {
    try {
      const news = await newsService.findById(req.params.id);
      res.json(news);
    } catch (error) {
      next(error);
    }
  }

  async update(req: Request, res: Response, next: NextFunction) {
    try {
      const validatedData = updateNewsSchema.parse(req.body);
      const news = await newsService.update(req.params.id, validatedData);
      res.json(news);
    } catch (error) {
      next(error);
    }
  }

  async delete(req: Request, res: Response, next: NextFunction) {
    try {
      await newsService.delete(req.params.id);
      res.status(204).send();
    } catch (error) {
      next(error);
    }
  }
}

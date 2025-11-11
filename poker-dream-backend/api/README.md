# Poker Dream API

Node.js + Express + TypeScript + Prisma backend for Poker Dream mobile app.

## Prerequisites

- Node.js 20+
- PostgreSQL 15+
- pnpm/npm/yarn

## Quick Start

### 1. Install Dependencies

```bash
npm install
```

### 2. Set Up Environment

```bash
cp .env.example .env
# Edit .env with your database credentials and secrets
```

### 3. Database Setup

```bash
# Generate Prisma client
npm run prisma:generate

# Run migrations
npm run prisma:migrate

# (Optional) Seed database
npm run prisma:seed
```

### 4. Start Development Server

```bash
npm run dev
```

The API will be available at `http://localhost:3001`

## Project Structure

```
api/
├── src/
│   ├── config/          # Configuration files
│   ├── middleware/      # Express middleware
│   ├── modules/         # Feature modules
│   │   ├── auth/
│   │   ├── tournaments/
│   │   ├── players/
│   │   └── ...
│   ├── utils/           # Utility functions
│   ├── types/           # TypeScript types
│   ├── app.ts           # Express app setup
│   └── server.ts        # Server entry point
├── prisma/
│   ├── schema.prisma    # Database schema
│   └── seed.ts          # Seed data
└── tests/               # Tests
```

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `POST /api/auth/refresh` - Refresh access token
- `GET /api/auth/me` - Get current user
- `POST /api/auth/logout` - Logout user

### Tournaments (TODO: Implement following the auth pattern)
- `GET /api/tournaments` - List tournaments
- `GET /api/tournaments/:id` - Get tournament
- `POST /api/tournaments` - Create tournament (admin)
- `PUT /api/tournaments/:id` - Update tournament (admin)
- `DELETE /api/tournaments/:id` - Delete tournament (admin)

### Players
- `GET /api/players` - List players
- `GET /api/players/:id` - Get player
- `POST /api/players` - Create player (admin)
- `PUT /api/players/:id` - Update player (admin)
- `DELETE /api/players/:id` - Delete player (admin)

## Module Pattern

Each module follows this structure:

```
modules/
└── feature/
    ├── feature.schema.ts      # Zod validation schemas
    ├── feature.service.ts     # Business logic
    ├── feature.controller.ts  # HTTP request handlers
    └── feature.routes.ts      # Route definitions
```

### Example: Creating a Tournament Module

#### 1. Schema (`tournaments/tournaments.schema.ts`)

```typescript
import { z } from 'zod';

export const createTournamentSchema = z.object({
  name: z.string().min(3),
  description: z.string().optional(),
  startDate: z.string().datetime().optional(),
  endDate: z.string().datetime().optional(),
  location: z.string().optional(),
  venue: z.string().optional(),
  status: z.enum(['UPCOMING', 'LIVE', 'COMPLETED', 'CANCELLED']).default('UPCOMING'),
  prizePool: z.number().positive().optional(),
  buyIn: z.number().positive().optional(),
});

export type CreateTournamentInput = z.infer<typeof createTournamentSchema>;
```

#### 2. Service (`tournaments/tournaments.service.ts`)

```typescript
import { prisma } from '../../config/database';
import { AppError } from '../../middleware/errorHandler';
import { CreateTournamentInput } from './tournaments.schema';

export class TournamentsService {
  async create(data: CreateTournamentInput) {
    const tournament = await prisma.tournament.create({
      data,
    });
    return tournament;
  }

  async findAll(filters?: any) {
    const tournaments = await prisma.tournament.findMany({
      where: filters,
      orderBy: { startDate: 'desc' },
    });
    return tournaments;
  }

  async findById(id: string) {
    const tournament = await prisma.tournament.findUnique({
      where: { id },
      include: {
        standings: { include: { player: true } },
        structure: true,
      },
    });

    if (!tournament) {
      throw new AppError(404, 'Tournament not found');
    }

    return tournament;
  }

  async update(id: string, data: Partial<CreateTournamentInput>) {
    const tournament = await prisma.tournament.update({
      where: { id },
      data,
    });
    return tournament;
  }

  async delete(id: string) {
    await prisma.tournament.delete({
      where: { id },
    });
  }
}

export const tournamentsService = new TournamentsService();
```

#### 3. Controller (`tournaments/tournaments.controller.ts`)

```typescript
import { Response, NextFunction } from 'express';
import { tournamentsService } from './tournaments.service';
import { createTournamentSchema } from './tournaments.schema';
import { AuthRequest } from '../../middleware/auth';

export class TournamentsController {
  async create(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = createTournamentSchema.parse(req.body);
      const tournament = await tournamentsService.create(validatedData);
      res.status(201).json({ data: tournament });
    } catch (error) {
      next(error);
    }
  }

  async findAll(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const { status } = req.query;
      const tournaments = await tournamentsService.findAll(
        status ? { status } : undefined
      );
      res.status(200).json({ data: tournaments });
    } catch (error) {
      next(error);
    }
  }

  async findById(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const tournament = await tournamentsService.findById(req.params.id);
      res.status(200).json({ data: tournament });
    } catch (error) {
      next(error);
    }
  }

  async update(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const validatedData = createTournamentSchema.partial().parse(req.body);
      const tournament = await tournamentsService.update(req.params.id, validatedData);
      res.status(200).json({ data: tournament });
    } catch (error) {
      next(error);
    }
  }

  async delete(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      await tournamentsService.delete(req.params.id);
      res.status(204).send();
    } catch (error) {
      next(error);
    }
  }
}

export const tournamentsController = new TournamentsController();
```

#### 4. Routes (`tournaments/tournaments.routes.ts`)

```typescript
import { Router } from 'express';
import { tournamentsController } from './tournaments.controller';
import { authenticate, authorize } from '../../middleware/auth';

const router = Router();

router.get('/', tournamentsController.findAll.bind(tournamentsController));
router.get('/:id', tournamentsController.findById.bind(tournamentsController));
router.post(
  '/',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  tournamentsController.create.bind(tournamentsController)
);
router.put(
  '/:id',
  authenticate,
  authorize('ADMIN', 'SUPER_ADMIN'),
  tournamentsController.update.bind(tournamentsController)
);
router.delete(
  '/:id',
  authenticate,
  authorize('SUPER_ADMIN'),
  tournamentsController.delete.bind(tournamentsController)
);

export default router;
```

#### 5. Register Routes in `app.ts`

```typescript
import tournamentRoutes from './modules/tournaments/tournaments.routes';
app.use('/api/tournaments', tournamentRoutes);
```

## Scripts

```bash
# Development
npm run dev          # Start dev server with hot reload

# Build
npm run build        # Compile TypeScript
npm start            # Start production server

# Database
npm run prisma:generate   # Generate Prisma client
npm run prisma:migrate    # Run migrations
npm run prisma:studio     # Open Prisma Studio
npm run prisma:seed       # Seed database

# Testing
npm test             # Run tests
npm run test:watch   # Run tests in watch mode
npm run test:coverage # Generate coverage report

# Code Quality
npm run lint         # Lint code
npm run lint:fix     # Fix linting issues
npm run format       # Format code with Prettier
```

## Environment Variables

See `.env.example` for all available environment variables.

## Authentication

The API uses JWT-based authentication:

1. Register or login to get access token
2. Include token in Authorization header:
   ```
   Authorization: Bearer <access_token>
   ```
3. Use refresh token to get new access token when it expires

## Authorization

Routes are protected by role-based access control:

- `USER` - Regular app users
- `EDITOR` - Can create/edit content
- `ADMIN` - Can manage most resources
- `SUPER_ADMIN` - Full access

## Error Handling

All errors are handled by centralized error middleware. Errors follow this format:

```json
{
  "error": "Error message",
  "details": {} // Optional validation details
}
```

## Development Tips

1. Use Prisma Studio to view/edit database: `npm run prisma:studio`
2. Check logs in `logs/` directory
3. Use Thunder Client or Postman for API testing
4. Run `npm run lint:fix` before committing

## Next Steps

Implement remaining modules following the auth pattern:
- [ ] Tournaments (full CRUD)
- [ ] Players
- [ ] Standings
- [ ] News
- [ ] Video Highlights
- [ ] Alerts
- [ ] Users (admin management)
- [ ] Sponsors
- [ ] File Upload

## License

MIT

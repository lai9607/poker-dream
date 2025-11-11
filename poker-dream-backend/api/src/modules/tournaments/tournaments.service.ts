import { prisma } from '../../config/database';
import { AppError } from '../../middleware/errorHandler';
import { CreateTournamentInput, UpdateTournamentInput, TournamentQueryInput } from './tournaments.schema';

export class TournamentsService {
  async create(data: CreateTournamentInput) {
    const tournament = await prisma.tournament.create({
      data: {
        ...data,
        startDate: data.startDate ? new Date(data.startDate) : undefined,
        endDate: data.endDate ? new Date(data.endDate) : undefined,
      },
    });
    return tournament;
  }

  async findAll(query: TournamentQueryInput) {
    const { status, page, limit, search } = query;
    const skip = (page - 1) * limit;

    const where: any = {};

    if (status) {
      where.status = status;
    }

    if (search) {
      where.OR = [
        { name: { contains: search, mode: 'insensitive' } },
        { location: { contains: search, mode: 'insensitive' } },
        { venue: { contains: search, mode: 'insensitive' } },
      ];
    }

    const [tournaments, total] = await Promise.all([
      prisma.tournament.findMany({
        where,
        skip,
        take: limit,
        orderBy: { startDate: 'desc' },
        include: {
          _count: {
            select: {
              standings: true,
            },
          },
        },
      }),
      prisma.tournament.count({ where }),
    ]);

    return {
      data: tournaments,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findById(id: string) {
    const tournament = await prisma.tournament.findUnique({
      where: { id },
      include: {
        standings: {
          include: {
            player: true,
          },
          orderBy: {
            rank: 'asc',
          },
        },
        structure: {
          orderBy: {
            level: 'asc',
          },
        },
        videoHighlights: true,
      },
    });

    if (!tournament) {
      throw new AppError(404, 'Tournament not found');
    }

    return tournament;
  }

  async update(id: string, data: UpdateTournamentInput) {
    // Check if tournament exists
    const exists = await prisma.tournament.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Tournament not found');
    }

    const tournament = await prisma.tournament.update({
      where: { id },
      data: {
        ...data,
        startDate: data.startDate ? new Date(data.startDate) : undefined,
        endDate: data.endDate ? new Date(data.endDate) : undefined,
      },
    });

    return tournament;
  }

  async delete(id: string) {
    // Check if tournament exists
    const exists = await prisma.tournament.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Tournament not found');
    }

    await prisma.tournament.delete({
      where: { id },
    });
  }

  async getUpcoming(limit = 10) {
    const tournaments = await prisma.tournament.findMany({
      where: {
        status: 'UPCOMING',
        startDate: {
          gte: new Date(),
        },
      },
      take: limit,
      orderBy: {
        startDate: 'asc',
      },
    });

    return tournaments;
  }

  async getLive() {
    const tournaments = await prisma.tournament.findMany({
      where: {
        status: 'LIVE',
      },
      orderBy: {
        startDate: 'desc',
      },
      include: {
        standings: {
          take: 10,
          orderBy: {
            rank: 'asc',
          },
          include: {
            player: true,
          },
        },
      },
    });

    return tournaments;
  }

  async getStats() {
    const [total, upcoming, live, completed] = await Promise.all([
      prisma.tournament.count(),
      prisma.tournament.count({ where: { status: 'UPCOMING' } }),
      prisma.tournament.count({ where: { status: 'LIVE' } }),
      prisma.tournament.count({ where: { status: 'COMPLETED' } }),
    ]);

    return {
      total,
      upcoming,
      live,
      completed,
    };
  }
}

export const tournamentsService = new TournamentsService();

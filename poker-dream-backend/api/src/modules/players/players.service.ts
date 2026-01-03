import { prisma } from '../../config/database';
import { AppError } from '../../middleware/errorHandler';
import { CreatePlayerInput, UpdatePlayerInput, PlayerQueryInput, LeaderboardQueryInput } from './players.schema';

export class PlayersService {
  async create(data: CreatePlayerInput) {
    const player = await prisma.player.create({
      data,
    });
    return player;
  }

  async findAll(query: PlayerQueryInput) {
    const { page, limit, search, country } = query;
    const skip = (page - 1) * limit;

    const where: any = {};

    if (search) {
      where.name = { contains: search, mode: 'insensitive' };
    }

    if (country) {
      where.countryCode = country.toUpperCase();
    }

    const [players, total] = await Promise.all([
      prisma.player.findMany({
        where,
        skip,
        take: limit,
        orderBy: { name: 'asc' },
        include: {
          _count: {
            select: {
              standings: true,
            },
          },
        },
      }),
      prisma.player.count({ where }),
    ]);

    return {
      data: players,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findById(id: string) {
    const player = await prisma.player.findUnique({
      where: { id },
      include: {
        standings: {
          include: {
            tournament: {
              select: {
                id: true,
                name: true,
                startDate: true,
                endDate: true,
                location: true,
                status: true,
              },
            },
          },
          orderBy: {
            createdAt: 'desc',
          },
        },
      },
    });

    if (!player) {
      throw new AppError(404, 'Player not found');
    }

    // Calculate total earnings and stats
    const totalEarnings = player.standings.reduce((sum: number, s: any) => {
      return sum + (s.prizeAmount ? Number(s.prizeAmount) : 0);
    }, 0);

    const wins = player.standings.filter((s: any) => s.rank === 1).length;
    const finalTables = player.standings.filter((s: any) => s.rank <= 9).length;
    const tournamentsPlayed = player.standings.length;

    return {
      ...player,
      stats: {
        totalEarnings,
        wins,
        finalTables,
        tournamentsPlayed,
      },
    };
  }

  async update(id: string, data: UpdatePlayerInput) {
    const exists = await prisma.player.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Player not found');
    }

    const player = await prisma.player.update({
      where: { id },
      data,
    });

    return player;
  }

  async delete(id: string) {
    const exists = await prisma.player.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Player not found');
    }

    await prisma.player.delete({
      where: { id },
    });
  }

  async getLeaderboard(query: LeaderboardQueryInput) {
    const { page, limit, year } = query;
    const skip = (page - 1) * limit;

    // Build date filter for the year
    let dateFilter: any = {};
    if (year) {
      const yearNum = parseInt(year);
      dateFilter = {
        tournament: {
          startDate: {
            gte: new Date(`${yearNum}-01-01`),
            lt: new Date(`${yearNum + 1}-01-01`),
          },
        },
      };
    }

    // Get all players with their standings for the specified period
    const playersWithStats = await prisma.player.findMany({
      include: {
        standings: {
          where: dateFilter,
          include: {
            tournament: {
              select: {
                id: true,
                name: true,
                startDate: true,
              },
            },
          },
        },
      },
    });

    // Calculate stats for each player
    const leaderboardData = playersWithStats
      .map((player: any) => {
        const totalEarnings = player.standings.reduce((sum: number, s: any) => {
          return sum + (s.prizeAmount ? Number(s.prizeAmount) : 0);
        }, 0);

        const wins = player.standings.filter((s: any) => s.rank === 1).length;
        const finalTables = player.standings.filter((s: any) => s.rank <= 9).length;
        const tournamentsPlayed = player.standings.length;

        // DPOY points calculation:
        // 1st place: 100 points, 2nd: 75, 3rd: 60, 4th-9th: 45-10, 10th+: scaled
        const points = player.standings.reduce((sum: number, s: any) => {
          if (s.rank === 1) return sum + 100;
          if (s.rank === 2) return sum + 75;
          if (s.rank === 3) return sum + 60;
          if (s.rank === 4) return sum + 45;
          if (s.rank === 5) return sum + 35;
          if (s.rank === 6) return sum + 28;
          if (s.rank === 7) return sum + 22;
          if (s.rank === 8) return sum + 17;
          if (s.rank === 9) return sum + 13;
          if (s.rank <= 20) return sum + 10;
          if (s.rank <= 50) return sum + 5;
          return sum + 2;
        }, 0);

        return {
          id: player.id,
          name: player.name,
          country: player.country,
          countryCode: player.countryCode,
          profileImageUrl: player.profileImageUrl,
          points,
          totalEarnings,
          wins,
          finalTables,
          tournamentsPlayed,
        };
      })
      .filter((p: any) => p.tournamentsPlayed > 0) // Only include players with standings
      .sort((a: any, b: any) => b.points - a.points); // Sort by points descending

    // Add rank
    const rankedData = leaderboardData.map((player: any, index: number) => ({
      ...player,
      rank: index + 1,
    }));

    const total = rankedData.length;
    const paginatedData = rankedData.slice(skip, skip + limit);

    return {
      data: paginatedData,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async getPlayerStats(id: string, year?: string) {
    const player = await prisma.player.findUnique({
      where: { id },
    });

    if (!player) {
      throw new AppError(404, 'Player not found');
    }

    // Build date filter for the year
    let dateFilter: any = {};
    if (year) {
      const yearNum = parseInt(year);
      dateFilter = {
        tournament: {
          startDate: {
            gte: new Date(`${yearNum}-01-01`),
            lt: new Date(`${yearNum + 1}-01-01`),
          },
        },
      };
    }

    const standings = await prisma.standing.findMany({
      where: {
        playerId: id,
        ...dateFilter,
      },
      include: {
        tournament: true,
      },
      orderBy: {
        createdAt: 'desc',
      },
    });

    const totalEarnings = standings.reduce((sum: number, s: any) => {
      return sum + (s.prizeAmount ? Number(s.prizeAmount) : 0);
    }, 0);

    const wins = standings.filter((s: any) => s.rank === 1).length;
    const finalTables = standings.filter((s: any) => s.rank <= 9).length;

    return {
      player,
      stats: {
        totalEarnings,
        wins,
        finalTables,
        tournamentsPlayed: standings.length,
      },
      standings,
    };
  }

  async getCountries() {
    const countries = await prisma.player.groupBy({
      by: ['country', 'countryCode'],
      _count: {
        id: true,
      },
      where: {
        countryCode: {
          not: null,
        },
      },
    });

    return countries.map((c: { country: string | null; countryCode: string | null; _count: { id: number } }) => ({
      country: c.country,
      countryCode: c.countryCode,
      playerCount: c._count.id,
    }));
  }
}

export const playersService = new PlayersService();

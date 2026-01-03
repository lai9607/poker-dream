import { prisma } from '../../config/database';
import { AppError } from '../../middleware/errorHandler';
import { CreateStandingInput, UpdateStandingInput, BulkCreateStandingsInput } from './standings.schema';

export class StandingsService {
  async create(data: CreateStandingInput) {
    // Check if tournament exists
    const tournament = await prisma.tournament.findUnique({
      where: { id: data.tournamentId },
    });

    if (!tournament) {
      throw new AppError(404, 'Tournament not found');
    }

    // Check if player exists
    const player = await prisma.player.findUnique({
      where: { id: data.playerId },
    });

    if (!player) {
      throw new AppError(404, 'Player not found');
    }

    // Check for duplicate entry
    const existing = await prisma.standing.findUnique({
      where: {
        tournamentId_playerId: {
          tournamentId: data.tournamentId,
          playerId: data.playerId,
        },
      },
    });

    if (existing) {
      throw new AppError(400, 'Standing already exists for this player in this tournament');
    }

    const standing = await prisma.standing.create({
      data: {
        ...data,
        chips: BigInt(data.chips),
      },
      include: {
        player: true,
        tournament: {
          select: {
            id: true,
            name: true,
            status: true,
          },
        },
      },
    });

    return {
      ...standing,
      chips: Number(standing.chips),
    };
  }

  async bulkCreate(data: BulkCreateStandingsInput) {
    // Check if tournament exists
    const tournament = await prisma.tournament.findUnique({
      where: { id: data.tournamentId },
    });

    if (!tournament) {
      throw new AppError(404, 'Tournament not found');
    }

    // Verify all players exist
    const playerIds = data.standings.map(s => s.playerId);
    const players = await prisma.player.findMany({
      where: { id: { in: playerIds } },
    });

    if (players.length !== playerIds.length) {
      throw new AppError(400, 'One or more players not found');
    }

    // Delete existing standings for this tournament (replace all)
    await prisma.standing.deleteMany({
      where: { tournamentId: data.tournamentId },
    });

    // Create new standings
    await prisma.standing.createMany({
      data: data.standings.map((s: { playerId: string; rank: number; chips: number; isSurvivor: boolean; prizeAmount?: number }) => ({
        tournamentId: data.tournamentId,
        playerId: s.playerId,
        rank: s.rank,
        chips: BigInt(s.chips),
        isSurvivor: s.isSurvivor,
        prizeAmount: s.prizeAmount,
      })),
    });

    // Return the created standings
    return this.getByTournament(data.tournamentId);
  }

  async findById(id: string) {
    const standing = await prisma.standing.findUnique({
      where: { id },
      include: {
        player: true,
        tournament: true,
      },
    });

    if (!standing) {
      throw new AppError(404, 'Standing not found');
    }

    return {
      ...standing,
      chips: Number(standing.chips),
    };
  }

  async update(id: string, data: UpdateStandingInput) {
    const exists = await prisma.standing.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Standing not found');
    }

    const standing = await prisma.standing.update({
      where: { id },
      data: {
        ...data,
        chips: data.chips !== undefined ? BigInt(data.chips) : undefined,
      },
      include: {
        player: true,
        tournament: {
          select: {
            id: true,
            name: true,
          },
        },
      },
    });

    return {
      ...standing,
      chips: Number(standing.chips),
    };
  }

  async delete(id: string) {
    const exists = await prisma.standing.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Standing not found');
    }

    await prisma.standing.delete({
      where: { id },
    });
  }

  async getByTournament(tournamentId: string, limit = 100) {
    const standings = await prisma.standing.findMany({
      where: { tournamentId },
      include: {
        player: true,
      },
      orderBy: {
        rank: 'asc',
      },
      take: limit,
    });

    return standings.map((s: any) => ({
      ...s,
      chips: Number(s.chips),
    }));
  }

  async getByPlayer(playerId: string) {
    const standings = await prisma.standing.findMany({
      where: { playerId },
      include: {
        tournament: true,
      },
      orderBy: {
        createdAt: 'desc',
      },
    });

    return standings.map((s: any) => ({
      ...s,
      chips: Number(s.chips),
    }));
  }

  async getLiveStandings(tournamentId: string) {
    const tournament = await prisma.tournament.findUnique({
      where: { id: tournamentId },
    });

    if (!tournament) {
      throw new AppError(404, 'Tournament not found');
    }

    const standings = await prisma.standing.findMany({
      where: {
        tournamentId,
        isSurvivor: true,
      },
      include: {
        player: true,
      },
      orderBy: {
        chips: 'desc',
      },
    });

    return {
      tournament: {
        id: tournament.id,
        name: tournament.name,
        status: tournament.status,
        totalEntries: tournament.totalEntries,
      },
      playersRemaining: standings.length,
      standings: standings.map((s: any, index: number) => ({
        ...s,
        chips: Number(s.chips),
        liveRank: index + 1,
      })),
    };
  }
}

export const standingsService = new StandingsService();

import { prisma } from '../../config/database';
import { AppError } from '../../middleware/errorHandler';
import { CreateSponsorInput, UpdateSponsorInput, SponsorQueryInput } from './sponsors.schema';

export class SponsorsService {
  async create(data: CreateSponsorInput) {
    const sponsor = await prisma.sponsor.create({
      data,
    });
    return sponsor;
  }

  async findAll(query: SponsorQueryInput) {
    const where: any = {};

    if (query.isActive !== undefined) {
      where.isActive = query.isActive;
    }

    const sponsors = await prisma.sponsor.findMany({
      where,
      orderBy: {
        displayOrder: 'asc',
      },
    });

    return sponsors;
  }

  async findById(id: string) {
    const sponsor = await prisma.sponsor.findUnique({
      where: { id },
    });

    if (!sponsor) {
      throw new AppError(404, 'Sponsor not found');
    }

    return sponsor;
  }

  async update(id: string, data: UpdateSponsorInput) {
    const exists = await prisma.sponsor.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Sponsor not found');
    }

    const sponsor = await prisma.sponsor.update({
      where: { id },
      data,
    });

    return sponsor;
  }

  async delete(id: string) {
    const exists = await prisma.sponsor.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Sponsor not found');
    }

    await prisma.sponsor.delete({
      where: { id },
    });
  }

  async reorder(sponsorIds: string[]) {
    const updates = sponsorIds.map((id, index) =>
      prisma.sponsor.update({
        where: { id },
        data: { displayOrder: index },
      })
    );

    await prisma.$transaction(updates);

    return this.findAll({ isActive: undefined });
  }
}

export const sponsorsService = new SponsorsService();

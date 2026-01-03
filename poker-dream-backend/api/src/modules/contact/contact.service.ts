import { prisma } from '../../config/database';
import { AppError } from '../../middleware/errorHandler';
import { CreateContactInput, UpdateContactStatusInput, ContactQueryInput } from './contact.schema';

export class ContactService {
  async create(data: CreateContactInput) {
    const submission = await prisma.contactSubmission.create({
      data,
    });
    return submission;
  }

  async findAll(query: ContactQueryInput) {
    const { status, type, page, limit } = query;
    const skip = (page - 1) * limit;

    const where: any = {};

    if (status) {
      where.status = status;
    }

    if (type) {
      where.type = type;
    }

    const [submissions, total] = await Promise.all([
      prisma.contactSubmission.findMany({
        where,
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
      }),
      prisma.contactSubmission.count({ where }),
    ]);

    return {
      data: submissions,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findById(id: string) {
    const submission = await prisma.contactSubmission.findUnique({
      where: { id },
    });

    if (!submission) {
      throw new AppError(404, 'Contact submission not found');
    }

    return submission;
  }

  async updateStatus(id: string, data: UpdateContactStatusInput) {
    const exists = await prisma.contactSubmission.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Contact submission not found');
    }

    const submission = await prisma.contactSubmission.update({
      where: { id },
      data,
    });

    return submission;
  }

  async delete(id: string) {
    const exists = await prisma.contactSubmission.findUnique({
      where: { id },
    });

    if (!exists) {
      throw new AppError(404, 'Contact submission not found');
    }

    await prisma.contactSubmission.delete({
      where: { id },
    });
  }

  async getStats() {
    const [total, newCount, inProgress, resolved] = await Promise.all([
      prisma.contactSubmission.count(),
      prisma.contactSubmission.count({ where: { status: 'NEW' } }),
      prisma.contactSubmission.count({ where: { status: 'IN_PROGRESS' } }),
      prisma.contactSubmission.count({ where: { status: 'RESOLVED' } }),
    ]);

    const byType = await prisma.contactSubmission.groupBy({
      by: ['type'],
      _count: {
        id: true,
      },
    });

    return {
      total,
      byStatus: {
        new: newCount,
        inProgress,
        resolved,
        archived: total - newCount - inProgress - resolved,
      },
      byType: byType.reduce((acc: Record<string, number>, curr: { type: string; _count: { id: number } }) => {
        acc[curr.type] = curr._count.id;
        return acc;
      }, {} as Record<string, number>),
    };
  }
}

export const contactService = new ContactService();

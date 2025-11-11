import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  // Create test tournaments
  const tournaments = await Promise.all([
    prisma.tournament.create({
      data: {
        name: 'WSOP Main Event 2024',
        description: 'The most prestigious poker tournament in the world',
        startDate: new Date('2024-12-01T10:00:00Z'),
        endDate: new Date('2024-12-15T22:00:00Z'),
        location: 'Las Vegas, NV',
        venue: 'Paris Las Vegas',
        status: 'UPCOMING',
        prizePool: 10000000,
        buyIn: 10000,
        totalEntries: 0,
        bannerImageUrl: 'https://images.unsplash.com/photo-1511193311914-0346f16efe90?w=800',
      },
    }),
    prisma.tournament.create({
      data: {
        name: 'European Poker Tour Barcelona',
        description: 'Join us for the thrilling EPT Barcelona stop',
        startDate: new Date('2025-01-15T12:00:00Z'),
        endDate: new Date('2025-01-25T20:00:00Z'),
        location: 'Barcelona, Spain',
        venue: 'Casino Barcelona',
        status: 'UPCOMING',
        prizePool: 5000000,
        buyIn: 5000,
        totalEntries: 250,
        bannerImageUrl: 'https://images.unsplash.com/photo-1520277739331-1bf94069d77e?w=800',
      },
    }),
    prisma.tournament.create({
      data: {
        name: 'High Roller Championship',
        description: 'Elite high-stakes poker tournament',
        startDate: new Date('2024-11-20T14:00:00Z'),
        endDate: new Date('2024-11-22T23:00:00Z'),
        location: 'Macau',
        venue: 'PokerStars Live',
        status: 'LIVE',
        prizePool: 15000000,
        buyIn: 25000,
        totalEntries: 128,
        bannerImageUrl: 'https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=800',
      },
    }),
  ]);

  console.log('Seeded tournaments:', tournaments.length);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

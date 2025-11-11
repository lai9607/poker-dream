import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  // Clear existing tournaments
  await prisma.tournament.deleteMany();

  // Create realistic tournament data
  const tournaments = await Promise.all([
    // Upcoming Tournaments
    prisma.tournament.create({
      data: {
        name: 'World Series of Poker Main Event 2024',
        description: 'The most prestigious poker tournament in the world. $10,000 buy-in No-Limit Hold\'em World Championship. Join thousands of players competing for millions in prizes and the coveted WSOP bracelet.',
        startDate: new Date('2024-12-01T10:00:00Z'),
        endDate: new Date('2024-12-15T23:00:00Z'),
        location: 'Las Vegas, Nevada',
        venue: 'Paris Las Vegas Hotel & Casino',
        status: 'UPCOMING',
        prizePool: 10000000,
        buyIn: 10000,
        totalEntries: 0,
        bannerImageUrl: 'https://images.unsplash.com/photo-a1tI05LWQPE?w=800',
      },
    }),
    prisma.tournament.create({
      data: {
        name: 'European Poker Tour Barcelona',
        description: 'Join us at Casino Barcelona for one of the most exciting stops on the EPT tour. Experience world-class poker in one of Europe\'s most beautiful cities.',
        startDate: new Date('2025-01-15T12:00:00Z'),
        endDate: new Date('2025-01-25T22:00:00Z'),
        location: 'Barcelona, Spain',
        venue: 'Casino Barcelona',
        status: 'UPCOMING',
        prizePool: 5000000,
        buyIn: 5000,
        totalEntries: 347,
        bannerImageUrl: 'https://images.unsplash.com/photo-5e6jE98rQao?w=800',
      },
    }),
    prisma.tournament.create({
      data: {
        name: 'PokerStars Caribbean Adventure',
        description: 'Paradise meets poker at the luxurious Atlantis Resort. Play in the $10,000 Main Event and enjoy world-class poker in a tropical setting.',
        startDate: new Date('2025-02-20T14:00:00Z'),
        endDate: new Date('2025-03-02T20:00:00Z'),
        location: 'Nassau, Bahamas',
        venue: 'Atlantis Resort',
        status: 'UPCOMING',
        prizePool: 8000000,
        buyIn: 10000,
        totalEntries: 0,
        bannerImageUrl: 'https://images.unsplash.com/photo-7fU6JqV2Ulg?w=800',
      },
    }),
    prisma.tournament.create({
      data: {
        name: 'Aussie Millions Main Event',
        description: 'The Southern Hemisphere\'s richest poker tournament returns to Melbourne. $10,600 buy-in Championship event with guaranteed million-dollar first prize.',
        startDate: new Date('2025-03-10T10:00:00Z'),
        endDate: new Date('2025-03-18T22:00:00Z'),
        location: 'Melbourne, Australia',
        venue: 'Crown Casino',
        status: 'UPCOMING',
        prizePool: 6500000,
        buyIn: 10600,
        totalEntries: 0,
        bannerImageUrl: 'https://images.unsplash.com/photo-WovLw_At0ko?w=800',
      },
    }),

    // Live Tournaments
    prisma.tournament.create({
      data: {
        name: 'High Roller Championship',
        description: 'Elite $25,000 buy-in high-stakes tournament featuring the world\'s best players. Limited field of 200 players competing for a massive prize pool.',
        startDate: new Date('2024-11-20T14:00:00Z'),
        endDate: new Date('2024-11-23T23:00:00Z'),
        location: 'Macau, China',
        venue: 'PokerStars LIVE Macau',
        status: 'LIVE',
        prizePool: 15000000,
        buyIn: 25000,
        totalEntries: 156,
        bannerImageUrl: 'https://images.unsplash.com/photo-_KxXGJmJo9c?w=800',
      },
    }),
    prisma.tournament.create({
      data: {
        name: 'Super High Roller Bowl',
        description: 'The most exclusive poker tournament in the world. $300,000 buy-in with only 56 seats available. Watch the legends battle it out LIVE.',
        startDate: new Date('2024-11-18T12:00:00Z'),
        endDate: new Date('2024-11-24T20:00:00Z'),
        location: 'Las Vegas, Nevada',
        venue: 'Aria Resort & Casino',
        status: 'LIVE',
        prizePool: 16800000,
        buyIn: 300000,
        totalEntries: 56,
        bannerImageUrl: 'https://images.unsplash.com/photo-1S-VJgvh_Oc?w=800',
      },
    }),

    // Completed Tournaments
    prisma.tournament.create({
      data: {
        name: 'WPT World Championship',
        description: 'The World Poker Tour\'s flagship event has concluded with an incredible final table. Congratulations to all the winners!',
        startDate: new Date('2024-10-15T10:00:00Z'),
        endDate: new Date('2024-10-28T22:00:00Z'),
        location: 'Las Vegas, Nevada',
        venue: 'Wynn Las Vegas',
        status: 'COMPLETED',
        prizePool: 12500000,
        buyIn: 10400,
        totalEntries: 1234,
        bannerImageUrl: 'https://images.unsplash.com/photo-1511193311914-0346f16efe90?w=800',
      },
    }),
    prisma.tournament.create({
      data: {
        name: 'Asian Poker Tour Manila',
        description: 'APT Manila Main Event concluded with exciting action. See full results and prize payouts in the tournament details.',
        startDate: new Date('2024-09-20T12:00:00Z'),
        endDate: new Date('2024-09-30T20:00:00Z'),
        location: 'Manila, Philippines',
        venue: 'Resorts World Manila',
        status: 'COMPLETED',
        prizePool: 3200000,
        buyIn: 2500,
        totalEntries: 845,
        bannerImageUrl: 'https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=800',
      },
    }),

    // More Upcoming
    prisma.tournament.create({
      data: {
        name: 'EPT Monte Carlo High Roller',
        description: 'Experience luxury poker at its finest. €25,000 High Roller event at the prestigious Monte Carlo Casino.',
        startDate: new Date('2025-04-15T14:00:00Z'),
        endDate: new Date('2025-04-20T22:00:00Z'),
        location: 'Monte Carlo, Monaco',
        venue: 'Monte Carlo Casino',
        status: 'UPCOMING',
        prizePool: 7500000,
        buyIn: 25000,
        totalEntries: 0,
        bannerImageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      },
    }),
    prisma.tournament.create({
      data: {
        name: 'Triton Poker Series',
        description: 'The most prestigious high-stakes poker series returns. Multiple events with buy-ins ranging from $50k to $1 million.',
        startDate: new Date('2025-05-01T10:00:00Z'),
        endDate: new Date('2025-05-15T23:00:00Z'),
        location: 'London, United Kingdom',
        venue: 'Hilton Park Lane',
        status: 'UPCOMING',
        prizePool: 25000000,
        buyIn: 100000,
        totalEntries: 0,
        bannerImageUrl: 'https://images.unsplash.com/photo-1541278107931-e006523892df?w=800',
      },
    }),
  ]);

  console.log(`✅ Successfully seeded ${tournaments.length} tournaments!`);
  
  // Print summary
  const stats = {
    total: tournaments.length,
    upcoming: tournaments.filter(t => t.status === 'UPCOMING').length,
    live: tournaments.filter(t => t.status === 'LIVE').length,
    completed: tournaments.filter(t => t.status === 'COMPLETED').length,
  };
  
  console.log('\n📊 Tournament Statistics:');
  console.log(`   Total: ${stats.total}`);
  console.log(`   Upcoming: ${stats.upcoming}`);
  console.log(`   Live: ${stats.live}`);
  console.log(`   Completed: ${stats.completed}`);
}

main()
  .catch((e) => {
    console.error('❌ Error seeding database:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

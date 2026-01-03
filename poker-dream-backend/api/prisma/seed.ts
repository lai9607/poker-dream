import { PrismaClient, UserRole, TournamentStatus, NewsCategory, GalleryType } from '@prisma/client';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

async function main() {
  console.log('Starting database seed...');

  // Create admin user
  console.log('Creating admin user...');
  const hashedPassword = await bcrypt.hash('admin123', 10);
  const admin = await prisma.user.upsert({
    where: { email: 'admin@pokerdream.com' },
    update: {},
    create: {
      email: 'admin@pokerdream.com',
      password: hashedPassword,
      name: 'Admin User',
      role: UserRole.SUPER_ADMIN,
      isActive: true,
      emailVerified: true,
    },
  });
  console.log(`Created admin user: ${admin.email}`);

  // Create players
  console.log('Creating players...');
  const playersData = [
    { name: 'Michael Chen', country: 'Malaysia', countryCode: 'MY' },
    { name: 'Sarah Wong', country: 'Singapore', countryCode: 'SG' },
    { name: 'James Liu', country: 'Taiwan', countryCode: 'TW' },
    { name: 'David Park', country: 'South Korea', countryCode: 'KR' },
    { name: 'Lisa Tanaka', country: 'Japan', countryCode: 'JP' },
    { name: 'Wei Zhang', country: 'China', countryCode: 'CN' },
    { name: 'Tommy Nguyen', country: 'Vietnam', countryCode: 'VN' },
    { name: 'Anna Kim', country: 'South Korea', countryCode: 'KR' },
    { name: 'John Smith', country: 'Australia', countryCode: 'AU' },
    { name: 'Maria Garcia', country: 'Philippines', countryCode: 'PH' },
  ];

  const players = [];
  for (const playerData of playersData) {
    const playerId = playerData.name.toLowerCase().replace(/\s/g, '-');
    const player = await prisma.player.upsert({
      where: { id: playerId },
      update: {},
      create: {
        id: playerId,
        ...playerData,
        profileImageUrl: `https://ui-avatars.com/api/?name=${encodeURIComponent(playerData.name)}&background=random`,
      },
    });
    players.push(player);
  }
  console.log(`Created ${players.length} players`);

  // Create tournaments
  console.log('Creating tournaments...');
  const tournamentsData = [
    {
      id: 'pd18-main',
      name: 'Poker Dream 18 Main Event',
      description: 'The flagship main event of Poker Dream 18 series.',
      startDate: new Date('2025-02-15'),
      endDate: new Date('2025-02-20'),
      location: 'Kuala Lumpur, Malaysia',
      venue: 'Resorts World Genting',
      status: TournamentStatus.LIVE,
      prizePool: 5000000,
      buyIn: 3000,
      totalEntries: 1456,
    },
    {
      id: 'pd18-highroller',
      name: 'PD18 High Roller',
      description: 'High stakes tournament for seasoned professionals.',
      startDate: new Date('2025-02-18'),
      endDate: new Date('2025-02-19'),
      location: 'Kuala Lumpur, Malaysia',
      venue: 'Resorts World Genting',
      status: TournamentStatus.LIVE,
      prizePool: 2500000,
      buyIn: 25000,
      totalEntries: 85,
    },
    {
      id: 'pd17-main',
      name: 'Poker Dream 17 Main Event',
      description: 'The flagship main event of Poker Dream 17 series.',
      startDate: new Date('2024-12-10'),
      endDate: new Date('2024-12-15'),
      location: 'Kuala Lumpur, Malaysia',
      venue: 'Resorts World Genting',
      status: TournamentStatus.COMPLETED,
      prizePool: 4500000,
      buyIn: 3000,
      totalEntries: 1250,
    },
    {
      id: 'pd17-highroller',
      name: 'PD17 High Roller',
      description: 'High stakes tournament for seasoned professionals.',
      startDate: new Date('2024-12-13'),
      endDate: new Date('2024-12-14'),
      location: 'Kuala Lumpur, Malaysia',
      venue: 'Resorts World Genting',
      status: TournamentStatus.COMPLETED,
      prizePool: 2200000,
      buyIn: 25000,
      totalEntries: 92,
    },
    {
      id: 'pd19-main',
      name: 'Poker Dream 19 Main Event',
      description: 'The flagship main event of Poker Dream 19 series.',
      startDate: new Date('2025-06-15'),
      endDate: new Date('2025-06-20'),
      location: 'Manila, Philippines',
      venue: 'Solaire Resort',
      status: TournamentStatus.UPCOMING,
      prizePool: 0,
      buyIn: 3500,
      totalEntries: 0,
    },
  ];

  const tournaments = [];
  for (const tournamentData of tournamentsData) {
    const tournament = await prisma.tournament.upsert({
      where: { id: tournamentData.id },
      update: {},
      create: tournamentData,
    });
    tournaments.push(tournament);
  }
  console.log(`Created ${tournaments.length} tournaments`);

  // Create standings for completed tournament (PD17 Main)
  console.log('Creating standings...');
  const pd17Main = tournaments.find(t => t.id === 'pd17-main');
  if (pd17Main && players.length >= 5) {
    const standingsData = [
      { playerId: players[0].id, rank: 1, chips: BigInt(0), prizeAmount: 1250000, isSurvivor: false },
      { playerId: players[1].id, rank: 2, chips: BigInt(0), prizeAmount: 850000, isSurvivor: false },
      { playerId: players[2].id, rank: 3, chips: BigInt(0), prizeAmount: 550000, isSurvivor: false },
      { playerId: players[3].id, rank: 4, chips: BigInt(0), prizeAmount: 380000, isSurvivor: false },
      { playerId: players[4].id, rank: 5, chips: BigInt(0), prizeAmount: 280000, isSurvivor: false },
    ];

    for (const standingData of standingsData) {
      await prisma.standing.upsert({
        where: {
          tournamentId_playerId: {
            tournamentId: pd17Main.id,
            playerId: standingData.playerId,
          },
        },
        update: {},
        create: {
          tournamentId: pd17Main.id,
          ...standingData,
        },
      });
    }
    console.log('Created standings for PD17 Main Event');
  }

  // Create standings for live tournament (PD18 Main)
  const pd18Main = tournaments.find(t => t.id === 'pd18-main');
  if (pd18Main && players.length >= 10) {
    const liveStandingsData = [
      { playerId: players[5].id, rank: 1, chips: BigInt(2500000), isSurvivor: true },
      { playerId: players[6].id, rank: 2, chips: BigInt(2100000), isSurvivor: true },
      { playerId: players[7].id, rank: 3, chips: BigInt(1800000), isSurvivor: true },
      { playerId: players[8].id, rank: 4, chips: BigInt(1500000), isSurvivor: true },
      { playerId: players[9].id, rank: 5, chips: BigInt(1200000), isSurvivor: true },
    ];

    for (const standingData of liveStandingsData) {
      await prisma.standing.upsert({
        where: {
          tournamentId_playerId: {
            tournamentId: pd18Main.id,
            playerId: standingData.playerId,
          },
        },
        update: {},
        create: {
          tournamentId: pd18Main.id,
          ...standingData,
        },
      });
    }
    console.log('Created standings for PD18 Main Event');
  }

  // Create tournament structure for PD18 Main
  console.log('Creating tournament structure...');
  if (pd18Main) {
    const structureData = [
      { level: 1, smallBlind: 100, bigBlind: 200, ante: 25, durationMinutes: 60 },
      { level: 2, smallBlind: 150, bigBlind: 300, ante: 50, durationMinutes: 60 },
      { level: 3, smallBlind: 200, bigBlind: 400, ante: 50, durationMinutes: 60 },
      { level: 4, smallBlind: 250, bigBlind: 500, ante: 75, durationMinutes: 60 },
      { level: 5, smallBlind: 300, bigBlind: 600, ante: 100, durationMinutes: 60 },
      { level: 6, smallBlind: 0, bigBlind: 0, ante: 0, durationMinutes: 20, isBreak: true },
      { level: 7, smallBlind: 400, bigBlind: 800, ante: 100, durationMinutes: 60 },
      { level: 8, smallBlind: 500, bigBlind: 1000, ante: 150, durationMinutes: 60 },
    ];

    // Delete existing structure first
    await prisma.tournamentStructure.deleteMany({
      where: { tournamentId: pd18Main.id },
    });

    for (const structure of structureData) {
      await prisma.tournamentStructure.create({
        data: {
          tournamentId: pd18Main.id,
          ...structure,
        },
      });
    }
    console.log('Created tournament structure');
  }

  // Create news articles
  console.log('Creating news articles...');
  const newsData = [
    {
      id: 'news-pd18-record',
      title: 'Poker Dream 18 Sets New Attendance Record',
      summary: 'The ongoing PD18 Main Event has attracted over 1,400 entries, setting a new record for the series.',
      content: 'The Poker Dream 18 Main Event has shattered all previous records with over 1,400 entries. Players from across Asia have gathered at Resorts World Genting for what promises to be an epic tournament. The prize pool has exceeded RM 5 million, making it the largest in Poker Dream history.',
      category: NewsCategory.TOURNAMENTS,
      author: 'Poker Dream Media',
      isPublished: true,
      publishedAt: new Date('2025-02-16'),
    },
    {
      id: 'news-champion-interview',
      title: 'Interview with Last Year\'s Champion',
      summary: 'We sat down with Michael Chen to discuss his journey to winning the PD17 Main Event.',
      content: 'Michael Chen\'s victory at Poker Dream 17 was the culmination of years of dedication to the game. In this exclusive interview, he shares his preparation strategies, key hands from the final table, and his plans for PD18.',
      category: NewsCategory.PLAYER_INTERVIEW,
      author: 'Poker Dream Media',
      isPublished: true,
      publishedAt: new Date('2025-01-15'),
    },
    {
      id: 'news-icm-guide',
      title: 'Understanding ICM in Tournament Poker',
      summary: 'A comprehensive guide to Independent Chip Model and its applications in tournament play.',
      content: 'The Independent Chip Model (ICM) is a mathematical model used to calculate a player\'s equity in a tournament. This guide covers the basics of ICM, when to apply it, and common spots where ICM considerations change optimal strategy.',
      category: NewsCategory.STRATEGY,
      author: 'Pro Strategy Team',
      isPublished: true,
      publishedAt: new Date('2025-01-10'),
    },
  ];

  for (const article of newsData) {
    await prisma.newsArticle.upsert({
      where: { id: article.id },
      update: {},
      create: article,
    });
  }
  console.log(`Created ${newsData.length} news articles`);

  // Create video highlights
  console.log('Creating video highlights...');
  const videosData = [
    {
      id: 'video-pd17-final',
      title: 'PD17 Main Event Final Table',
      description: 'Watch the thrilling conclusion of the Poker Dream 17 Main Event.',
      videoUrl: 'https://www.youtube.com/watch?v=example1',
      thumbnailUrl: 'https://images.unsplash.com/photo-1511193311914-0346f16efe90?w=800',
      durationSeconds: 930,
      viewCount: 12543,
      tournamentId: pd17Main?.id,
    },
    {
      id: 'video-amazing-bluff',
      title: 'Amazing Bluff at High Stakes',
      description: 'An unforgettable moment where a massive bluff wins a million-dollar pot.',
      videoUrl: 'https://www.youtube.com/watch?v=example2',
      thumbnailUrl: 'https://images.unsplash.com/photo-1542826438-bd32f43d626f?w=800',
      durationSeconds: 525,
      viewCount: 8921,
    },
  ];

  for (const video of videosData) {
    await prisma.videoHighlight.upsert({
      where: { id: video.id },
      update: {},
      create: video,
    });
  }
  console.log(`Created ${videosData.length} video highlights`);

  // Create sponsors
  console.log('Creating sponsors...');
  const sponsorsData = [
    { id: 'sponsor-pokerstars', name: 'PokerStars', logoUrl: 'https://via.placeholder.com/200x80?text=PokerStars', websiteUrl: 'https://pokerstars.com', displayOrder: 0 },
    { id: 'sponsor-ggpoker', name: 'GG Poker', logoUrl: 'https://via.placeholder.com/200x80?text=GGPoker', websiteUrl: 'https://ggpoker.com', displayOrder: 1 },
    { id: 'sponsor-rwg', name: 'Resorts World', logoUrl: 'https://via.placeholder.com/200x80?text=ResortsWorld', websiteUrl: 'https://rwgenting.com', displayOrder: 2 },
    { id: 'sponsor-888', name: '888 Poker', logoUrl: 'https://via.placeholder.com/200x80?text=888Poker', websiteUrl: 'https://888poker.com', displayOrder: 3 },
  ];

  for (const sponsor of sponsorsData) {
    await prisma.sponsor.upsert({
      where: { id: sponsor.id },
      update: {},
      create: sponsor,
    });
  }
  console.log(`Created ${sponsorsData.length} sponsors`);

  // Create galleries
  console.log('Creating galleries...');
  const tournamentGallery = await prisma.gallery.upsert({
    where: { id: 'gallery-pd17' },
    update: {},
    create: {
      id: 'gallery-pd17',
      type: GalleryType.TOURNAMENT,
      title: 'Poker Dream 17 Photos',
      description: 'Action shots and moments from PD17',
      date: new Date('2024-12-15'),
    },
  });

  // Add photos to tournament gallery
  const tournamentPhotos = [
    { imageUrl: 'https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=800', caption: 'Day 1 Action', displayOrder: 0 },
    { imageUrl: 'https://images.unsplash.com/photo-1511193311914-0346f16efe90?w=800', caption: 'Final Table', displayOrder: 1 },
    { imageUrl: 'https://images.unsplash.com/photo-1609743522653-52354461eb27?w=800', caption: 'Champion Celebration', displayOrder: 2 },
  ];

  for (const photo of tournamentPhotos) {
    await prisma.galleryPhoto.create({
      data: {
        galleryId: tournamentGallery.id,
        ...photo,
      },
    });
  }

  const championsGallery = await prisma.gallery.upsert({
    where: { id: 'gallery-champions-2024' },
    update: {},
    create: {
      id: 'gallery-champions-2024',
      type: GalleryType.CHAMPION,
      title: '2024 Champions',
      description: 'Winners from all 2024 events',
      date: new Date('2024-12-31'),
    },
  });

  // Add photos to champions gallery
  const championPhotos = [
    { imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800', caption: 'PD17 Main Event Winner', displayOrder: 0 },
    { imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800', caption: 'PD17 High Roller Winner', displayOrder: 1 },
  ];

  for (const photo of championPhotos) {
    await prisma.galleryPhoto.create({
      data: {
        galleryId: championsGallery.id,
        ...photo,
      },
    });
  }
  console.log('Created galleries with photos');

  console.log('Database seed completed successfully!');
}

main()
  .catch((e) => {
    console.error('Error during seeding:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

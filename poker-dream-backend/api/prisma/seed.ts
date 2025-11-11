import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  console.log('🌱 Seeding database...');

  // Seed Video Highlights
  console.log('📹 Creating video highlights...');
  const videos = await Promise.all([
    prisma.videoHighlight.upsert({
      where: { id: 'video-1' },
      update: {},
      create: {
        id: 'video-1',
        title: 'WSOP Main Event Final Table',
        description: 'Watch the thrilling conclusion of the WSOP Main Event with incredible hands and life-changing decisions.',
        videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        thumbnailUrl: 'https://images.unsplash.com/photo-1511193311914-0346f16efe90?w=800',
        durationSeconds: 930, // 15:30
        viewCount: 12543,
      },
    }),
    prisma.videoHighlight.upsert({
      where: { id: 'video-2' },
      update: {},
      create: {
        id: 'video-2',
        title: 'Amazing Royal Flush',
        description: 'Witness one of the rarest hands in poker - a royal flush that changed everything!',
        videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        thumbnailUrl: 'https://images.unsplash.com/photo-1542826438-bd32f43d626f?w=800',
        durationSeconds: 525, // 8:45
        viewCount: 8921,
      },
    }),
    prisma.videoHighlight.upsert({
      where: { id: 'video-3' },
      update: {},
      create: {
        id: 'video-3',
        title: 'Epic Bluff at High Stakes',
        description: 'An unforgettable moment where a massive bluff wins a million-dollar pot.',
        videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        thumbnailUrl: 'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?w=800',
        durationSeconds: 735, // 12:15
        viewCount: 15672,
      },
    }),
  ]);
  console.log(`✅ Created ${videos.length} video highlights`);

  // Seed News Articles
  console.log('📰 Creating news articles...');
  const news = await Promise.all([
    prisma.newsArticle.upsert({
      where: { id: 'news-1' },
      update: {},
      create: {
        id: 'news-1',
        title: 'WSOP 2024 Schedule Announced',
        summary: 'The World Series of Poker reveals dates and events for the upcoming championship series.',
        content: 'The World Series of Poker has officially announced its 2024 schedule, featuring over 100 bracelet events and a record-breaking prize pool. The Main Event is set to begin on July 3rd, with satellite tournaments starting in April. This year promises to be the biggest WSOP in history, with new events and innovative formats designed to attract players of all skill levels.',
        imageUrl: 'https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=800',
        category: 'TOURNAMENTS',
        author: 'Sarah Johnson',
        isPublished: true,
        publishedAt: new Date(Date.now() - 2 * 60 * 60 * 1000), // 2 hours ago
      },
    }),
    prisma.newsArticle.upsert({
      where: { id: 'news-2' },
      update: {},
      create: {
        id: 'news-2',
        title: 'New Poker Strategy Book Released',
        summary: 'Learn advanced techniques from world champion players in this comprehensive guide.',
        content: 'Professional poker player and coach Daniel Martinez has released his highly anticipated strategy book, "Modern Poker Theory". The book covers advanced concepts including GTO play, exploitative strategies, and tournament ICM. Early reviews from poker pros have been overwhelmingly positive, calling it a must-read for serious players.',
        imageUrl: 'https://images.unsplash.com/photo-1514923995763-768e52f5af87?w=800',
        category: 'STRATEGY',
        author: 'Mike Chen',
        isPublished: true,
        publishedAt: new Date(Date.now() - 5 * 60 * 60 * 1000), // 5 hours ago
      },
    }),
    prisma.newsArticle.upsert({
      where: { id: 'news-3' },
      update: {},
      create: {
        id: 'news-3',
        title: 'Online Poker Traffic Hits Record High',
        summary: 'Major poker sites report unprecedented player numbers across all stakes.',
        content: 'The online poker industry is experiencing a renaissance, with major platforms reporting record-breaking player traffic. PokerStars, 888poker, and GGPoker all saw significant increases in cash game and tournament entries last month. Industry analysts attribute the growth to improved mobile apps, innovative features, and increased prize pools.',
        imageUrl: 'https://images.unsplash.com/photo-1516975080664-ed2fc6a32937?w=800',
        category: 'INDUSTRY',
        author: 'Jessica Williams',
        isPublished: true,
        publishedAt: new Date(Date.now() - 24 * 60 * 60 * 1000), // 1 day ago
      },
    }),
  ]);
  console.log(`✅ Created ${news.length} news articles`);

  console.log('✨ Seeding completed!');
}

main()
  .catch((e) => {
    console.error('❌ Seeding failed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

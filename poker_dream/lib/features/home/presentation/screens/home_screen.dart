import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/neon_components.dart';
import '../../../../shared/widgets/command_grid.dart';
import '../../providers/video_providers.dart';
import '../../providers/news_providers.dart';
import '../../../alerts/presentation/screens/alerts_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videosAsync = ref.watch(videosProvider);
    final newsAsync = ref.watch(newsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.backgroundDark,
            title: Row(
              children: [
                Image.asset(
                  'assets/images/logo-white.png',
                  height: 45,
                  fit: BoxFit.contain,
                ),
                const Spacer(),
                // Alerts Icon with Badge
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_outlined,
                        size: 28,
                        color: AppColors.textLight,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AlertsScreen()),
                        );
                      },
                    ),
                    // Notification badge
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.cerise,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: const Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.account_circle,
                    size: 32,
                    color: AppColors.textLight,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video Carousel Section
                  Text(
                    'Latest Highlights',
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: 16),
                  videosAsync.when(
                    data: (videos) {
                      if (videos.isEmpty) {
                        return const SizedBox(
                          height: 220,
                          child: Center(
                            child: Text(
                              'No videos available',
                              style: TextStyle(color: AppColors.textMuted),
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          SizedBox(
                            height: 220,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: videos.length,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                final video = videos[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: _VideoCard(
                                    title: video.title,
                                    thumbnail: video.thumbnailUrl ?? '',
                                    duration: video.formattedDuration,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Animated pill indicators
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              videos.length,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 3),
                                child: AnimatedPill(
                                  isFilled: _currentPage == index,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const SizedBox(
                      height: 220,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accentGold,
                        ),
                      ),
                    ),
                    error: (error, stack) => SizedBox(
                      height: 220,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppColors.textMuted,
                              size: 48,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Failed to load videos',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Command Grid Section
                  Text(
                    'Your Commands',
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: 8),
                  const CommandGrid(),
                  const SizedBox(height: 32),

                  // Latest News Section
                  Text(
                    'From the Rail',
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: 8),
                  newsAsync.when(
                    data: (articles) {
                      if (articles.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Text(
                              'No news available',
                              style: TextStyle(color: AppColors.textMuted),
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: articles.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return _NewsCard(
                            title: article.title,
                            description: article.summary ?? '',
                            image: article.imageUrl ?? '',
                            date: article.timeAgo,
                          );
                        },
                      );
                    },
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(
                          color: AppColors.accentGold,
                        ),
                      ),
                    ),
                    error: (error, stack) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppColors.textMuted,
                              size: 48,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Failed to load news',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final String title;
  final String thumbnail;
  final String duration;

  const _VideoCard({
    required this.title,
    required this.thumbnail,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28), // More rounded!
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            // Thumbnail
            Positioned.fill(
              child: Image.network(
                thumbnail,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.componentDark,
                    child: const Icon(
                      Icons.play_circle_outline,
                      size: 64,
                      color: Colors.white24,
                    ),
                  );
                },
              ),
            ),
            // Dramatic vignette overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.vignetteGradient(),
                ),
              ),
            ),
            // Glowing play button with neon halo
            const Positioned.fill(
              child: Center(
                child: NeonPlayButton(),
              ),
            ),
            // Duration badge (more rounded)
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.55),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  duration,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            // Title at bottom
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final String date;

  const _NewsCard({
    required this.title,
    required this.description,
    required this.image,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      onTap: () {
        // TODO: Navigate to news detail
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            AppColors.glowShadow(blur: 24, opacity: 0.20),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: AspectRatio(
            aspectRatio: 16 / 10,
            child: Stack(
              children: [
                // Full-size background image
                Positioned.fill(
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E)],
                          ),
                        ),
                        child: const Icon(
                          Icons.article,
                          size: 64,
                          color: Colors.white24,
                        ),
                      );
                    },
                  ),
                ),
                // Gradient overlay for readability
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppColors.readabilityGradient(),
                    ),
                  ),
                ),
                // Glassmorphic content area
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CategoryPill(text: 'News'),
                        const SizedBox(height: 8),
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.white70,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              date,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

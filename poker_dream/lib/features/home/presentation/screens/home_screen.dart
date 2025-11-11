import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../models/video_highlight_model.dart';
import '../../models/news_article_model.dart';
import '../../providers/video_providers.dart';
import '../../providers/news_providers.dart';

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
                          // Page indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              videos.length,
                              (index) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: _currentPage == index ? 24 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentPage == index
                                      ? AppColors.accentGold
                                      : AppColors.textMuted.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(4),
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

                  // Latest News Section
                  Text(
                    'Latest News',
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              thumbnail,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 220,
                  color: AppColors.componentDark,
                  child: const Icon(
                    Icons.play_circle_outline,
                    size: 64,
                    color: AppColors.textMuted,
                  ),
                );
              },
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
          // Play button
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.accentGold.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.black,
                size: 32,
              ),
            ),
          ),
          // Duration badge
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                duration,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textLight,
                ),
              ),
            ),
          ),
          // Title
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Text(
              title,
              style: AppTextStyles.heading4.copyWith(
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.8),
                    blurRadius: 4,
                  ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.componentDark,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: Image.network(
              image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: AppColors.componentDark,
                  child: const Icon(
                    Icons.article,
                    size: 48,
                    color: AppColors.textMuted,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.heading4,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.textMuted.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textMuted.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

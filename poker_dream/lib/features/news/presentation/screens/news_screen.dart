import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../home/models/news_article_model.dart';
import '../../../home/providers/news_providers.dart';

class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo-white.png',
              height: 45,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            Text(
              'News',
              style: AppTextStyles.heading3,
            ),
          ],
        ),
      ),
      body: newsAsync.when(
        data: (articles) {
          if (articles.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.article_outlined,
                    size: 64,
                    color: AppColors.textMuted,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No news articles available',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
            itemCount: articles.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final article = articles[index];
              return _NewsCard(article: article);
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColors.accentGold,
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.textMuted,
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load news',
                style: AppTextStyles.heading4.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final NewsArticleModel article;

  const _NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.componentDark,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Article Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: article.imageUrl != null && article.imageUrl!.isNotEmpty
                ? Image.network(
                    article.imageUrl!,
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 80,
                        color: AppColors.componentDark,
                        child: const Icon(
                          Icons.article,
                          color: AppColors.textMuted,
                        ),
                      );
                    },
                  )
                : Container(
                    width: 100,
                    height: 80,
                    color: AppColors.componentDark,
                    child: const Icon(
                      Icons.article,
                      color: AppColors.textMuted,
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          // Article Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: AppTextStyles.heading4,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                if (article.summary != null && article.summary!.isNotEmpty)
                  Text(
                    article.summary!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textMuted,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (article.timeAgo.isNotEmpty) ...[
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppColors.textMuted.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        article.timeAgo,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textMuted.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                    if (article.category.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textMuted.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        article.category,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primary.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
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

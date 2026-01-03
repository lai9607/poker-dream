import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/neon_components.dart';

class SocialFeedScreen extends StatefulWidget {
  const SocialFeedScreen({super.key});

  @override
  State<SocialFeedScreen> createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends State<SocialFeedScreen> {
  // Mock posts data
  final List<_Post> _posts = [
    _Post(
      id: '1',
      author: _Author(
        id: 'user1',
        name: 'Phil Ivey',
        username: '@philivey',
        avatarColor: Colors.purple,
        isVerified: true,
      ),
      content:
          'Just shipped the Super High Roller Bowl for \$3.6M! 🏆 Biggest score of my career. Thank you to everyone who believed in me.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      likes: 15420,
      comments: 892,
      shares: 234,
      isLiked: true,
      images: ['trophy.jpg'],
    ),
    _Post(
      id: '2',
      author: _Author(
        id: 'user2',
        name: 'PokerStars',
        username: '@PokerStars',
        avatarColor: Colors.red,
        isVerified: true,
      ),
      content:
          '🚨 HUGE NEWS! EPT Barcelona Main Event is back with a €5,300 buy-in and €10M GTD prize pool. Register now on PokerStars.',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      likes: 3240,
      comments: 156,
      shares: 89,
      images: [],
    ),
    _Post(
      id: '3',
      author: _Author(
        id: 'user3',
        name: 'Sarah Chen',
        username: '@sarahpoker',
        avatarColor: Colors.teal,
      ),
      content:
          'Session recap: 8 hours at 2/5 NLH, +\$2,850. Key hand was flopping top set vs two opponents who both had overpairs. Patience pays off! 📈',
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      likes: 542,
      comments: 47,
      shares: 12,
    ),
    _Post(
      id: '4',
      author: _Author(
        id: 'user4',
        name: 'Mike Postle',
        username: '@pokercoach',
        avatarColor: Colors.orange,
        isVerified: true,
      ),
      content:
          '🎓 FREE TRAINING: Understanding ICM in final table scenarios. Watch my new 30-minute video breaking down a critical hand from the WSOP.',
      timestamp: DateTime.now().subtract(const Duration(hours: 12)),
      likes: 1890,
      comments: 234,
      shares: 567,
      images: ['training.jpg'],
    ),
    _Post(
      id: '5',
      author: _Author(
        id: 'user5',
        name: 'Vegas Grinder',
        username: '@vegasgrinder',
        avatarColor: Colors.blue,
      ),
      content:
          'Live tournament tip: Always be aware of your stack relative to the average and the blinds. ICM pressure changes everything in the money.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      likes: 324,
      comments: 28,
      shares: 15,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.backgroundDark,
            title: Text('Feed', style: AppTextStyles.heading2),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: AppColors.textLight),
                onPressed: () {
                  // TODO: Search
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: AppColors.textLight),
                onPressed: () {
                  // TODO: Notifications
                },
              ),
            ],
          ),

          // Stories Row
          SliverToBoxAdapter(
            child: SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  _StoryItem(
                    label: 'Your Story',
                    isAddStory: true,
                    onTap: () {},
                  ),
                  _StoryItem(
                    label: 'Phil',
                    avatarColor: Colors.purple,
                    hasUnseenStory: true,
                    onTap: () {},
                  ),
                  _StoryItem(
                    label: 'Sarah',
                    avatarColor: Colors.teal,
                    hasUnseenStory: true,
                    onTap: () {},
                  ),
                  _StoryItem(
                    label: 'PokerStars',
                    avatarColor: Colors.red,
                    hasUnseenStory: false,
                    onTap: () {},
                  ),
                  _StoryItem(
                    label: 'WSOP',
                    avatarColor: Colors.amber,
                    hasUnseenStory: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // Create Post Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: GestureDetector(
                onTap: () => _showCreatePost(context),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.componentDark,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderSubtle),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.neonGold.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: AppColors.neonGold,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "What's on your mind?",
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.photo_library_outlined,
                        color: AppColors.neonGold,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Posts List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: _PostCard(
                  post: _posts[index],
                  onLike: () {
                    setState(() {
                      _posts[index] = _posts[index].copyWith(
                        isLiked: !_posts[index].isLiked,
                        likes: _posts[index].isLiked
                            ? _posts[index].likes - 1
                            : _posts[index].likes + 1,
                      );
                    });
                  },
                ),
              ),
              childCount: _posts.length,
            ),
          ),
        ],
      ),
    );
  }

  void _showCreatePost(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _CreatePostSheet(),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final String label;
  final Color? avatarColor;
  final bool isAddStory;
  final bool hasUnseenStory;
  final VoidCallback onTap;

  const _StoryItem({
    required this.label,
    this.avatarColor,
    this.isAddStory = false,
    this.hasUnseenStory = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Column(
          children: [
            Container(
              width: 68,
              height: 68,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: hasUnseenStory
                    ? const LinearGradient(colors: AppColors.neonGradient)
                    : null,
                border: hasUnseenStory
                    ? null
                    : Border.all(color: AppColors.borderSubtle, width: 2),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isAddStory
                      ? AppColors.componentDark
                      : avatarColor?.withOpacity(0.2),
                  border: Border.all(
                    color: AppColors.backgroundDark,
                    width: 3,
                  ),
                ),
                child: isAddStory
                    ? const Icon(
                        Icons.add,
                        color: AppColors.neonGold,
                        size: 28,
                      )
                    : Center(
                        child: Text(
                          label[0].toUpperCase(),
                          style: TextStyle(
                            color: avatarColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTextStyles.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final _Post post;
  final VoidCallback onLike;

  const _PostCard({
    required this.post,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: post.author.avatarColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: post.author.avatarColor.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      post.author.name[0].toUpperCase(),
                      style: TextStyle(
                        color: post.author.avatarColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.author.name,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (post.author.isVerified) ...[
                            const SizedBox(width: 4),
                            Icon(
                              Icons.verified,
                              size: 16,
                              color: AppColors.info,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${post.author.username} • ${_formatTime(post.timestamp)}',
                        style: AppTextStyles.labelSmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: AppColors.textMuted),
                  onPressed: () => _showOptions(context),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              post.content,
              style: AppTextStyles.bodyMedium.copyWith(height: 1.4),
            ),
          ),

          // Image (if any)
          if (post.images.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.componentDark,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 48,
                  color: Colors.white24,
                ),
              ),
            ),
          ],

          // Stats Row
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  size: 16,
                  color: AppColors.cerise,
                ),
                const SizedBox(width: 4),
                Text(
                  _formatCount(post.likes),
                  style: AppTextStyles.labelSmall,
                ),
                const SizedBox(width: 16),
                Text(
                  '${_formatCount(post.comments)} comments',
                  style: AppTextStyles.labelSmall,
                ),
                const SizedBox(width: 8),
                Text(
                  '${_formatCount(post.shares)} shares',
                  style: AppTextStyles.labelSmall,
                ),
              ],
            ),
          ),

          // Divider
          Divider(color: AppColors.borderSubtle, height: 1),

          // Actions Row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                _ActionButton(
                  icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                  label: 'Like',
                  isActive: post.isLiked,
                  onTap: onLike,
                ),
                _ActionButton(
                  icon: Icons.chat_bubble_outline,
                  label: 'Comment',
                  onTap: () {},
                ),
                _ActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  String _formatCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.charcoal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: const Text('Save Post'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person_add_outlined),
              title: Text('Follow ${post.author.name}'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.block, color: AppColors.error),
              title: const Text('Hide Post', style: TextStyle(color: AppColors.error)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive ? AppColors.cerise : AppColors.textMuted,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isActive ? AppColors.cerise : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreatePostSheet extends StatefulWidget {
  const _CreatePostSheet();

  @override
  State<_CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<_CreatePostSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: AppColors.charcoal.withOpacity(0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle & Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.borderGlow,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: AppColors.textMuted),
                          ),
                        ),
                        const Spacer(),
                        Text('Create Post', style: AppTextStyles.heading4),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: _controller.text.isNotEmpty
                              ? () {
                                  Navigator.pop(context);
                                  // TODO: Create post
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.neonGold,
                            foregroundColor: Colors.black,
                            disabledBackgroundColor: AppColors.componentDark,
                          ),
                          child: const Text('Post'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Divider(color: AppColors.borderSubtle),

              // Content Area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.neonGold.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: AppColors.neonGold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              maxLines: null,
                              style: AppTextStyles.bodyLarge,
                              decoration: InputDecoration(
                                hintText: "What's on your mind?",
                                hintStyle: AppTextStyles.bodyLarge.copyWith(
                                  color: AppColors.textMuted,
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (_) => setState(() {}),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Media Actions
              Container(
                padding: EdgeInsets.fromLTRB(
                  16,
                  12,
                  16,
                  12 + MediaQuery.of(context).padding.bottom,
                ),
                decoration: BoxDecoration(
                  color: AppColors.componentDark,
                  border: Border(
                    top: BorderSide(color: AppColors.borderSubtle),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _MediaAction(
                      icon: Icons.photo_library_outlined,
                      label: 'Photo',
                      color: AppColors.success,
                      onTap: () {},
                    ),
                    _MediaAction(
                      icon: Icons.videocam_outlined,
                      label: 'Video',
                      color: AppColors.error,
                      onTap: () {},
                    ),
                    _MediaAction(
                      icon: Icons.tag,
                      label: 'Tag',
                      color: AppColors.info,
                      onTap: () {},
                    ),
                    _MediaAction(
                      icon: Icons.location_on_outlined,
                      label: 'Location',
                      color: AppColors.warning,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MediaAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MediaAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.labelSmall),
        ],
      ),
    );
  }
}

class _Author {
  final String id;
  final String name;
  final String username;
  final Color avatarColor;
  final bool isVerified;

  _Author({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarColor,
    this.isVerified = false,
  });
}

class _Post {
  final String id;
  final _Author author;
  final String content;
  final DateTime timestamp;
  final int likes;
  final int comments;
  final int shares;
  final bool isLiked;
  final List<String> images;

  _Post({
    required this.id,
    required this.author,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isLiked = false,
    this.images = const [],
  });

  _Post copyWith({
    String? id,
    _Author? author,
    String? content,
    DateTime? timestamp,
    int? likes,
    int? comments,
    int? shares,
    bool? isLiked,
    List<String>? images,
  }) {
    return _Post(
      id: id ?? this.id,
      author: author ?? this.author,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      isLiked: isLiked ?? this.isLiked,
      images: images ?? this.images,
    );
  }
}

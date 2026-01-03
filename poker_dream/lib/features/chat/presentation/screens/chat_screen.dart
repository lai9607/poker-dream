import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'chat_room_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data for rooms
  final List<ChatRoom> _publicRooms = [
    ChatRoom(
      id: 'global',
      name: 'Global Lounge',
      description: 'General chat for all players',
      memberCount: 1247,
      isPublic: true,
      lastMessage: 'Anyone watching the WSOP?',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 2)),
      iconColor: AppColors.neonGold,
      icon: Icons.public,
    ),
    ChatRoom(
      id: 'strategy',
      name: 'Strategy Talk',
      description: 'Discuss hands and strategy',
      memberCount: 534,
      isPublic: true,
      lastMessage: 'What would you do with AK here?',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 15)),
      iconColor: AppColors.info,
      icon: Icons.psychology,
    ),
    ChatRoom(
      id: 'wsop',
      name: 'WSOP 2024',
      description: 'Live WSOP discussion',
      memberCount: 892,
      isPublic: true,
      lastMessage: 'Final table starting soon!',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      iconColor: AppColors.cerise,
      icon: Icons.emoji_events,
    ),
    ChatRoom(
      id: 'cash',
      name: 'Cash Game Grinders',
      description: 'For cash game players',
      memberCount: 423,
      isPublic: true,
      lastMessage: 'Just had a great session at 5/10',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      iconColor: AppColors.success,
      icon: Icons.attach_money,
    ),
  ];

  final List<ChatRoom> _myRooms = [
    ChatRoom(
      id: 'vegas-crew',
      name: 'Vegas Crew',
      description: 'Our Vegas trip group',
      memberCount: 8,
      isPublic: false,
      lastMessage: 'See you all at Aria tomorrow!',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 30)),
      iconColor: Colors.purple,
      icon: Icons.groups,
    ),
    ChatRoom(
      id: 'study-group',
      name: 'MTT Study Group',
      description: 'Tournament strategy study',
      memberCount: 5,
      isPublic: false,
      lastMessage: 'Posted new hand analysis',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
      iconColor: Colors.orange,
      icon: Icons.school,
    ),
  ];

  final List<DirectMessage> _directMessages = [
    DirectMessage(
      odUserId: 'user1',
      username: 'PokerPro88',
      avatarColor: Colors.blue,
      lastMessage: 'Good game yesterday!',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 10)),
      unreadCount: 2,
      isOnline: true,
    ),
    DirectMessage(
      odUserId: 'user2',
      username: 'AceHigh',
      avatarColor: Colors.purple,
      lastMessage: 'Want to play some hands?',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 0,
      isOnline: true,
    ),
    DirectMessage(
      odUserId: 'user3',
      username: 'DanielN',
      avatarColor: Colors.red,
      lastMessage: 'Thanks for the coaching session',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
      isOnline: false,
      isVerified: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Chat', style: AppTextStyles.heading2),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textMuted),
            onPressed: () {
              // TODO: Search
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppColors.neonGold),
            onPressed: () => _showCreateOptions(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.neonGold,
          labelColor: AppColors.neonGold,
          unselectedLabelColor: AppColors.textMuted,
          tabs: const [
            Tab(text: 'Rooms'),
            Tab(text: 'My Rooms'),
            Tab(text: 'DMs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Public Rooms Tab
          _RoomsList(
            rooms: _publicRooms,
            emptyMessage: 'No public rooms available',
            onRoomTap: (room) => _openRoom(context, room),
          ),
          // My Rooms Tab
          _RoomsList(
            rooms: _myRooms,
            emptyMessage: 'You haven\'t joined any private rooms',
            onRoomTap: (room) => _openRoom(context, room),
            showCreateButton: true,
            onCreateTap: () => _showCreateRoomSheet(context),
          ),
          // Direct Messages Tab
          _DirectMessagesList(
            messages: _directMessages,
            onMessageTap: (dm) => _openDirectMessage(context, dm),
          ),
        ],
      ),
    );
  }

  void _showCreateOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.charcoal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create New', style: AppTextStyles.heading3),
              const SizedBox(height: 16),
              ListTile(
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.neonGold.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.group_add, color: AppColors.neonGold),
                ),
                title: const Text('Create Room'),
                subtitle: const Text('Start a new chat room'),
                onTap: () {
                  Navigator.pop(context);
                  _showCreateRoomSheet(context);
                },
              ),
              ListTile(
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.info.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.person_add, color: AppColors.info),
                ),
                title: const Text('New Message'),
                subtitle: const Text('Start a direct conversation'),
                onTap: () {
                  Navigator.pop(context);
                  _showNewMessageSheet(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateRoomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _CreateRoomSheet(),
    );
  }

  void _showNewMessageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _NewMessageSheet(),
    );
  }

  void _openRoom(BuildContext context, ChatRoom room) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatRoomScreen(room: room),
      ),
    );
  }

  void _openDirectMessage(BuildContext context, DirectMessage dm) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatRoomScreen(
          room: ChatRoom(
            id: dm.odUserId,
            name: dm.username,
            description: 'Direct message',
            memberCount: 2,
            isPublic: false,
            isDM: true,
            lastMessage: dm.lastMessage,
            lastMessageTime: dm.lastMessageTime,
            iconColor: dm.avatarColor,
            icon: Icons.person,
          ),
          isDM: true,
          otherUser: dm,
        ),
      ),
    );
  }
}

class _RoomsList extends StatelessWidget {
  final List<ChatRoom> rooms;
  final String emptyMessage;
  final Function(ChatRoom) onRoomTap;
  final bool showCreateButton;
  final VoidCallback? onCreateTap;

  const _RoomsList({
    required this.rooms,
    required this.emptyMessage,
    required this.onRoomTap,
    this.showCreateButton = false,
    this.onCreateTap,
  });

  @override
  Widget build(BuildContext context) {
    if (rooms.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 64, color: AppColors.textMuted),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
            ),
            if (showCreateButton && onCreateTap != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onCreateTap,
                icon: const Icon(Icons.add),
                label: const Text('Create Room'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neonGold,
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rooms.length + (showCreateButton ? 1 : 0),
      itemBuilder: (context, index) {
        if (showCreateButton && index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _CreateRoomCard(onTap: onCreateTap!),
          );
        }
        final room = rooms[showCreateButton ? index - 1 : index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _RoomCard(room: room, onTap: () => onRoomTap(room)),
        );
      },
    );
  }
}

class _CreateRoomCard extends StatelessWidget {
  final VoidCallback onTap;

  const _CreateRoomCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.neonGold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.neonGold.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.neonGold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.add, color: AppColors.neonGold, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create New Room',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.neonGold,
                    ),
                  ),
                  Text(
                    'Start a private or public room',
                    style: AppTextStyles.labelSmall,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.neonGold),
          ],
        ),
      ),
    );
  }
}

class _RoomCard extends StatelessWidget {
  final ChatRoom room;
  final VoidCallback onTap;

  const _RoomCard({required this.room, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.charcoal,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Row(
          children: [
            // Room Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: room.iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(room.icon, color: room.iconColor, size: 24),
            ),
            const SizedBox(width: 14),
            // Room Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          room.name,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        room.isPublic ? Icons.public : Icons.lock,
                        size: 14,
                        color: AppColors.textMuted,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    room.lastMessage ?? room.description,
                    style: AppTextStyles.labelSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Meta Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatTime(room.lastMessageTime),
                  style: AppTextStyles.labelSmall,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.people, size: 12, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      '${room.memberCount}',
                      style: AppTextStyles.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }
}

class _DirectMessagesList extends StatelessWidget {
  final List<DirectMessage> messages;
  final Function(DirectMessage) onMessageTap;

  const _DirectMessagesList({
    required this.messages,
    required this.onMessageTap,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 64, color: AppColors.textMuted),
            const SizedBox(height: 16),
            Text(
              'No messages yet',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final dm = messages[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _DirectMessageCard(dm: dm, onTap: () => onMessageTap(dm)),
        );
      },
    );
  }
}

class _DirectMessageCard extends StatelessWidget {
  final DirectMessage dm;
  final VoidCallback onTap;

  const _DirectMessageCard({required this.dm, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.charcoal,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: dm.avatarColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: dm.avatarColor.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      dm.username[0].toUpperCase(),
                      style: TextStyle(
                        color: dm.avatarColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                if (dm.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.charcoal, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        dm.username,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (dm.isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.verified, size: 14, color: AppColors.info),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dm.lastMessage,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: dm.unreadCount > 0
                          ? AppColors.textLight
                          : AppColors.textMuted,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Time & Unread
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatTime(dm.lastMessageTime),
                  style: AppTextStyles.labelSmall,
                ),
                if (dm.unreadCount > 0) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.cerise,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${dm.unreadCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }
}

class _CreateRoomSheet extends StatefulWidget {
  const _CreateRoomSheet();

  @override
  State<_CreateRoomSheet> createState() => _CreateRoomSheetState();
}

class _CreateRoomSheetState extends State<_CreateRoomSheet> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isPublic = true;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            20 + MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: AppColors.charcoal.withOpacity(0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.borderGlow,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Create Room', style: AppTextStyles.heading3),
                const SizedBox(height: 20),

                // Room Name
                TextField(
                  controller: _nameController,
                  style: AppTextStyles.bodyLarge,
                  decoration: InputDecoration(
                    labelText: 'Room Name',
                    hintText: 'e.g., Vegas Trip 2024',
                    filled: true,
                    fillColor: AppColors.componentDark,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.tag, color: AppColors.textMuted),
                  ),
                ),
                const SizedBox(height: 14),

                // Description
                TextField(
                  controller: _descriptionController,
                  style: AppTextStyles.bodyLarge,
                  decoration: InputDecoration(
                    labelText: 'Description (optional)',
                    hintText: 'What is this room about?',
                    filled: true,
                    fillColor: AppColors.componentDark,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.notes, color: AppColors.textMuted),
                  ),
                ),
                const SizedBox(height: 20),

                // Privacy Toggle
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.componentDark,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Room Type', style: AppTextStyles.labelMedium),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _PrivacyOption(
                              icon: Icons.public,
                              title: 'Public',
                              subtitle: 'Anyone can join',
                              isSelected: _isPublic,
                              onTap: () => setState(() => _isPublic = true),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _PrivacyOption(
                              icon: Icons.lock,
                              title: 'Private',
                              subtitle: 'Invite only',
                              isSelected: !_isPublic,
                              onTap: () => setState(() => _isPublic = false),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Create Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _nameController.text.isNotEmpty
                        ? () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Room created successfully!'),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.neonGold,
                      foregroundColor: Colors.black,
                      disabledBackgroundColor: AppColors.componentDark,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Create Room',
                      style: AppTextStyles.buttonText.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
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

class _PrivacyOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _PrivacyOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.neonGold.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.neonGold : AppColors.borderSubtle,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.neonGold : AppColors.textMuted,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTextStyles.labelMedium.copyWith(
                color: isSelected ? AppColors.neonGold : AppColors.textLight,
              ),
            ),
            Text(
              subtitle,
              style: AppTextStyles.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _NewMessageSheet extends StatefulWidget {
  const _NewMessageSheet();

  @override
  State<_NewMessageSheet> createState() => _NewMessageSheetState();
}

class _NewMessageSheetState extends State<_NewMessageSheet> {
  final _searchController = TextEditingController();

  // Mock users to message
  final List<_SearchUser> _users = [
    _SearchUser(id: 'u1', name: 'PokerPro88', color: Colors.blue, isOnline: true),
    _SearchUser(id: 'u2', name: 'AceHigh', color: Colors.purple, isOnline: true),
    _SearchUser(id: 'u3', name: 'ChipLeader', color: Colors.orange, isOnline: false),
    _SearchUser(id: 'u4', name: 'NittyNate', color: Colors.green, isOnline: true),
    _SearchUser(id: 'u5', name: 'CashGameKing', color: Colors.teal, isOnline: false),
  ];

  @override
  void dispose() {
    _searchController.dispose();
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
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.charcoal.withOpacity(0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderGlow,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('New Message', style: AppTextStyles.heading3),
              const SizedBox(height: 16),

              // Search
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a player...',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textMuted,
                  ),
                  filled: true,
                  fillColor: AppColors.componentDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                ),
              ),
              const SizedBox(height: 16),

              Text('Suggested', style: AppTextStyles.labelMedium),
              const SizedBox(height: 12),

              // User List
              Expanded(
                child: ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    final user = _users[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Stack(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: user.color.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                user.name[0],
                                style: TextStyle(
                                  color: user.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          if (user.isOnline)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.charcoal,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      title: Text(user.name),
                      subtitle: Text(
                        user.isOnline ? 'Online' : 'Offline',
                        style: AppTextStyles.labelSmall,
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: AppColors.textMuted,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        // TODO: Open new DM with user
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchUser {
  final String id;
  final String name;
  final Color color;
  final bool isOnline;

  _SearchUser({
    required this.id,
    required this.name,
    required this.color,
    required this.isOnline,
  });
}

// Data models
class ChatRoom {
  final String id;
  final String name;
  final String description;
  final int memberCount;
  final bool isPublic;
  final bool isDM;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final Color iconColor;
  final IconData icon;

  ChatRoom({
    required this.id,
    required this.name,
    required this.description,
    required this.memberCount,
    required this.isPublic,
    this.isDM = false,
    this.lastMessage,
    this.lastMessageTime,
    required this.iconColor,
    required this.icon,
  });
}

class DirectMessage {
  final String odUserId;
  final String username;
  final Color avatarColor;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isOnline;
  final bool isVerified;

  DirectMessage({
    required this.odUserId,
    required this.username,
    required this.avatarColor,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.isOnline,
    this.isVerified = false,
  });
}

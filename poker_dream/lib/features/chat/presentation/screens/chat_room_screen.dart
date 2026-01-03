import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'chat_screen.dart';

class ChatRoomScreen extends StatefulWidget {
  final ChatRoom room;
  final bool isDM;
  final DirectMessage? otherUser;

  const ChatRoomScreen({
    super.key,
    required this.room,
    this.isDM = false,
    this.otherUser,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  // Mock messages - would be loaded based on room.id
  late List<_ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    // Mock messages for the room
    _messages = [
      _ChatMessage(
        id: '1',
        userId: 'user1',
        username: 'PokerPro88',
        message: 'Hey everyone! ${widget.room.name} is live!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
        avatarColor: Colors.blue,
      ),
      _ChatMessage(
        id: '2',
        userId: 'user2',
        username: 'AceHigh',
        message: 'Great to be here!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 42)),
        avatarColor: Colors.purple,
      ),
      _ChatMessage(
        id: '3',
        userId: 'user3',
        username: 'ChipLeader',
        message: 'What are we discussing today?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 38)),
        avatarColor: Colors.orange,
      ),
      _ChatMessage(
        id: '4',
        userId: 'user1',
        username: 'PokerPro88',
        message: 'I was thinking we could talk about the latest tournament results and share some hand histories.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 35)),
        avatarColor: Colors.blue,
      ),
      _ChatMessage(
        id: '5',
        userId: 'user4',
        username: 'NittyNate',
        message: 'Sounds good! I have a few interesting spots from my session yesterday.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
        avatarColor: Colors.green,
      ),
    ];
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
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
        title: Row(
          children: [
            // Room/User Avatar
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: widget.room.iconColor.withOpacity(0.2),
                borderRadius: widget.isDM
                    ? BorderRadius.circular(18)
                    : BorderRadius.circular(10),
              ),
              child: widget.isDM
                  ? Center(
                      child: Text(
                        widget.room.name[0].toUpperCase(),
                        style: TextStyle(
                          color: widget.room.iconColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : Icon(widget.room.icon,
                      color: widget.room.iconColor, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.room.name,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.isDM
                        ? (widget.otherUser?.isOnline == true
                            ? 'Online'
                            : 'Offline')
                        : '${widget.room.memberCount} members',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: widget.isDM && widget.otherUser?.isOnline == true
                          ? AppColors.success
                          : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          if (!widget.isDM)
            IconButton(
              icon: const Icon(Icons.person_add_outlined,
                  color: AppColors.textMuted),
              onPressed: () => _showInviteSheet(context),
            ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textMuted),
            onPressed: () => _showRoomOptions(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final showAvatar = index == 0 ||
                    _messages[index - 1].userId != message.userId;
                final showTimestamp = index == 0 ||
                    _messages[index - 1]
                            .timestamp
                            .difference(message.timestamp)
                            .inMinutes
                            .abs() >
                        5;

                return Column(
                  children: [
                    if (showTimestamp)
                      _TimestampDivider(time: message.timestamp),
                    _ChatBubble(
                      message: message,
                      showAvatar: showAvatar,
                    ),
                  ],
                );
              },
            ),
          ),

          // Input Area
          _MessageInput(
            controller: _messageController,
            focusNode: _focusNode,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 'currentUser',
        username: 'You',
        message: _messageController.text.trim(),
        timestamp: DateTime.now(),
        avatarColor: AppColors.neonGold,
        isCurrentUser: true,
      ));
    });

    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showInviteSheet(BuildContext context) {
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
              Text('Invite to ${widget.room.name}', style: AppTextStyles.heading4),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.link, color: AppColors.neonGold),
                title: const Text('Copy Invite Link'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invite link copied!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.share, color: AppColors.info),
                title: const Text('Share Room'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Share room
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_search, color: AppColors.success),
                title: const Text('Search Players'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Search and invite players
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRoomOptions(BuildContext context) {
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
              Text(
                widget.isDM ? 'Conversation Options' : 'Room Options',
                style: AppTextStyles.heading4,
              ),
              const SizedBox(height: 16),
              if (!widget.isDM) ...[
                ListTile(
                  leading: const Icon(Icons.people, color: AppColors.textMuted),
                  title: const Text('View Members'),
                  subtitle: Text('${widget.room.memberCount} members'),
                  onTap: () {
                    Navigator.pop(context);
                    _showMembersList(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline, color: AppColors.textMuted),
                  title: const Text('Room Info'),
                  subtitle: Text(widget.room.description),
                  onTap: () => Navigator.pop(context),
                ),
              ],
              ListTile(
                leading: const Icon(Icons.notifications_outlined,
                    color: AppColors.textMuted),
                title: const Text('Mute Notifications'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notifications muted')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.search, color: AppColors.textMuted),
                title: const Text('Search in Chat'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Search in chat
                },
              ),
              const Divider(color: AppColors.borderSubtle),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: AppColors.error),
                title: Text(
                  widget.isDM ? 'Delete Conversation' : 'Leave Room',
                  style: const TextStyle(color: AppColors.error),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMembersList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.charcoal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // Mock members
        final members = [
          _Member('PokerPro88', Colors.blue, true, true),
          _Member('AceHigh', Colors.purple, true, false),
          _Member('ChipLeader', Colors.orange, false, false),
          _Member('NittyNate', Colors.green, true, false),
          _Member('You', AppColors.neonGold, true, false),
        ];

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Members (${members.length})', style: AppTextStyles.heading4),
                const SizedBox(height: 16),
                ...members.map((member) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Stack(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: member.color.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                member.name[0],
                                style: TextStyle(
                                  color: member.color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          if (member.isOnline)
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
                      title: Row(
                        children: [
                          Text(member.name),
                          if (member.isAdmin) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.neonGold.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Admin',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.neonGold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      subtitle: Text(
                        member.isOnline ? 'Online' : 'Offline',
                        style: AppTextStyles.labelSmall,
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TimestampDivider extends StatelessWidget {
  final DateTime time;

  const _TimestampDivider({required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColors.borderSubtle)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              _formatTime(time),
              style: AppTextStyles.labelSmall,
            ),
          ),
          Expanded(child: Divider(color: AppColors.borderSubtle)),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${time.day}/${time.month}';
  }
}

class _ChatBubble extends StatelessWidget {
  final _ChatMessage message;
  final bool showAvatar;

  const _ChatBubble({
    required this.message,
    required this.showAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 8,
        left: showAvatar ? 0 : 46,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showAvatar) ...[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: message.avatarColor.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: message.avatarColor.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  message.username[0].toUpperCase(),
                  style: TextStyle(
                    color: message.avatarColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showAvatar)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Text(
                          message.username,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: message.isCurrentUser
                                ? AppColors.neonGold
                                : AppColors.textLight,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(message.timestamp),
                          style: AppTextStyles.labelSmall,
                        ),
                      ],
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: message.isCurrentUser
                        ? AppColors.neonGold.withOpacity(0.15)
                        : AppColors.componentDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(showAvatar ? 4 : 16),
                      topRight: const Radius.circular(16),
                      bottomLeft: const Radius.circular(16),
                      bottomRight: const Radius.circular(16),
                    ),
                    border: Border.all(
                      color: message.isCurrentUser
                          ? AppColors.neonGold.withOpacity(0.3)
                          : AppColors.borderSubtle,
                    ),
                  ),
                  child: Text(
                    message.message,
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

class _MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSend;

  const _MessageInput({
    required this.controller,
    required this.focusNode,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        border: Border(
          top: BorderSide(color: AppColors.borderSubtle),
        ),
      ),
      child: Row(
        children: [
          // Attachment button
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppColors.textMuted),
            onPressed: () {
              // TODO: Show attachment options
            },
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.componentDark,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      style: AppTextStyles.bodyMedium,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textMuted,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                      maxLines: 3,
                      minLines: 1,
                      onSubmitted: (_) => onSend(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined,
                        color: AppColors.textMuted),
                    onPressed: () {
                      // TODO: Show emoji picker
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onSend,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.neonGold,
                shape: BoxShape.circle,
                boxShadow: [AppColors.glowShadow(blur: 12, opacity: 0.3)],
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String id;
  final String userId;
  final String username;
  final String message;
  final DateTime timestamp;
  final Color avatarColor;
  final bool isCurrentUser;

  _ChatMessage({
    required this.id,
    required this.userId,
    required this.username,
    required this.message,
    required this.timestamp,
    required this.avatarColor,
    this.isCurrentUser = false,
  });
}

class _Member {
  final String name;
  final Color color;
  final bool isOnline;
  final bool isAdmin;

  _Member(this.name, this.color, this.isOnline, this.isAdmin);
}

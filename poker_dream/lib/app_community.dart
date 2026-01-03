import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/community/presentation/screens/community_main_screen.dart';

class PokerDreamCommunityApp extends StatelessWidget {
  const PokerDreamCommunityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Poker Dream',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const CommunityMainScreen(),
      ),
    );
  }
}

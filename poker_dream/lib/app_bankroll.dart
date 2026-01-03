import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/bankroll/presentation/screens/bankroll_main_screen.dart';

class PokerDreamBankrollApp extends StatelessWidget {
  const PokerDreamBankrollApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Poker Dream Bankroll',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const BankrollMainScreen(),
      ),
    );
  }
}

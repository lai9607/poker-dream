import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/series/presentation/screens/series_screen.dart';
import 'features/news/presentation/screens/news_screen.dart';
import 'features/alerts/presentation/screens/alerts_screen.dart';
import 'features/more/presentation/screens/more_screen.dart';
import 'shared/widgets/bottom_nav_bar.dart';

class PokerDreamApp extends StatelessWidget {
  const PokerDreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poker Dream',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SeriesScreen(),
    NewsScreen(),
    AlertsScreen(),
    MoreScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_bankroll.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0E0F11),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const PokerDreamBankrollApp());
}

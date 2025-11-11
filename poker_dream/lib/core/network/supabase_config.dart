import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase configuration and initialization
class SupabaseConfig {
  SupabaseConfig._();

  // TODO: Replace with your actual Supabase credentials
  // Get these from: https://app.supabase.com/project/_/settings/api
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  /// Initialize Supabase
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: true, // Set to false in production
    );
  }

  /// Get Supabase client instance
  static SupabaseClient get client => Supabase.instance.client;

  /// Check if user is authenticated
  static bool get isAuthenticated => client.auth.currentUser != null;

  /// Get current user
  static User? get currentUser => client.auth.currentUser;
}

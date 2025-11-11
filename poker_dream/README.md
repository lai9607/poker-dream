# Poker Dream

A Flutter mobile application for poker tournament and event information, featuring live tournament updates, news, alerts, and series information.

## Features

- **Home**: Video highlights, latest news, and sponsor showcases
- **Series**: Browse upcoming, live, and completed tournament series
- **News**: Stay updated with poker industry news and strategy guides
- **Alerts**: Real-time notifications for tournaments and player updates
- **More**: Settings, preferences, and account management

## Tech Stack

- **Frontend**: Flutter 3.24+ (Dart 3.9+)
- **Backend**: Supabase (PostgreSQL + Auth + Realtime + Storage)
- **State Management**: Riverpod 2.5+
- **Navigation**: Go Router 14+
- **API Client**: Dio + Retrofit
- **Local Storage**: Hive / SharedPreferences
- **Real-time**: Supabase Realtime (WebSockets)

## Prerequisites

- Flutter SDK 3.24 or higher
- Dart SDK 3.9 or higher
- Xcode (for iOS development)
- Android Studio (for Android development)
- Supabase account
- Firebase account (for push notifications)

## Getting Started

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd poker_dream
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Set Up Supabase

1. Create a new project at [supabase.com](https://supabase.com)
2. Go to Project Settings > API
3. Copy your project URL and anon key
4. Run the database schema:
   - Open Supabase SQL Editor
   - Copy and paste the contents of `supabase_schema.sql`
   - Run the script

### 4. Configure Environment Variables

1. Copy the example environment file:
```bash
cp .env.example .env
```

2. Edit `.env` and add your Supabase credentials:
```
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
```

3. Update `lib/core/network/supabase_config.dart` with your credentials:
```dart
static const String supabaseUrl = 'YOUR_SUPABASE_URL';
static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
```

### 5. Set Up Firebase (for Push Notifications)

#### iOS:
1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Add iOS app to your Firebase project
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/`

#### Android:
1. Add Android app to your Firebase project
2. Download `google-services.json`
3. Place it in `android/app/`

### 6. Run the App

```bash
# Run on iOS
flutter run -d ios

# Run on Android
flutter run -d android

# Run on specific device
flutter devices
flutter run -d <device-id>
```

## Project Structure

```
lib/
├── main.dart                     # App entry point
├── app.dart                      # Root app widget with navigation
├── core/
│   ├── constants/
│   │   ├── app_colors.dart       # Color palette
│   │   └── app_text_styles.dart  # Typography
│   ├── theme/
│   │   └── app_theme.dart        # Theme configuration
│   ├── network/
│   │   └── supabase_config.dart  # Supabase setup
│   └── utils/
├── features/
│   ├── home/
│   │   ├── data/
│   │   ├── presentation/
│   │   └── domain/
│   ├── series/
│   ├── tournament_details/
│   ├── news/
│   ├── alerts/
│   ├── more/
│   └── auth/
├── shared/
│   └── widgets/
│       └── bottom_nav_bar.dart   # Bottom navigation
└── routes/
```

## Design System

### Colors

- **Primary Red**: `#E53935`
- **Accent Gold**: `#FFD700`
- **Background Dark**: `#121212`
- **Card Dark**: `#1E1E1E`
- **Text Light**: `#EAEAEA`
- **Text Muted**: `#B0B0B0`

### Typography

- **Font Family**: Space Grotesk, Be Vietnam Pro
- **Font Weights**: 300, 400, 500, 700

## Database Schema

The database includes the following tables:

- `tournaments` - Tournament series information
- `players` - Player profiles
- `tournament_standings` - Live player standings
- `tournament_structure` - Blind levels and payouts
- `news_articles` - News and articles
- `video_highlights` - Video content
- `user_alerts` - User notifications
- `user_preferences` - User settings
- `sponsors` - Sponsor information

See `supabase_schema.sql` for the complete schema.

## API Integration

### Example: Fetching Tournaments

```dart
import 'package:poker_dream/core/network/supabase_config.dart';

final response = await SupabaseConfig.client
  .from('tournaments')
  .select()
  .eq('status', 'upcoming')
  .order('start_date');
```

### Real-time Updates

```dart
SupabaseConfig.client
  .from('tournament_standings')
  .stream(primaryKey: ['id'])
  .eq('tournament_id', tournamentId)
  .listen((data) {
    // Update UI with new standings
  });
```

## Code Generation

This project uses code generation for models and providers:

```bash
# Generate once
flutter pub run build_runner build

# Watch for changes
flutter pub run build_runner watch

# Clean and rebuild
flutter pub run build_runner build --delete-conflicting-outputs
```

## Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test
flutter test test/unit/some_test.dart
```

## Building for Production

### Android

```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

### iOS

```bash
flutter build ipa --release
# Output: build/ios/ipa/
```

## Support

For support, email support@pokerdream.com or open an issue in the repository.

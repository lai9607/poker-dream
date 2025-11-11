# Poker Dream - Quick Setup Guide

## What's Been Set Up

I've successfully created a complete Flutter project structure for Poker Dream with:

1. **Project Structure** - Clean architecture with features, core, and shared modules
2. **Theme System** - Dark theme matching your HTML designs (colors, typography, styles)
3. **Bottom Navigation** - 5-tab navigation bar (Home, Series, News, Alerts, More)
4. **Supabase Configuration** - Database schema and backend setup ready
5. **All Dependencies** - Installed and configured

## Next Steps to Get Running

### Step 1: Set Up Supabase Backend

1. Go to [supabase.com](https://supabase.com) and create a free account
2. Create a new project
3. Once created, go to **Project Settings > API**
4. Copy your:
   - Project URL (looks like: `https://xxxxx.supabase.co`)
   - Anon/Public key (long string starting with `eyJ...`)

### Step 2: Configure Your App

Open `lib/core/network/supabase_config.dart` and replace:

```dart
static const String supabaseUrl = 'YOUR_SUPABASE_URL';
static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
```

With your actual credentials:

```dart
static const String supabaseUrl = 'https://xxxxx.supabase.co';
static const String supabaseAnonKey = 'eyJhbGc...your-key-here';
```

### Step 3: Set Up Database

1. In Supabase, go to **SQL Editor**
2. Open the file `supabase_schema.sql` from the project root
3. Copy all the SQL code
4. Paste it into the Supabase SQL Editor
5. Click **Run** to create all tables

This creates:
- tournaments table
- players table
- tournament_standings table
- news_articles table
- video_highlights table
- user_alerts table
- user_preferences table
- sponsors table

### Step 4: Run the App

```bash
# Make sure you're in the poker_dream directory
cd poker_dream

# Check connected devices
flutter devices

# Run on iOS simulator
flutter run -d ios

# Run on Android emulator
flutter run -d android
```

## Project File Structure

```
poker_dream/
├── lib/
│   ├── main.dart                    # Entry point
│   ├── app.dart                     # Main app with navigation
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart      # Color palette (#E53935, #FFD700, etc.)
│   │   │   └── app_text_styles.dart # Typography (Space Grotesk)
│   │   ├── theme/
│   │   │   └── app_theme.dart       # Dark theme configuration
│   │   └── network/
│   │       └── supabase_config.dart # Backend setup
│   ├── features/
│   │   ├── home/                    # Home screen with highlights
│   │   ├── series/                  # Tournament series screen
│   │   ├── news/                    # News feed screen
│   │   ├── alerts/                  # Notifications screen
│   │   └── more/                    # Settings screen
│   └── shared/
│       └── widgets/
│           └── bottom_nav_bar.dart  # 5-tab navigation
└── supabase_schema.sql              # Database schema
```

## Design System

### Colors Already Configured
- Primary Red: `#E53935`
- Accent Gold: `#FFD700`
- Background Dark: `#121212`
- Card Dark: `#1E1E1E`
- Text Light: `#EAEAEA`
- Text Muted: `#B0B0B0`

### Fonts
- Space Grotesk (primary)
- Be Vietnam Pro (alternative)

## What You Can Do Now

1. **Run the app** - It will show placeholder UI for all 5 screens
2. **Test navigation** - Tap between Home, Series, News, Alerts, More
3. **Add real data** - Insert data into Supabase tables
4. **Build features** - Start implementing API calls to fetch real data

## Optional: Firebase Setup (for Push Notifications)

If you want push notifications later:

1. Create Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Add iOS app and download `GoogleService-Info.plist` → put in `ios/Runner/`
3. Add Android app and download `google-services.json` → put in `android/app/`

## Testing

```bash
# Run tests
flutter test

# Run app in debug mode
flutter run

# Build for release
flutter build apk        # Android
flutter build ios        # iOS
```

## Troubleshooting

### App won't connect to Supabase
- Check your Supabase URL and key are correct
- Make sure you ran the SQL schema
- Verify your internet connection

### Build errors
```bash
flutter clean
flutter pub get
flutter run
```

### Can't see data
- Check Supabase table browser to verify data exists
- Look at Flutter console for error messages
- Make sure RLS policies allow public read access

## Next Development Steps

1. **Connect Home Screen** to fetch real video highlights and news
2. **Series Screen** - Implement tournament filtering (upcoming/live/completed)
3. **Tournament Details** - Create detail pages for each tournament
4. **Real-time Updates** - Use Supabase subscriptions for live standings
5. **Authentication** - Add user login/signup
6. **User Favorites** - Let users favorite tournaments and players

## Resources

- [Flutter Docs](https://docs.flutter.dev/)
- [Supabase Docs](https://supabase.com/docs)
- [Riverpod Docs](https://riverpod.dev/)
- Project README: `README.md`

---

**Ready to start building!** The foundation is complete. Now you can focus on implementing the business logic and connecting to real data.

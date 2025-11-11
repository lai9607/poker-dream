-- Poker Dream Database Schema
-- Run this in your Supabase SQL Editor: https://app.supabase.com/project/_/sql

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ==========================================
-- TOURNAMENTS TABLE
-- ==========================================
CREATE TABLE IF NOT EXISTS tournaments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  description TEXT,
  start_date TIMESTAMP WITH TIME ZONE,
  end_date TIMESTAMP WITH TIME ZONE,
  location TEXT,
  venue TEXT,
  status TEXT CHECK (status IN ('upcoming', 'live', 'completed')) DEFAULT 'upcoming',
  prize_pool DECIMAL(15, 2),
  buy_in DECIMAL(10, 2),
  total_entries INTEGER DEFAULT 0,
  banner_image_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ==========================================
-- PLAYERS TABLE
-- ==========================================
CREATE TABLE IF NOT EXISTS players (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  country TEXT,
  country_code TEXT,
  flag_url TEXT,
  profile_image_url TEXT,
  bio TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ==========================================
-- TOURNAMENT STANDINGS TABLE
-- ==========================================
CREATE TABLE IF NOT EXISTS tournament_standings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tournament_id UUID REFERENCES tournaments(id) ON DELETE CASCADE,
  player_id UUID REFERENCES players(id) ON DELETE CASCADE,
  rank INTEGER,
  chips BIGINT,
  is_survivor BOOLEAN DEFAULT false,
  prize_amount DECIMAL(12, 2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(tournament_id, player_id)
);

-- ==========================================
-- TOURNAMENT STRUCTURE TABLE (Blind Levels)
-- ==========================================
CREATE TABLE IF NOT EXISTS tournament_structure (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tournament_id UUID REFERENCES tournaments(id) ON DELETE CASCADE,
  level INTEGER NOT NULL,
  small_blind INTEGER,
  big_blind INTEGER,
  ante INTEGER DEFAULT 0,
  duration_minutes INTEGER DEFAULT 60,
  is_break BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ==========================================
-- NEWS ARTICLES TABLE
-- ==========================================
CREATE TABLE IF NOT EXISTS news_articles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  summary TEXT,
  content TEXT,
  image_url TEXT,
  category TEXT CHECK (category IN ('tournaments', 'industry', 'strategy', 'player_interview', 'general')) DEFAULT 'general',
  author TEXT,
  published_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ==========================================
-- VIDEO HIGHLIGHTS TABLE
-- ==========================================
CREATE TABLE IF NOT EXISTS video_highlights (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  description TEXT,
  video_url TEXT NOT NULL,
  thumbnail_url TEXT,
  duration_seconds INTEGER,
  tournament_id UUID REFERENCES tournaments(id) ON DELETE SET NULL,
  view_count INTEGER DEFAULT 0,
  published_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ==========================================
-- USER ALERTS TABLE
-- ==========================================
CREATE TABLE IF NOT EXISTS user_alerts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  message TEXT,
  type TEXT CHECK (type IN ('tournament', 'player', 'news', 'system', 'promotion')) DEFAULT 'system',
  related_id UUID, -- Can reference tournament_id, player_id, etc.
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ==========================================
-- USER PREFERENCES TABLE
-- ==========================================
CREATE TABLE IF NOT EXISTS user_preferences (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE,
  language TEXT DEFAULT 'en',
  notifications_enabled BOOLEAN DEFAULT true,
  dark_mode_enabled BOOLEAN DEFAULT true,
  favorite_tournaments UUID[],
  favorite_players UUID[],
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ==========================================
-- SPONSORS TABLE
-- ==========================================
CREATE TABLE IF NOT EXISTS sponsors (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  logo_url TEXT NOT NULL,
  website_url TEXT,
  display_order INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ==========================================
-- INDEXES
-- ==========================================
CREATE INDEX idx_tournaments_status ON tournaments(status);
CREATE INDEX idx_tournaments_dates ON tournaments(start_date, end_date);
CREATE INDEX idx_tournament_standings_tournament ON tournament_standings(tournament_id);
CREATE INDEX idx_tournament_standings_rank ON tournament_standings(rank);
CREATE INDEX idx_news_category ON news_articles(category);
CREATE INDEX idx_news_published ON news_articles(published_at DESC);
CREATE INDEX idx_user_alerts_user ON user_alerts(user_id);
CREATE INDEX idx_user_alerts_read ON user_alerts(is_read);

-- ==========================================
-- ROW LEVEL SECURITY (RLS)
-- ==========================================

-- Enable RLS on all tables
ALTER TABLE tournaments ENABLE ROW LEVEL SECURITY;
ALTER TABLE players ENABLE ROW LEVEL SECURITY;
ALTER TABLE tournament_standings ENABLE ROW LEVEL SECURITY;
ALTER TABLE tournament_structure ENABLE ROW LEVEL SECURITY;
ALTER TABLE news_articles ENABLE ROW LEVEL SECURITY;
ALTER TABLE video_highlights ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_alerts ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_preferences ENABLE ROW LEVEL SECURITY;
ALTER TABLE sponsors ENABLE ROW LEVEL SECURITY;

-- Public read access for tournaments, players, standings, news, videos, sponsors
CREATE POLICY "Public can read tournaments" ON tournaments FOR SELECT USING (true);
CREATE POLICY "Public can read players" ON players FOR SELECT USING (true);
CREATE POLICY "Public can read standings" ON tournament_standings FOR SELECT USING (true);
CREATE POLICY "Public can read structure" ON tournament_structure FOR SELECT USING (true);
CREATE POLICY "Public can read news" ON news_articles FOR SELECT USING (true);
CREATE POLICY "Public can read videos" ON video_highlights FOR SELECT USING (true);
CREATE POLICY "Public can read sponsors" ON sponsors FOR SELECT USING (is_active = true);

-- User-specific access for alerts and preferences
CREATE POLICY "Users can read own alerts" ON user_alerts FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can update own alerts" ON user_alerts FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can read own preferences" ON user_preferences FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can update own preferences" ON user_preferences FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own preferences" ON user_preferences FOR INSERT WITH CHECK (auth.uid() = user_id);

-- ==========================================
-- FUNCTIONS & TRIGGERS
-- ==========================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply update_updated_at trigger to relevant tables
CREATE TRIGGER update_tournaments_updated_at BEFORE UPDATE ON tournaments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_players_updated_at BEFORE UPDATE ON players
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_standings_updated_at BEFORE UPDATE ON tournament_standings
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_news_updated_at BEFORE UPDATE ON news_articles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_preferences_updated_at BEFORE UPDATE ON user_preferences
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ==========================================
-- SAMPLE DATA (Optional - for testing)
-- ==========================================

-- Insert sample sponsors
INSERT INTO sponsors (name, logo_url, display_order, is_active) VALUES
  ('PokerStars', 'https://example.com/logos/pokerstars.png', 1, true),
  ('888poker', 'https://example.com/logos/888poker.png', 2, true),
  ('PartyPoker', 'https://example.com/logos/partypoker.png', 3, true)
ON CONFLICT DO NOTHING;

-- Insert sample tournament
INSERT INTO tournaments (name, description, start_date, end_date, location, venue, status, prize_pool, buy_in, total_entries, banner_image_url)
VALUES (
  'World Series of Poker',
  'The most prestigious poker tournament in the world',
  '2024-11-15 00:00:00+00',
  '2024-12-05 23:59:59+00',
  'Las Vegas, NV',
  'Rio All-Suite Hotel & Casino',
  'upcoming',
  10000000.00,
  10000.00,
  0,
  'https://example.com/wsop-banner.jpg'
)
ON CONFLICT DO NOTHING;

-- Insert sample news article
INSERT INTO news_articles (title, summary, content, category, author, image_url)
VALUES (
  'Major Tournament Results Are In',
  'Find out who took home the grand prize in the latest series.',
  'Full article content here...',
  'tournaments',
  'Poker Dream Staff',
  'https://example.com/news-image.jpg'
)
ON CONFLICT DO NOTHING;

-- ==========================================
-- REALTIME CONFIGURATION
-- ==========================================

-- Enable realtime for tournament standings (for live updates)
ALTER PUBLICATION supabase_realtime ADD TABLE tournament_standings;
ALTER PUBLICATION supabase_realtime ADD TABLE user_alerts;

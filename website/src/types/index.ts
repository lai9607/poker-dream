// Tournament Types
export interface Tournament {
  id: string;
  name: string;
  description: string;
  startDate: string;
  endDate: string;
  location: string;
  venue: string;
  status: TournamentStatus;
  prizePool: number;
  buyIn: number;
  totalEntries: number;
  imageUrl?: string;
  structure?: TournamentStructure;
  standings?: Standing[];
}

export type TournamentStatus = "UPCOMING" | "LIVE" | "COMPLETED" | "CANCELLED";

export interface TournamentStructure {
  id: string;
  levels: BlindLevel[];
  startingChips: number;
  lateRegistrationLevel: number;
}

export interface BlindLevel {
  level: number;
  smallBlind: number;
  bigBlind: number;
  ante: number;
  duration: number; // minutes
}

// Player Types
export interface Player {
  id: string;
  name: string;
  country: string;
  countryCode: string;
  profileImage?: string;
  totalEarnings?: number;
  dpoyPoints?: number;
  rank?: number;
}

export interface Standing {
  id: string;
  tournamentId: string;
  player: Player;
  rank: number;
  chips: number;
  isSurvivor: boolean;
  prizeAmount?: number;
}

// News Types
export interface NewsArticle {
  id: string;
  title: string;
  summary: string;
  content: string;
  imageUrl?: string;
  category: NewsCategory;
  author: string;
  publishedAt: string;
  createdAt: string;
  updatedAt: string;
}

export type NewsCategory = "TOURNAMENT" | "STRATEGY" | "PLAYER_INTERVIEW" | "ANNOUNCEMENT" | "PROMOTION";

// Video Types
export interface VideoHighlight {
  id: string;
  title: string;
  description: string;
  url: string;
  thumbnailUrl?: string;
  duration: number;
  tournamentId?: string;
  viewCount: number;
  createdAt: string;
}

// Gallery Types
export interface GalleryImage {
  id: string;
  url: string;
  thumbnailUrl: string;
  caption?: string;
  tournamentId?: string;
  type: GalleryType;
  createdAt: string;
}

export type GalleryType = "TOURNAMENT" | "CHAMPION" | "EVENT";

// Career Types
export interface JobListing {
  id: string;
  title: string;
  department: string;
  location: string;
  type: JobType;
  description: string;
  requirements: string[];
  responsibilities: string[];
  createdAt: string;
}

export type JobType = "FULL_TIME" | "PART_TIME" | "CONTRACT" | "INTERNSHIP";

// Contact Types
export interface ContactForm {
  name: string;
  email: string;
  phone?: string;
  subject: string;
  message: string;
  type: ContactType;
}

export type ContactType = "GENERAL" | "PARTNERSHIP" | "MEDIA" | "SUPPORT";

// Sponsor Types
export interface Sponsor {
  id: string;
  name: string;
  logoUrl: string;
  website?: string;
  tier: SponsorTier;
  displayOrder: number;
}

export type SponsorTier = "PLATINUM" | "GOLD" | "SILVER" | "BRONZE";

// DPOY Types
export interface DPOYEntry {
  rank: number;
  player: Player;
  points: number;
  eventsPlayed: number;
  bestFinish: number;
}

// Live Report Types
export interface LiveReport {
  id: string;
  tournamentId: string;
  tournament: Tournament;
  title: string;
  updates: LiveUpdate[];
  createdAt: string;
}

export interface LiveUpdate {
  id: string;
  timestamp: string;
  content: string;
  type: UpdateType;
  playerMentions?: Player[];
}

export type UpdateType = "CHIP_COUNT" | "ELIMINATION" | "BREAK" | "LEVEL_UP" | "GENERAL";

// Navigation Types
export interface NavItem {
  label: string;
  href: string;
  children?: NavItem[];
}

// API Response Types
export interface ApiResponse<T> {
  data: T;
  message?: string;
  success: boolean;
}

export interface PaginatedResponse<T> {
  data: T[];
  total: number;
  page: number;
  limit: number;
  totalPages: number;
}

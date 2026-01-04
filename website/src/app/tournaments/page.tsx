"use client";

import { useState } from "react";
import Link from "next/link";
import { motion } from "framer-motion";
import {
  Calendar,
  MapPin,
  Users,
  Trophy,
  Search,
  Filter,
  ChevronDown,
} from "lucide-react";
import { Card, CardContent, CardImage } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { formatCurrency, formatDate } from "@/lib/utils";
import { Tournament, TournamentStatus } from "@/types";

// Mock data - replace with API call
const allTournaments: Tournament[] = [
  {
    id: "1",
    name: "Poker Dream 18 Main Event",
    description: "The flagship event of the Poker Dream series with RM 5M guaranteed",
    startDate: "2025-02-15",
    endDate: "2025-02-20",
    location: "Genting Highlands",
    venue: "Resorts World Genting",
    status: "UPCOMING",
    prizePool: 5000000,
    buyIn: 3300,
    totalEntries: 0,
    imageUrl: "https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=800",
  },
  {
    id: "2",
    name: "High Roller Championship",
    description: "Elite tournament for high stakes players",
    startDate: "2025-02-18",
    endDate: "2025-02-19",
    location: "Genting Highlands",
    venue: "Resorts World Genting",
    status: "UPCOMING",
    prizePool: 2000000,
    buyIn: 11000,
    totalEntries: 0,
    imageUrl: "https://images.unsplash.com/photo-1606167668584-78701c57f13d?w=800",
  },
  {
    id: "3",
    name: "Super Stack Turbo",
    description: "Fast-paced action with deep stacks",
    startDate: "2025-02-16",
    endDate: "2025-02-16",
    location: "Genting Highlands",
    venue: "Resorts World Genting",
    status: "LIVE",
    prizePool: 500000,
    buyIn: 550,
    totalEntries: 245,
    imageUrl: "https://images.unsplash.com/photo-1609743522653-52354461eb27?w=800",
  },
  {
    id: "4",
    name: "Mystery Bounty",
    description: "Exciting bounty format with mystery prizes",
    startDate: "2025-02-17",
    endDate: "2025-02-17",
    location: "Genting Highlands",
    venue: "Resorts World Genting",
    status: "UPCOMING",
    prizePool: 800000,
    buyIn: 1100,
    totalEntries: 0,
    imageUrl: "https://images.unsplash.com/photo-1511193311914-0346f16efe90?w=800",
  },
  {
    id: "5",
    name: "Poker Dream 17 Main Event",
    description: "Previous series main event",
    startDate: "2024-12-10",
    endDate: "2024-12-15",
    location: "Genting Highlands",
    venue: "Resorts World Genting",
    status: "COMPLETED",
    prizePool: 4500000,
    buyIn: 3300,
    totalEntries: 1250,
    imageUrl: "https://images.unsplash.com/photo-1541123603104-512919d6a96c?w=800",
  },
  {
    id: "6",
    name: "Ladies Championship",
    description: "Exclusive ladies-only tournament",
    startDate: "2025-02-19",
    endDate: "2025-02-19",
    location: "Genting Highlands",
    venue: "Resorts World Genting",
    status: "UPCOMING",
    prizePool: 200000,
    buyIn: 550,
    totalEntries: 0,
    imageUrl: "https://images.unsplash.com/photo-1556866261-8763a7662333?w=800",
  },
];

const statusOptions: { value: TournamentStatus | "ALL"; label: string }[] = [
  { value: "ALL", label: "All Status" },
  { value: "LIVE", label: "Live Now" },
  { value: "UPCOMING", label: "Upcoming" },
  { value: "COMPLETED", label: "Completed" },
];

const buyInOptions = [
  { value: "all", label: "All Buy-ins" },
  { value: "low", label: "Under RM 1,000" },
  { value: "mid", label: "RM 1,000 - 5,000" },
  { value: "high", label: "Over RM 5,000" },
];

export default function TournamentsPage() {
  const [searchQuery, setSearchQuery] = useState("");
  const [statusFilter, setStatusFilter] = useState<TournamentStatus | "ALL">("ALL");
  const [buyInFilter, setBuyInFilter] = useState("all");
  const [showFilters, setShowFilters] = useState(false);

  const filteredTournaments = allTournaments.filter((tournament) => {
    // Search filter
    if (
      searchQuery &&
      !tournament.name.toLowerCase().includes(searchQuery.toLowerCase())
    ) {
      return false;
    }

    // Status filter
    if (statusFilter !== "ALL" && tournament.status !== statusFilter) {
      return false;
    }

    // Buy-in filter
    if (buyInFilter === "low" && tournament.buyIn >= 1000) return false;
    if (buyInFilter === "mid" && (tournament.buyIn < 1000 || tournament.buyIn > 5000))
      return false;
    if (buyInFilter === "high" && tournament.buyIn <= 5000) return false;

    return true;
  });

  const liveTournaments = filteredTournaments.filter((t) => t.status === "LIVE");
  const upcomingTournaments = filteredTournaments.filter((t) => t.status === "UPCOMING");
  const completedTournaments = filteredTournaments.filter((t) => t.status === "COMPLETED");

  return (
    <div style={{ paddingTop: "80px" }}>
      {/* Hero Section */}
      <section style={{ padding: "64px 0", background: "#121212" }}>
        <div className="container">
          <div style={{ maxWidth: "672px" }}>
            <span
              style={{
                display: "inline-block",
                padding: "8px 16px",
                marginBottom: "24px",
                fontSize: "14px",
                fontWeight: 600,
                color: "#FFD700",
                background: "rgba(255, 215, 0, 0.1)",
                borderRadius: "9999px",
                border: "1px solid rgba(255, 215, 0, 0.3)",
              }}
            >
              Tournament Schedule
            </span>
            <h1 style={{ fontSize: "clamp(32px, 5vw, 48px)", fontWeight: 700, marginBottom: "16px", color: "#fff" }}>
              Tournaments
            </h1>
            <p style={{ fontSize: "18px", color: "#888", lineHeight: 1.6 }}>
              Browse our complete schedule of poker tournaments. From daily events
              to major championship series.
            </p>
          </div>
        </div>
      </section>

      {/* Filters Section */}
      <section
        style={{
          padding: "24px 0",
          borderBottom: "1px solid #333",
          position: "sticky",
          top: "80px",
          background: "#0A0A0A",
          zIndex: 30,
        }}
      >
        <div className="container">
          <div style={{ display: "flex", flexDirection: "column", gap: "16px" }} className="md:flex-row">
            {/* Search */}
            <div style={{ position: "relative", flex: 1 }}>
              <Search style={{ position: "absolute", left: "14px", top: "50%", transform: "translateY(-50%)", width: "20px", height: "20px", color: "#666" }} />
              <Input
                type="text"
                placeholder="Search tournaments..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                hasIcon
              />
            </div>

            {/* Filter Toggle (Mobile) */}
            <Button
              variant="outline"
              className="md:hidden"
              onClick={() => setShowFilters(!showFilters)}
            >
              <Filter className="w-4 h-4 mr-2" />
              Filters
              <ChevronDown
                className={`w-4 h-4 ml-2 transition-transform ${
                  showFilters ? "rotate-180" : ""
                }`}
              />
            </Button>

            {/* Filters (Desktop always visible, Mobile toggleable) */}
            <div
              className={`flex flex-col md:flex-row gap-4 ${
                showFilters ? "block" : "hidden md:flex"
              }`}
            >
              <select
                value={statusFilter}
                onChange={(e) =>
                  setStatusFilter(e.target.value as TournamentStatus | "ALL")
                }
                style={{
                  padding: "12px 16px",
                  borderRadius: "8px",
                  background: "#1E1E1E",
                  border: "1px solid #333",
                  color: "#fff",
                  fontSize: "14px",
                }}
              >
                {statusOptions.map((option) => (
                  <option key={option.value} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>

              <select
                value={buyInFilter}
                onChange={(e) => setBuyInFilter(e.target.value)}
                style={{
                  padding: "12px 16px",
                  borderRadius: "8px",
                  background: "#1E1E1E",
                  border: "1px solid #333",
                  color: "#fff",
                  fontSize: "14px",
                }}
              >
                {buyInOptions.map((option) => (
                  <option key={option.value} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>
            </div>
          </div>
        </div>
      </section>

      {/* Tournament Listings */}
      <section style={{ padding: "48px 0" }}>
        <div className="container">
          {/* Live Tournaments */}
          {liveTournaments.length > 0 && (
            <div style={{ marginBottom: "48px" }}>
              <h2 style={{ fontSize: "24px", fontWeight: 700, marginBottom: "24px", display: "flex", alignItems: "center", gap: "8px", color: "#fff" }}>
                <span style={{ width: "12px", height: "12px", background: "#E53935", borderRadius: "50%" }} />
                Live Now
              </h2>
              <div style={{ display: "grid", gridTemplateColumns: "repeat(1, 1fr)", gap: "24px" }} className="md:grid-cols-2 lg:grid-cols-3">
                {liveTournaments.map((tournament) => (
                  <TournamentCard key={tournament.id} tournament={tournament} />
                ))}
              </div>
            </div>
          )}

          {/* Upcoming Tournaments */}
          {upcomingTournaments.length > 0 && (
            <div style={{ marginBottom: "48px" }}>
              <h2 style={{ fontSize: "24px", fontWeight: 700, marginBottom: "24px", color: "#fff" }}>Upcoming Events</h2>
              <div style={{ display: "grid", gridTemplateColumns: "repeat(1, 1fr)", gap: "24px" }} className="md:grid-cols-2 lg:grid-cols-3">
                {upcomingTournaments.map((tournament) => (
                  <TournamentCard key={tournament.id} tournament={tournament} />
                ))}
              </div>
            </div>
          )}

          {/* Completed Tournaments */}
          {completedTournaments.length > 0 && (
            <div>
              <h2 style={{ fontSize: "24px", fontWeight: 700, marginBottom: "24px", color: "#fff" }}>Past Events</h2>
              <div style={{ display: "grid", gridTemplateColumns: "repeat(1, 1fr)", gap: "24px" }} className="md:grid-cols-2 lg:grid-cols-3">
                {completedTournaments.map((tournament) => (
                  <TournamentCard key={tournament.id} tournament={tournament} />
                ))}
              </div>
            </div>
          )}

          {/* No Results */}
          {filteredTournaments.length === 0 && (
            <div style={{ textAlign: "center", padding: "64px 0" }}>
              <p style={{ color: "#666", fontSize: "18px" }}>
                No tournaments found matching your criteria.
              </p>
              <div style={{ marginTop: "16px" }}>
                <Button
                  variant="outline"
                  onClick={() => {
                    setSearchQuery("");
                    setStatusFilter("ALL");
                    setBuyInFilter("all");
                  }}
                >
                  Clear Filters
                </Button>
              </div>
            </div>
          )}
        </div>
      </section>
    </div>
  );
}

function TournamentCard({ tournament }: { tournament: Tournament }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.3 }}
    >
      <Link href={`/tournaments/${tournament.id}`}>
        <Card hover variant="bordered" className="h-full">
          <div className="relative">
            <CardImage
              src={tournament.imageUrl}
              alt={tournament.name}
              aspectRatio="16/9"
            />
            <div className="absolute top-4 left-4">
              <Badge
                variant={tournament.status === "LIVE" ? "live" : tournament.status === "COMPLETED" ? "default" : "primary"}
              >
                {tournament.status === "LIVE" ? "LIVE NOW" : tournament.status}
              </Badge>
            </div>
            <div className="absolute top-4 right-4">
              <div className="bg-black/70 backdrop-blur-sm rounded-lg px-3 py-1.5">
                <p className="text-xs text-[var(--foreground-secondary)]">Buy-in</p>
                <p className="text-sm font-bold text-[var(--gold)]">
                  {formatCurrency(tournament.buyIn)}
                </p>
              </div>
            </div>
          </div>
          <CardContent className="space-y-4">
            <div>
              <h3 className="text-xl font-bold mb-1">{tournament.name}</h3>
              <p className="text-[var(--foreground-secondary)] text-sm line-clamp-2">
                {tournament.description}
              </p>
            </div>

            <div className="space-y-2">
              <div className="flex items-center gap-2 text-sm text-[var(--foreground-secondary)]">
                <Calendar className="w-4 h-4" />
                <span>{formatDate(tournament.startDate)}</span>
              </div>
              <div className="flex items-center gap-2 text-sm text-[var(--foreground-secondary)]">
                <MapPin className="w-4 h-4" />
                <span>{tournament.venue}</span>
              </div>
            </div>

            <div className="pt-4 border-t border-[var(--border)] flex justify-between items-center">
              <div className="flex items-center gap-2">
                <Trophy className="w-4 h-4 text-[var(--gold)]" />
                <span className="font-semibold text-[var(--gold)]">
                  {formatCurrency(tournament.prizePool)}
                </span>
              </div>
              {tournament.totalEntries > 0 && (
                <div className="flex items-center gap-2 text-sm text-[var(--foreground-secondary)]">
                  <Users className="w-4 h-4" />
                  <span>{tournament.totalEntries} entries</span>
                </div>
              )}
            </div>
          </CardContent>
        </Card>
      </Link>
    </motion.div>
  );
}

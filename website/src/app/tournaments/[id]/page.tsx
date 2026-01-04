"use client";

import { useState, useEffect } from "react";
import { useParams } from "next/navigation";
import Link from "next/link";
import {
  Calendar,
  MapPin,
  Users,
  Trophy,
  Clock,
  DollarSign,
  ChevronLeft,
  Play,
  Pause,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent } from "@/components/ui/card";
import { formatCurrency, formatDate, formatNumber } from "@/lib/utils";
import { Tournament, Standing, BlindLevel } from "@/types";

// Mock tournament data
const tournamentData: Tournament = {
  id: "1",
  name: "Poker Dream 18 Main Event",
  description:
    "The flagship event of the Poker Dream series featuring a guaranteed prize pool of RM 5,000,000. This is the most prestigious poker tournament in Malaysia, attracting players from around the world.",
  startDate: "2025-02-15",
  endDate: "2025-02-20",
  location: "Genting Highlands",
  venue: "Resorts World Genting - Grand Ballroom",
  status: "LIVE",
  prizePool: 5000000,
  buyIn: 3300,
  totalEntries: 1456,
  imageUrl: "https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=1920",
  structure: {
    id: "1",
    levels: [
      { level: 1, smallBlind: 100, bigBlind: 200, ante: 200, duration: 40 },
      { level: 2, smallBlind: 200, bigBlind: 400, ante: 400, duration: 40 },
      { level: 3, smallBlind: 300, bigBlind: 600, ante: 600, duration: 40 },
      { level: 4, smallBlind: 400, bigBlind: 800, ante: 800, duration: 40 },
      { level: 5, smallBlind: 500, bigBlind: 1000, ante: 1000, duration: 40 },
      { level: 6, smallBlind: 600, bigBlind: 1200, ante: 1200, duration: 40 },
      { level: 7, smallBlind: 800, bigBlind: 1600, ante: 1600, duration: 40 },
      { level: 8, smallBlind: 1000, bigBlind: 2000, ante: 2000, duration: 40 },
    ],
    startingChips: 50000,
    lateRegistrationLevel: 12,
  },
};

// Mock standings data
const standingsData: Standing[] = [
  {
    id: "1",
    tournamentId: "1",
    player: { id: "1", name: "Michael Chen", country: "Malaysia", countryCode: "MY" },
    rank: 1,
    chips: 2450000,
    isSurvivor: true,
  },
  {
    id: "2",
    tournamentId: "1",
    player: { id: "2", name: "Sarah Wong", country: "Singapore", countryCode: "SG" },
    rank: 2,
    chips: 1890000,
    isSurvivor: true,
  },
  {
    id: "3",
    tournamentId: "1",
    player: { id: "3", name: "James Liu", country: "Taiwan", countryCode: "TW" },
    rank: 3,
    chips: 1650000,
    isSurvivor: true,
  },
  {
    id: "4",
    tournamentId: "1",
    player: { id: "4", name: "David Park", country: "South Korea", countryCode: "KR" },
    rank: 4,
    chips: 1420000,
    isSurvivor: true,
  },
  {
    id: "5",
    tournamentId: "1",
    player: { id: "5", name: "Lisa Tanaka", country: "Japan", countryCode: "JP" },
    rank: 5,
    chips: 1280000,
    isSurvivor: true,
  },
];

// Mock payout structure
const payoutStructure = [
  { place: "1st", prize: 1250000, percentage: 25 },
  { place: "2nd", prize: 750000, percentage: 15 },
  { place: "3rd", prize: 450000, percentage: 9 },
  { place: "4th", prize: 300000, percentage: 6 },
  { place: "5th", prize: 225000, percentage: 4.5 },
  { place: "6th", prize: 175000, percentage: 3.5 },
  { place: "7th", prize: 125000, percentage: 2.5 },
  { place: "8th", prize: 100000, percentage: 2 },
  { place: "9th-10th", prize: 75000, percentage: 1.5 },
  { place: "11th-15th", prize: 50000, percentage: 1 },
];

export default function TournamentDetailPage() {
  const params = useParams();
  const [activeTab, setActiveTab] = useState<"overview" | "standings" | "structure" | "payouts">("overview");
  const [currentLevel, setCurrentLevel] = useState(5);
  const [timeRemaining, setTimeRemaining] = useState(1847); // seconds
  const [isPaused, setIsPaused] = useState(false);

  // Timer countdown effect
  useEffect(() => {
    if (isPaused || tournamentData.status !== "LIVE") return;

    const timer = setInterval(() => {
      setTimeRemaining((prev) => {
        if (prev <= 0) {
          setCurrentLevel((lvl) => lvl + 1);
          return 40 * 60; // Reset to 40 minutes
        }
        return prev - 1;
      });
    }, 1000);

    return () => clearInterval(timer);
  }, [isPaused]);

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins.toString().padStart(2, "0")}:${secs.toString().padStart(2, "0")}`;
  };

  const currentBlindLevel = tournamentData.structure?.levels[currentLevel - 1];
  const nextBlindLevel = tournamentData.structure?.levels[currentLevel];
  const averageStack = Math.floor(
    (tournamentData.structure?.startingChips || 50000) *
      tournamentData.totalEntries /
      (standingsData.length || 1)
  );

  return (
    <div style={{ paddingTop: "80px" }}>
      {/* Hero Section with Background */}
      <section className="relative py-20 overflow-hidden">
        <div className="absolute inset-0 z-0">
          <div
            className="absolute inset-0 bg-cover bg-center"
            style={{ backgroundImage: `url('${tournamentData.imageUrl}')` }}
          />
          <div className="absolute inset-0 bg-gradient-to-b from-black/80 via-black/60 to-[var(--background)]" />
        </div>

        <div className="container relative z-10">
          <Link
            href="/tournaments"
            className="inline-flex items-center text-[var(--foreground-secondary)] hover:text-white mb-6"
          >
            <ChevronLeft className="w-4 h-4 mr-1" />
            Back to Tournaments
          </Link>

          <div className="flex flex-col lg:flex-row gap-8">
            {/* Tournament Info */}
            <div className="flex-1">
              <Badge
                variant={tournamentData.status === "LIVE" ? "live" : "primary"}
                size="lg"
                className="mb-4"
              >
                {tournamentData.status === "LIVE" ? "LIVE NOW" : tournamentData.status}
              </Badge>
              <h1 className="text-4xl md:text-5xl font-bold mb-4">
                {tournamentData.name}
              </h1>
              <p className="text-lg text-[var(--foreground-secondary)] mb-6 max-w-2xl">
                {tournamentData.description}
              </p>

              <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
                <div className="bg-black/30 backdrop-blur-sm rounded-lg p-4">
                  <Calendar className="w-5 h-5 text-[var(--primary)] mb-2" />
                  <p className="text-sm text-[var(--foreground-secondary)]">Date</p>
                  <p className="font-semibold">{formatDate(tournamentData.startDate)}</p>
                </div>
                <div className="bg-black/30 backdrop-blur-sm rounded-lg p-4">
                  <MapPin className="w-5 h-5 text-[var(--primary)] mb-2" />
                  <p className="text-sm text-[var(--foreground-secondary)]">Venue</p>
                  <p className="font-semibold">{tournamentData.venue}</p>
                </div>
                <div className="bg-black/30 backdrop-blur-sm rounded-lg p-4">
                  <DollarSign className="w-5 h-5 text-[var(--gold)] mb-2" />
                  <p className="text-sm text-[var(--foreground-secondary)]">Buy-in</p>
                  <p className="font-semibold text-[var(--gold)]">
                    {formatCurrency(tournamentData.buyIn)}
                  </p>
                </div>
                <div className="bg-black/30 backdrop-blur-sm rounded-lg p-4">
                  <Trophy className="w-5 h-5 text-[var(--gold)] mb-2" />
                  <p className="text-sm text-[var(--foreground-secondary)]">Prize Pool</p>
                  <p className="font-semibold text-[var(--gold)]">
                    {formatCurrency(tournamentData.prizePool)}
                  </p>
                </div>
              </div>

              <Button size="lg">Register Now</Button>
            </div>

            {/* Live Timer (if tournament is LIVE) */}
            {tournamentData.status === "LIVE" && currentBlindLevel && (
              <div className="lg:w-80">
                <Card className="bg-black/50 backdrop-blur-md border-[var(--primary)]">
                  <CardContent className="p-6 text-center">
                    <p className="text-sm text-[var(--foreground-secondary)] mb-2">
                      Level {currentLevel}
                    </p>
                    <div className="text-5xl font-bold text-[var(--gold)] mb-4">
                      {formatTime(timeRemaining)}
                    </div>
                    <div className="text-2xl font-bold mb-4">
                      {formatNumber(currentBlindLevel.smallBlind)} /{" "}
                      {formatNumber(currentBlindLevel.bigBlind)}
                      <span className="text-lg text-[var(--foreground-secondary)]">
                        {" "}
                        ({formatNumber(currentBlindLevel.ante)})
                      </span>
                    </div>
                    {nextBlindLevel && (
                      <p className="text-sm text-[var(--foreground-secondary)] mb-4">
                        Next: {formatNumber(nextBlindLevel.smallBlind)} /{" "}
                        {formatNumber(nextBlindLevel.bigBlind)}
                      </p>
                    )}
                    <div className="grid grid-cols-2 gap-4 text-sm">
                      <div>
                        <p className="text-[var(--foreground-muted)]">Players</p>
                        <p className="font-bold">{standingsData.length}</p>
                      </div>
                      <div>
                        <p className="text-[var(--foreground-muted)]">Avg Stack</p>
                        <p className="font-bold">{formatNumber(averageStack)}</p>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              </div>
            )}
          </div>
        </div>
      </section>

      {/* Tabs Section */}
      <section className="py-8 border-b border-[var(--border)] sticky top-20 bg-[var(--background)] z-30">
        <div className="container">
          <div className="flex gap-2 overflow-x-auto">
            {(["overview", "standings", "structure", "payouts"] as const).map((tab) => (
              <Button
                key={tab}
                variant={activeTab === tab ? "primary" : "ghost"}
                onClick={() => setActiveTab(tab)}
                className="capitalize"
              >
                {tab}
              </Button>
            ))}
          </div>
        </div>
      </section>

      {/* Tab Content */}
      <section className="py-12">
        <div className="container">
          {activeTab === "overview" && (
            <div className="grid lg:grid-cols-3 gap-8">
              <div className="lg:col-span-2 space-y-8">
                <div>
                  <h2 className="text-2xl font-bold mb-4">About This Tournament</h2>
                  <p className="text-[var(--foreground-secondary)]">
                    {tournamentData.description}
                  </p>
                </div>
                <div>
                  <h3 className="text-xl font-bold mb-4">Tournament Details</h3>
                  <div className="grid md:grid-cols-2 gap-4">
                    <div className="bg-[var(--surface)] rounded-lg p-4">
                      <p className="text-[var(--foreground-muted)] text-sm">Starting Chips</p>
                      <p className="text-xl font-bold">
                        {formatNumber(tournamentData.structure?.startingChips || 50000)}
                      </p>
                    </div>
                    <div className="bg-[var(--surface)] rounded-lg p-4">
                      <p className="text-[var(--foreground-muted)] text-sm">Level Duration</p>
                      <p className="text-xl font-bold">40 minutes</p>
                    </div>
                    <div className="bg-[var(--surface)] rounded-lg p-4">
                      <p className="text-[var(--foreground-muted)] text-sm">Late Registration</p>
                      <p className="text-xl font-bold">
                        Until Level {tournamentData.structure?.lateRegistrationLevel}
                      </p>
                    </div>
                    <div className="bg-[var(--surface)] rounded-lg p-4">
                      <p className="text-[var(--foreground-muted)] text-sm">Total Entries</p>
                      <p className="text-xl font-bold">{formatNumber(tournamentData.totalEntries)}</p>
                    </div>
                  </div>
                </div>
              </div>
              <div>
                <h3 className="text-xl font-bold mb-4">Quick Info</h3>
                <div className="bg-[var(--surface)] rounded-xl p-6 space-y-4">
                  <div className="flex justify-between">
                    <span className="text-[var(--foreground-secondary)]">Event</span>
                    <span className="font-medium">{tournamentData.name}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-[var(--foreground-secondary)]">Dates</span>
                    <span className="font-medium">
                      {formatDate(tournamentData.startDate)} - {formatDate(tournamentData.endDate)}
                    </span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-[var(--foreground-secondary)]">Venue</span>
                    <span className="font-medium">{tournamentData.venue}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-[var(--foreground-secondary)]">Buy-in</span>
                    <span className="font-medium text-[var(--gold)]">
                      {formatCurrency(tournamentData.buyIn)}
                    </span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-[var(--foreground-secondary)]">Guarantee</span>
                    <span className="font-medium text-[var(--gold)]">
                      {formatCurrency(tournamentData.prizePool)}
                    </span>
                  </div>
                </div>
              </div>
            </div>
          )}

          {activeTab === "standings" && (
            <div>
              <h2 className="text-2xl font-bold mb-6">Current Standings</h2>
              <div className="bg-[var(--surface)] rounded-xl overflow-hidden">
                <table className="w-full">
                  <thead className="bg-[var(--background-secondary)]">
                    <tr>
                      <th className="px-6 py-4 text-left text-sm font-semibold">Rank</th>
                      <th className="px-6 py-4 text-left text-sm font-semibold">Player</th>
                      <th className="px-6 py-4 text-left text-sm font-semibold">Country</th>
                      <th className="px-6 py-4 text-right text-sm font-semibold">Chips</th>
                    </tr>
                  </thead>
                  <tbody>
                    {standingsData.map((standing) => (
                      <tr
                        key={standing.id}
                        className="border-t border-[var(--border)] hover:bg-[var(--surface-hover)]"
                      >
                        <td className="px-6 py-4">
                          <span
                            className={`font-bold ${
                              standing.rank === 1
                                ? "text-[var(--gold)]"
                                : standing.rank === 2
                                ? "text-gray-400"
                                : standing.rank === 3
                                ? "text-amber-600"
                                : ""
                            }`}
                          >
                            #{standing.rank}
                          </span>
                        </td>
                        <td className="px-6 py-4 font-medium">{standing.player.name}</td>
                        <td className="px-6 py-4">
                          <div className="flex items-center gap-2">
                            <img
                              src={`https://flagcdn.com/24x18/${standing.player.countryCode.toLowerCase()}.png`}
                              alt={standing.player.country}
                              className="w-6 h-4 object-cover rounded"
                            />
                            <span className="text-[var(--foreground-secondary)]">
                              {standing.player.country}
                            </span>
                          </div>
                        </td>
                        <td className="px-6 py-4 text-right font-bold">
                          {formatNumber(standing.chips)}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}

          {activeTab === "structure" && (
            <div>
              <h2 className="text-2xl font-bold mb-6">Blind Structure</h2>
              <div className="bg-[var(--surface)] rounded-xl overflow-hidden">
                <table className="w-full">
                  <thead className="bg-[var(--background-secondary)]">
                    <tr>
                      <th className="px-6 py-4 text-left text-sm font-semibold">Level</th>
                      <th className="px-6 py-4 text-left text-sm font-semibold">Small Blind</th>
                      <th className="px-6 py-4 text-left text-sm font-semibold">Big Blind</th>
                      <th className="px-6 py-4 text-left text-sm font-semibold">Ante</th>
                      <th className="px-6 py-4 text-right text-sm font-semibold">Duration</th>
                    </tr>
                  </thead>
                  <tbody>
                    {tournamentData.structure?.levels.map((level) => (
                      <tr
                        key={level.level}
                        className={`border-t border-[var(--border)] ${
                          level.level === currentLevel
                            ? "bg-[var(--primary)]/10"
                            : "hover:bg-[var(--surface-hover)]"
                        }`}
                      >
                        <td className="px-6 py-4">
                          <span className="font-bold">
                            {level.level === currentLevel && (
                              <span className="text-[var(--primary)] mr-2">▶</span>
                            )}
                            Level {level.level}
                          </span>
                        </td>
                        <td className="px-6 py-4">{formatNumber(level.smallBlind)}</td>
                        <td className="px-6 py-4">{formatNumber(level.bigBlind)}</td>
                        <td className="px-6 py-4">{formatNumber(level.ante)}</td>
                        <td className="px-6 py-4 text-right">{level.duration} min</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}

          {activeTab === "payouts" && (
            <div>
              <h2 className="text-2xl font-bold mb-6">Payout Structure</h2>
              <div className="grid lg:grid-cols-2 gap-8">
                <div className="bg-[var(--surface)] rounded-xl overflow-hidden">
                  <table className="w-full">
                    <thead className="bg-[var(--background-secondary)]">
                      <tr>
                        <th className="px-6 py-4 text-left text-sm font-semibold">Place</th>
                        <th className="px-6 py-4 text-right text-sm font-semibold">Prize</th>
                        <th className="px-6 py-4 text-right text-sm font-semibold">%</th>
                      </tr>
                    </thead>
                    <tbody>
                      {payoutStructure.map((payout) => (
                        <tr
                          key={payout.place}
                          className="border-t border-[var(--border)] hover:bg-[var(--surface-hover)]"
                        >
                          <td className="px-6 py-4 font-medium">{payout.place}</td>
                          <td className="px-6 py-4 text-right font-bold text-[var(--gold)]">
                            {formatCurrency(payout.prize)}
                          </td>
                          <td className="px-6 py-4 text-right text-[var(--foreground-secondary)]">
                            {payout.percentage}%
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
                <div>
                  <div className="bg-[var(--surface)] rounded-xl p-6">
                    <h3 className="text-xl font-bold mb-4">Prize Pool Summary</h3>
                    <div className="space-y-4">
                      <div className="flex justify-between">
                        <span className="text-[var(--foreground-secondary)]">Total Prize Pool</span>
                        <span className="font-bold text-[var(--gold)]">
                          {formatCurrency(tournamentData.prizePool)}
                        </span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-[var(--foreground-secondary)]">Total Entries</span>
                        <span className="font-bold">{formatNumber(tournamentData.totalEntries)}</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-[var(--foreground-secondary)]">Places Paid</span>
                        <span className="font-bold">150 (15%)</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-[var(--foreground-secondary)]">1st Place</span>
                        <span className="font-bold text-[var(--gold)]">{formatCurrency(1250000)}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          )}
        </div>
      </section>
    </div>
  );
}

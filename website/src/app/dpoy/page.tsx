import { Metadata } from "next";
import {
  Trophy,
  Medal,
  TrendingUp,
  Calendar,
  ChevronLeft,
  ChevronRight,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { formatNumber } from "@/lib/utils";
import { DPOYEntry } from "@/types";

export const metadata: Metadata = {
  title: "DPOY Leaderboard",
  description:
    "Poker Dream Player of the Year rankings. See who's leading the race for the coveted DPOY title.",
};

// Mock DPOY data
const dpoyLeaderboard: DPOYEntry[] = [
  {
    rank: 1,
    player: {
      id: "1",
      name: "Michael Chen",
      country: "Malaysia",
      countryCode: "MY",
      profileImage: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200",
    },
    points: 4850,
    eventsPlayed: 28,
    bestFinish: 1,
  },
  {
    rank: 2,
    player: {
      id: "2",
      name: "Sarah Wong",
      country: "Singapore",
      countryCode: "SG",
      profileImage: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200",
    },
    points: 4320,
    eventsPlayed: 32,
    bestFinish: 1,
  },
  {
    rank: 3,
    player: {
      id: "3",
      name: "James Liu",
      country: "Taiwan",
      countryCode: "TW",
      profileImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200",
    },
    points: 3980,
    eventsPlayed: 25,
    bestFinish: 1,
  },
  {
    rank: 4,
    player: {
      id: "4",
      name: "David Park",
      country: "South Korea",
      countryCode: "KR",
      profileImage: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200",
    },
    points: 3650,
    eventsPlayed: 30,
    bestFinish: 2,
  },
  {
    rank: 5,
    player: {
      id: "5",
      name: "Lisa Tanaka",
      country: "Japan",
      countryCode: "JP",
      profileImage: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200",
    },
    points: 3420,
    eventsPlayed: 22,
    bestFinish: 1,
  },
];

// Generate more entries for pagination demo
const additionalEntries: DPOYEntry[] = Array.from({ length: 45 }, (_, i) => ({
  rank: i + 6,
  player: {
    id: `${i + 6}`,
    name: `Player ${i + 6}`,
    country: ["Malaysia", "Singapore", "China", "Japan", "Korea"][i % 5],
    countryCode: ["MY", "SG", "CN", "JP", "KR"][i % 5],
  },
  points: Math.floor(3000 - i * 50),
  eventsPlayed: Math.floor(Math.random() * 20) + 10,
  bestFinish: Math.floor(Math.random() * 10) + 1,
}));

const allEntries = [...dpoyLeaderboard, ...additionalEntries];

export default function DPOYPage() {
  const topThree = dpoyLeaderboard.slice(0, 3);
  const currentYear = new Date().getFullYear();

  return (
    <div className="pt-20">
      {/* Hero Section */}
      <section className="relative py-20 overflow-hidden">
        <div className="absolute inset-0 z-0">
          <div
            className="absolute inset-0 bg-cover bg-center"
            style={{
              backgroundImage:
                "url('https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=1920')",
            }}
          />
          <div className="absolute inset-0 bg-gradient-to-b from-black/80 via-black/60 to-[var(--background)]" />
        </div>

        <div className="container relative z-10">
          <div className="text-center max-w-3xl mx-auto mb-12">
            <span className="inline-block px-4 py-2 mb-6 text-sm font-semibold text-[var(--gold)] bg-[var(--gold)]/10 rounded-full border border-[var(--gold)]/30">
              {currentYear} Season
            </span>
            <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold mb-4">
              Dream Player of the Year
            </h1>
            <p className="text-xl text-[var(--foreground-secondary)]">
              The race for poker glory. Track the top players competing for the
              prestigious DPOY title.
            </p>
          </div>

          {/* Top 3 Podium */}
          <div className="flex flex-col md:flex-row items-end justify-center gap-4 max-w-4xl mx-auto">
            {/* 2nd Place */}
            <div className="order-2 md:order-1 w-full md:w-1/3">
              <Card className="bg-gradient-to-b from-gray-600/20 to-gray-800/20 border-gray-500/30 text-center">
                <CardContent className="pt-6 pb-8">
                  <div className="relative inline-block mb-4">
                    <img
                      src={topThree[1]?.player.profileImage}
                      alt={topThree[1]?.player.name}
                      className="w-20 h-20 rounded-full object-cover mx-auto border-4 border-gray-400"
                    />
                    <div className="absolute -bottom-2 left-1/2 -translate-x-1/2 w-8 h-8 bg-gray-400 rounded-full flex items-center justify-center text-black font-bold">
                      2
                    </div>
                  </div>
                  <h3 className="font-bold text-lg mb-1">{topThree[1]?.player.name}</h3>
                  <div className="flex items-center justify-center gap-1 mb-3">
                    <img
                      src={`https://flagcdn.com/24x18/${topThree[1]?.player.countryCode.toLowerCase()}.png`}
                      alt=""
                      className="w-5 h-3.5"
                    />
                    <span className="text-sm text-[var(--foreground-secondary)]">
                      {topThree[1]?.player.country}
                    </span>
                  </div>
                  <p className="text-2xl font-bold text-gray-300">
                    {formatNumber(topThree[1]?.points || 0)} pts
                  </p>
                </CardContent>
              </Card>
            </div>

            {/* 1st Place */}
            <div className="order-1 md:order-2 w-full md:w-1/3">
              <Card className="bg-gradient-to-b from-[var(--gold)]/20 to-amber-900/20 border-[var(--gold)]/30 text-center transform md:scale-110">
                <CardContent className="pt-8 pb-10">
                  <Trophy className="w-12 h-12 text-[var(--gold)] mx-auto mb-4" />
                  <div className="relative inline-block mb-4">
                    <img
                      src={topThree[0]?.player.profileImage}
                      alt={topThree[0]?.player.name}
                      className="w-24 h-24 rounded-full object-cover mx-auto border-4 border-[var(--gold)]"
                    />
                    <div className="absolute -bottom-2 left-1/2 -translate-x-1/2 w-10 h-10 bg-[var(--gold)] rounded-full flex items-center justify-center text-black font-bold text-lg">
                      1
                    </div>
                  </div>
                  <h3 className="font-bold text-xl mb-1">{topThree[0]?.player.name}</h3>
                  <div className="flex items-center justify-center gap-1 mb-3">
                    <img
                      src={`https://flagcdn.com/24x18/${topThree[0]?.player.countryCode.toLowerCase()}.png`}
                      alt=""
                      className="w-5 h-3.5"
                    />
                    <span className="text-sm text-[var(--foreground-secondary)]">
                      {topThree[0]?.player.country}
                    </span>
                  </div>
                  <p className="text-3xl font-bold text-[var(--gold)]">
                    {formatNumber(topThree[0]?.points || 0)} pts
                  </p>
                </CardContent>
              </Card>
            </div>

            {/* 3rd Place */}
            <div className="order-3 w-full md:w-1/3">
              <Card className="bg-gradient-to-b from-amber-700/20 to-amber-900/20 border-amber-600/30 text-center">
                <CardContent className="pt-6 pb-8">
                  <div className="relative inline-block mb-4">
                    <img
                      src={topThree[2]?.player.profileImage}
                      alt={topThree[2]?.player.name}
                      className="w-20 h-20 rounded-full object-cover mx-auto border-4 border-amber-600"
                    />
                    <div className="absolute -bottom-2 left-1/2 -translate-x-1/2 w-8 h-8 bg-amber-600 rounded-full flex items-center justify-center text-black font-bold">
                      3
                    </div>
                  </div>
                  <h3 className="font-bold text-lg mb-1">{topThree[2]?.player.name}</h3>
                  <div className="flex items-center justify-center gap-1 mb-3">
                    <img
                      src={`https://flagcdn.com/24x18/${topThree[2]?.player.countryCode.toLowerCase()}.png`}
                      alt=""
                      className="w-5 h-3.5"
                    />
                    <span className="text-sm text-[var(--foreground-secondary)]">
                      {topThree[2]?.player.country}
                    </span>
                  </div>
                  <p className="text-2xl font-bold text-amber-500">
                    {formatNumber(topThree[2]?.points || 0)} pts
                  </p>
                </CardContent>
              </Card>
            </div>
          </div>
        </div>
      </section>

      {/* How Points Work */}
      <section className="py-16 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="text-center mb-12">
            <h2 className="text-2xl font-bold">How DPOY Points Work</h2>
          </div>
          <div className="grid md:grid-cols-3 gap-6 max-w-4xl mx-auto">
            <div className="bg-[var(--surface)] rounded-xl p-6 text-center">
              <Trophy className="w-10 h-10 text-[var(--gold)] mx-auto mb-4" />
              <h3 className="font-bold mb-2">Tournament Finishes</h3>
              <p className="text-sm text-[var(--foreground-secondary)]">
                Earn points based on your final position in Poker Dream events.
                Higher finishes = more points.
              </p>
            </div>
            <div className="bg-[var(--surface)] rounded-xl p-6 text-center">
              <Medal className="w-10 h-10 text-[var(--gold)] mx-auto mb-4" />
              <h3 className="font-bold mb-2">Event Multipliers</h3>
              <p className="text-sm text-[var(--foreground-secondary)]">
                Main Events and High Rollers offer bonus multipliers on points
                earned.
              </p>
            </div>
            <div className="bg-[var(--surface)] rounded-xl p-6 text-center">
              <TrendingUp className="w-10 h-10 text-[var(--gold)] mx-auto mb-4" />
              <h3 className="font-bold mb-2">Consistency Bonus</h3>
              <p className="text-sm text-[var(--foreground-secondary)]">
                Play more events throughout the season to earn consistency bonus
                points.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Full Leaderboard */}
      <section className="py-16">
        <div className="container">
          <div className="flex justify-between items-center mb-8">
            <h2 className="text-2xl font-bold">Full Leaderboard</h2>
            <div className="flex items-center gap-2">
              <Calendar className="w-5 h-5 text-[var(--foreground-muted)]" />
              <span className="text-[var(--foreground-secondary)]">{currentYear} Season</span>
            </div>
          </div>

          <div className="bg-[var(--surface)] rounded-xl overflow-hidden">
            <table className="w-full">
              <thead className="bg-[var(--background-secondary)]">
                <tr>
                  <th className="px-6 py-4 text-left text-sm font-semibold">Rank</th>
                  <th className="px-6 py-4 text-left text-sm font-semibold">Player</th>
                  <th className="px-6 py-4 text-center text-sm font-semibold">Events</th>
                  <th className="px-6 py-4 text-center text-sm font-semibold">Best Finish</th>
                  <th className="px-6 py-4 text-right text-sm font-semibold">Points</th>
                </tr>
              </thead>
              <tbody>
                {allEntries.slice(0, 50).map((entry) => (
                  <tr
                    key={entry.rank}
                    className="border-t border-[var(--border)] hover:bg-[var(--surface-hover)]"
                  >
                    <td className="px-6 py-4">
                      <span
                        className={`font-bold ${
                          entry.rank === 1
                            ? "text-[var(--gold)]"
                            : entry.rank === 2
                            ? "text-gray-400"
                            : entry.rank === 3
                            ? "text-amber-600"
                            : ""
                        }`}
                      >
                        #{entry.rank}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <div className="w-10 h-10 rounded-full bg-[var(--background)] flex items-center justify-center overflow-hidden">
                          {entry.player.profileImage ? (
                            <img
                              src={entry.player.profileImage}
                              alt={entry.player.name}
                              className="w-full h-full object-cover"
                            />
                          ) : (
                            <span className="text-sm font-bold">
                              {entry.player.name.charAt(0)}
                            </span>
                          )}
                        </div>
                        <div>
                          <p className="font-medium">{entry.player.name}</p>
                          <div className="flex items-center gap-1">
                            <img
                              src={`https://flagcdn.com/16x12/${entry.player.countryCode.toLowerCase()}.png`}
                              alt=""
                              className="w-4 h-3"
                            />
                            <span className="text-xs text-[var(--foreground-muted)]">
                              {entry.player.country}
                            </span>
                          </div>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-center">{entry.eventsPlayed}</td>
                    <td className="px-6 py-4 text-center">
                      {entry.bestFinish === 1 ? (
                        <Badge variant="gold" size="sm">
                          1st
                        </Badge>
                      ) : (
                        <span>{entry.bestFinish}th</span>
                      )}
                    </td>
                    <td className="px-6 py-4 text-right font-bold">
                      {formatNumber(entry.points)}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* Pagination */}
          <div className="flex justify-center items-center gap-4 mt-8">
            <Button variant="outline" size="sm" disabled>
              <ChevronLeft className="w-4 h-4 mr-1" />
              Previous
            </Button>
            <span className="text-[var(--foreground-secondary)]">Page 1 of 1</span>
            <Button variant="outline" size="sm" disabled>
              Next
              <ChevronRight className="w-4 h-4 ml-1" />
            </Button>
          </div>
        </div>
      </section>
    </div>
  );
}

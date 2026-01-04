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
    <div style={{ paddingTop: "80px" }}>
      {/* Hero Section */}
      <section style={{ position: "relative", padding: "80px 0", overflow: "hidden" }}>
        <div style={{ position: "absolute", inset: 0, zIndex: 0 }}>
          <div
            style={{
              position: "absolute",
              inset: 0,
              backgroundImage: "url('https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=1920')",
              backgroundSize: "cover",
              backgroundPosition: "center",
            }}
          />
          <div style={{ position: "absolute", inset: 0, background: "linear-gradient(to bottom, rgba(0,0,0,0.8), rgba(0,0,0,0.6), #0A0A0A)" }} />
        </div>

        <div className="container" style={{ position: "relative", zIndex: 10 }}>
          <div style={{ textAlign: "center", maxWidth: "768px", margin: "0 auto 48px" }}>
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
              {currentYear} Season
            </span>
            <h1 style={{ fontSize: "clamp(32px, 5vw, 56px)", fontWeight: 700, marginBottom: "16px", color: "#fff" }}>
              Dream Player of the Year
            </h1>
            <p style={{ fontSize: "20px", color: "#888", lineHeight: 1.6 }}>
              The race for poker glory. Track the top players competing for the
              prestigious DPOY title.
            </p>
          </div>

          {/* Top 3 Podium */}
          <div style={{ display: "flex", flexDirection: "column", alignItems: "flex-end", justifyContent: "center", gap: "16px", maxWidth: "896px", margin: "0 auto" }} className="md:flex-row">
            {/* 2nd Place */}
            <div style={{ order: 2, width: "100%" }} className="md:order-1 md:w-1/3">
              <Card style={{ background: "linear-gradient(to bottom, rgba(75, 85, 99, 0.2), rgba(31, 41, 55, 0.2))", border: "1px solid rgba(107, 114, 128, 0.3)", textAlign: "center" }}>
                <CardContent style={{ paddingTop: "24px", paddingBottom: "32px" }}>
                  <div style={{ position: "relative", display: "inline-block", marginBottom: "16px" }}>
                    <img
                      src={topThree[1]?.player.profileImage}
                      alt={topThree[1]?.player.name}
                      style={{ width: "80px", height: "80px", borderRadius: "50%", objectFit: "cover", margin: "0 auto", border: "4px solid #9CA3AF", display: "block" }}
                    />
                    <div style={{ position: "absolute", bottom: "-8px", left: "50%", transform: "translateX(-50%)", width: "32px", height: "32px", background: "#9CA3AF", borderRadius: "50%", display: "flex", alignItems: "center", justifyContent: "center", color: "#000", fontWeight: 700 }}>
                      2
                    </div>
                  </div>
                  <h3 style={{ fontWeight: 700, fontSize: "18px", marginBottom: "4px", color: "#fff" }}>{topThree[1]?.player.name}</h3>
                  <div style={{ display: "flex", alignItems: "center", justifyContent: "center", gap: "4px", marginBottom: "12px" }}>
                    <img
                      src={`https://flagcdn.com/24x18/${topThree[1]?.player.countryCode.toLowerCase()}.png`}
                      alt=""
                      style={{ width: "20px", height: "14px" }}
                    />
                    <span style={{ fontSize: "14px", color: "#888" }}>
                      {topThree[1]?.player.country}
                    </span>
                  </div>
                  <p style={{ fontSize: "24px", fontWeight: 700, color: "#D1D5DB" }}>
                    {formatNumber(topThree[1]?.points || 0)} pts
                  </p>
                </CardContent>
              </Card>
            </div>

            {/* 1st Place */}
            <div style={{ order: 1, width: "100%" }} className="md:order-2 md:w-1/3 md:scale-110">
              <Card style={{ background: "linear-gradient(to bottom, rgba(255, 215, 0, 0.2), rgba(180, 83, 9, 0.2))", border: "1px solid rgba(255, 215, 0, 0.3)", textAlign: "center" }}>
                <CardContent style={{ paddingTop: "32px", paddingBottom: "40px" }}>
                  <Trophy style={{ width: "48px", height: "48px", color: "#FFD700", margin: "0 auto 16px" }} />
                  <div style={{ position: "relative", display: "inline-block", marginBottom: "16px" }}>
                    <img
                      src={topThree[0]?.player.profileImage}
                      alt={topThree[0]?.player.name}
                      style={{ width: "96px", height: "96px", borderRadius: "50%", objectFit: "cover", margin: "0 auto", border: "4px solid #FFD700", display: "block" }}
                    />
                    <div style={{ position: "absolute", bottom: "-8px", left: "50%", transform: "translateX(-50%)", width: "40px", height: "40px", background: "#FFD700", borderRadius: "50%", display: "flex", alignItems: "center", justifyContent: "center", color: "#000", fontWeight: 700, fontSize: "18px" }}>
                      1
                    </div>
                  </div>
                  <h3 style={{ fontWeight: 700, fontSize: "20px", marginBottom: "4px", color: "#fff" }}>{topThree[0]?.player.name}</h3>
                  <div style={{ display: "flex", alignItems: "center", justifyContent: "center", gap: "4px", marginBottom: "12px" }}>
                    <img
                      src={`https://flagcdn.com/24x18/${topThree[0]?.player.countryCode.toLowerCase()}.png`}
                      alt=""
                      style={{ width: "20px", height: "14px" }}
                    />
                    <span style={{ fontSize: "14px", color: "#888" }}>
                      {topThree[0]?.player.country}
                    </span>
                  </div>
                  <p style={{ fontSize: "30px", fontWeight: 700, color: "#FFD700" }}>
                    {formatNumber(topThree[0]?.points || 0)} pts
                  </p>
                </CardContent>
              </Card>
            </div>

            {/* 3rd Place */}
            <div style={{ order: 3, width: "100%" }} className="md:w-1/3">
              <Card style={{ background: "linear-gradient(to bottom, rgba(180, 83, 9, 0.2), rgba(120, 53, 15, 0.2))", border: "1px solid rgba(217, 119, 6, 0.3)", textAlign: "center" }}>
                <CardContent style={{ paddingTop: "24px", paddingBottom: "32px" }}>
                  <div style={{ position: "relative", display: "inline-block", marginBottom: "16px" }}>
                    <img
                      src={topThree[2]?.player.profileImage}
                      alt={topThree[2]?.player.name}
                      style={{ width: "80px", height: "80px", borderRadius: "50%", objectFit: "cover", margin: "0 auto", border: "4px solid #D97706", display: "block" }}
                    />
                    <div style={{ position: "absolute", bottom: "-8px", left: "50%", transform: "translateX(-50%)", width: "32px", height: "32px", background: "#D97706", borderRadius: "50%", display: "flex", alignItems: "center", justifyContent: "center", color: "#000", fontWeight: 700 }}>
                      3
                    </div>
                  </div>
                  <h3 style={{ fontWeight: 700, fontSize: "18px", marginBottom: "4px", color: "#fff" }}>{topThree[2]?.player.name}</h3>
                  <div style={{ display: "flex", alignItems: "center", justifyContent: "center", gap: "4px", marginBottom: "12px" }}>
                    <img
                      src={`https://flagcdn.com/24x18/${topThree[2]?.player.countryCode.toLowerCase()}.png`}
                      alt=""
                      style={{ width: "20px", height: "14px" }}
                    />
                    <span style={{ fontSize: "14px", color: "#888" }}>
                      {topThree[2]?.player.country}
                    </span>
                  </div>
                  <p style={{ fontSize: "24px", fontWeight: 700, color: "#F59E0B" }}>
                    {formatNumber(topThree[2]?.points || 0)} pts
                  </p>
                </CardContent>
              </Card>
            </div>
          </div>
        </div>
      </section>

      {/* How Points Work */}
      <section style={{ padding: "64px 0", background: "#121212" }}>
        <div className="container">
          <div style={{ textAlign: "center", marginBottom: "48px" }}>
            <h2 style={{ fontSize: "24px", fontWeight: 700, color: "#fff" }}>How DPOY Points Work</h2>
          </div>
          <div style={{ display: "grid", gridTemplateColumns: "repeat(1, 1fr)", gap: "24px", maxWidth: "896px", margin: "0 auto" }} className="md:grid-cols-3">
            <div style={{ background: "#1E1E1E", borderRadius: "12px", padding: "24px", textAlign: "center" }}>
              <Trophy style={{ width: "40px", height: "40px", color: "#FFD700", margin: "0 auto 16px" }} />
              <h3 style={{ fontWeight: 700, marginBottom: "8px", color: "#fff" }}>Tournament Finishes</h3>
              <p style={{ fontSize: "14px", color: "#888" }}>
                Earn points based on your final position in Poker Dream events.
                Higher finishes = more points.
              </p>
            </div>
            <div style={{ background: "#1E1E1E", borderRadius: "12px", padding: "24px", textAlign: "center" }}>
              <Medal style={{ width: "40px", height: "40px", color: "#FFD700", margin: "0 auto 16px" }} />
              <h3 style={{ fontWeight: 700, marginBottom: "8px", color: "#fff" }}>Event Multipliers</h3>
              <p style={{ fontSize: "14px", color: "#888" }}>
                Main Events and High Rollers offer bonus multipliers on points
                earned.
              </p>
            </div>
            <div style={{ background: "#1E1E1E", borderRadius: "12px", padding: "24px", textAlign: "center" }}>
              <TrendingUp style={{ width: "40px", height: "40px", color: "#FFD700", margin: "0 auto 16px" }} />
              <h3 style={{ fontWeight: 700, marginBottom: "8px", color: "#fff" }}>Consistency Bonus</h3>
              <p style={{ fontSize: "14px", color: "#888" }}>
                Play more events throughout the season to earn consistency bonus
                points.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Full Leaderboard */}
      <section style={{ padding: "64px 0" }}>
        <div className="container">
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: "32px" }}>
            <h2 style={{ fontSize: "24px", fontWeight: 700, color: "#fff" }}>Full Leaderboard</h2>
            <div style={{ display: "flex", alignItems: "center", gap: "8px" }}>
              <Calendar style={{ width: "20px", height: "20px", color: "#666" }} />
              <span style={{ color: "#888" }}>{currentYear} Season</span>
            </div>
          </div>

          <div style={{ background: "#1E1E1E", borderRadius: "12px", overflow: "hidden" }}>
            <table style={{ width: "100%", borderCollapse: "collapse" }}>
              <thead style={{ background: "#121212" }}>
                <tr>
                  <th style={{ padding: "16px 24px", textAlign: "left", fontSize: "14px", fontWeight: 600, color: "#fff" }}>Rank</th>
                  <th style={{ padding: "16px 24px", textAlign: "left", fontSize: "14px", fontWeight: 600, color: "#fff" }}>Player</th>
                  <th style={{ padding: "16px 24px", textAlign: "center", fontSize: "14px", fontWeight: 600, color: "#fff" }}>Events</th>
                  <th style={{ padding: "16px 24px", textAlign: "center", fontSize: "14px", fontWeight: 600, color: "#fff" }}>Best Finish</th>
                  <th style={{ padding: "16px 24px", textAlign: "right", fontSize: "14px", fontWeight: 600, color: "#fff" }}>Points</th>
                </tr>
              </thead>
              <tbody>
                {allEntries.slice(0, 50).map((entry) => (
                  <tr
                    key={entry.rank}
                    style={{ borderTop: "1px solid #333" }}
                  >
                    <td style={{ padding: "16px 24px" }}>
                      <span
                        style={{
                          fontWeight: 700,
                          color: entry.rank === 1 ? "#FFD700" : entry.rank === 2 ? "#9CA3AF" : entry.rank === 3 ? "#D97706" : "#fff"
                        }}
                      >
                        #{entry.rank}
                      </span>
                    </td>
                    <td style={{ padding: "16px 24px" }}>
                      <div style={{ display: "flex", alignItems: "center", gap: "12px" }}>
                        <div style={{ width: "40px", height: "40px", borderRadius: "50%", background: "#0A0A0A", display: "flex", alignItems: "center", justifyContent: "center", overflow: "hidden" }}>
                          {entry.player.profileImage ? (
                            <img
                              src={entry.player.profileImage}
                              alt={entry.player.name}
                              style={{ width: "100%", height: "100%", objectFit: "cover" }}
                            />
                          ) : (
                            <span style={{ fontSize: "14px", fontWeight: 700, color: "#fff" }}>
                              {entry.player.name.charAt(0)}
                            </span>
                          )}
                        </div>
                        <div>
                          <p style={{ fontWeight: 500, color: "#fff" }}>{entry.player.name}</p>
                          <div style={{ display: "flex", alignItems: "center", gap: "4px" }}>
                            <img
                              src={`https://flagcdn.com/16x12/${entry.player.countryCode.toLowerCase()}.png`}
                              alt=""
                              style={{ width: "16px", height: "12px" }}
                            />
                            <span style={{ fontSize: "12px", color: "#666" }}>
                              {entry.player.country}
                            </span>
                          </div>
                        </div>
                      </div>
                    </td>
                    <td style={{ padding: "16px 24px", textAlign: "center", color: "#fff" }}>{entry.eventsPlayed}</td>
                    <td style={{ padding: "16px 24px", textAlign: "center", color: "#fff" }}>
                      {entry.bestFinish === 1 ? (
                        <Badge variant="gold" size="sm">
                          1st
                        </Badge>
                      ) : (
                        <span>{entry.bestFinish}th</span>
                      )}
                    </td>
                    <td style={{ padding: "16px 24px", textAlign: "right", fontWeight: 700, color: "#fff" }}>
                      {formatNumber(entry.points)}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* Pagination */}
          <div style={{ display: "flex", justifyContent: "center", alignItems: "center", gap: "16px", marginTop: "32px" }}>
            <Button variant="outline" size="sm" disabled>
              <ChevronLeft style={{ width: "16px", height: "16px", marginRight: "4px" }} />
              Previous
            </Button>
            <span style={{ color: "#888" }}>Page 1 of 1</span>
            <Button variant="outline" size="sm" disabled>
              Next
              <ChevronRight style={{ width: "16px", height: "16px", marginLeft: "4px" }} />
            </Button>
          </div>
        </div>
      </section>
    </div>
  );
}

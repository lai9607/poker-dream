import { Metadata } from "next";
import Link from "next/link";
import { Calendar, Users, Clock, ChevronRight } from "lucide-react";
import { Card, CardContent, CardImage } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { formatDate } from "@/lib/utils";

export const metadata: Metadata = {
  title: "Live Reports",
  description: "Follow live updates and reports from ongoing Poker Dream tournaments.",
};

// Mock live report data
const liveReports = [
  {
    id: "1",
    tournamentId: "1",
    tournamentName: "Poker Dream 18 Main Event",
    status: "LIVE",
    currentLevel: 15,
    playersRemaining: 156,
    totalEntries: 1456,
    lastUpdate: "2025-02-18T14:30:00Z",
    imageUrl: "https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=800",
  },
  {
    id: "2",
    tournamentId: "2",
    tournamentName: "High Roller Championship",
    status: "LIVE",
    currentLevel: 8,
    playersRemaining: 42,
    totalEntries: 85,
    lastUpdate: "2025-02-18T14:25:00Z",
    imageUrl: "https://images.unsplash.com/photo-1606167668584-78701c57f13d?w=800",
  },
];

const pastReports = [
  {
    id: "3",
    tournamentId: "3",
    tournamentName: "Poker Dream 17 Main Event",
    status: "COMPLETED",
    winner: "Michael Chen",
    winnerCountry: "MY",
    prize: 1250000,
    totalEntries: 1250,
    date: "2024-12-15",
    imageUrl: "https://images.unsplash.com/photo-1511193311914-0346f16efe90?w=800",
  },
  {
    id: "4",
    tournamentId: "4",
    tournamentName: "PD17 High Roller",
    status: "COMPLETED",
    winner: "Sarah Wong",
    winnerCountry: "SG",
    prize: 850000,
    totalEntries: 92,
    date: "2024-12-14",
    imageUrl: "https://images.unsplash.com/photo-1609743522653-52354461eb27?w=800",
  },
  {
    id: "5",
    tournamentId: "5",
    tournamentName: "PD17 Mystery Bounty",
    status: "COMPLETED",
    winner: "James Liu",
    winnerCountry: "TW",
    prize: 420000,
    totalEntries: 654,
    date: "2024-12-13",
    imageUrl: "https://images.unsplash.com/photo-1541123603104-512919d6a96c?w=800",
  },
];

export default function LiveReportsPage() {
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
              Tournament Coverage
            </span>
            <h1 style={{ fontSize: "clamp(32px, 5vw, 48px)", fontWeight: 700, marginBottom: "16px", color: "#fff" }}>Live Reports</h1>
            <p style={{ fontSize: "20px", color: "#888", lineHeight: 1.6 }}>
              Follow the action with live updates, chip counts, and key moments
              from ongoing Poker Dream tournaments.
            </p>
          </div>
        </div>
      </section>

      {/* Live Now Section */}
      {liveReports.length > 0 && (
        <section style={{ padding: "48px 0" }}>
          <div className="container">
            <h2 style={{ fontSize: "24px", fontWeight: 700, marginBottom: "24px", display: "flex", alignItems: "center", gap: "8px", color: "#fff" }}>
              <span style={{ width: "12px", height: "12px", background: "#E53935", borderRadius: "50%" }} />
              Live Now
            </h2>
            <div style={{ display: "grid", gridTemplateColumns: "repeat(1, 1fr)", gap: "24px" }} className="md:grid-cols-2">
              {liveReports.map((report) => (
                <Link key={report.id} href={`/live-reports/${report.id}`}>
                  <Card
                    hover
                    variant="bordered"
                    style={{ height: "100%", borderColor: "rgba(229, 57, 53, 0.3)" }}
                  >
                    <div style={{ position: "relative" }}>
                      <CardImage
                        src={report.imageUrl}
                        alt={report.tournamentName}
                        aspectRatio="16/9"
                      />
                      <div style={{ position: "absolute", top: "16px", left: "16px" }}>
                        <Badge variant="live">LIVE</Badge>
                      </div>
                      <div style={{ position: "absolute", bottom: "16px", right: "16px", background: "rgba(0,0,0,0.7)", backdropFilter: "blur(4px)", borderRadius: "8px", padding: "8px 12px" }}>
                        <p style={{ fontSize: "12px", color: "#888" }}>
                          Level {report.currentLevel}
                        </p>
                      </div>
                    </div>
                    <CardContent style={{ display: "flex", flexDirection: "column", gap: "16px" }}>
                      <h3 style={{ fontSize: "20px", fontWeight: 700, color: "#fff" }}>{report.tournamentName}</h3>
                      <div style={{ display: "grid", gridTemplateColumns: "repeat(2, 1fr)", gap: "16px" }}>
                        <div style={{ background: "#0A0A0A", borderRadius: "8px", padding: "12px" }}>
                          <p style={{ fontSize: "12px", color: "#666" }}>
                            Players Left
                          </p>
                          <p style={{ fontSize: "18px", fontWeight: 700, color: "#fff" }}>
                            {report.playersRemaining} / {report.totalEntries}
                          </p>
                        </div>
                        <div style={{ background: "#0A0A0A", borderRadius: "8px", padding: "12px" }}>
                          <p style={{ fontSize: "12px", color: "#666" }}>
                            Last Update
                          </p>
                          <p style={{ fontSize: "18px", fontWeight: 700, color: "#fff" }}>
                            {new Date(report.lastUpdate).toLocaleTimeString("en-US", {
                              hour: "2-digit",
                              minute: "2-digit",
                            })}
                          </p>
                        </div>
                      </div>
                      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", fontSize: "14px" }}>
                        <span style={{ color: "#888" }}>
                          Follow live updates
                        </span>
                        <ChevronRight style={{ width: "16px", height: "16px", color: "#E53935" }} />
                      </div>
                    </CardContent>
                  </Card>
                </Link>
              ))}
            </div>
          </div>
        </section>
      )}

      {/* Past Reports Section */}
      <section style={{ padding: "48px 0", background: "#121212" }}>
        <div className="container">
          <h2 style={{ fontSize: "24px", fontWeight: 700, marginBottom: "24px", color: "#fff" }}>Recent Completed Events</h2>
          <div style={{ display: "flex", flexDirection: "column", gap: "16px" }}>
            {pastReports.map((report) => (
              <Link key={report.id} href={`/live-reports/${report.id}`}>
                <Card
                  hover
                  variant="bordered"
                  style={{ display: "flex", flexDirection: "column", overflow: "hidden" }}
                  className="md:flex-row"
                >
                  <div style={{ flexShrink: 0 }} className="md:w-64">
                    <CardImage
                      src={report.imageUrl}
                      alt={report.tournamentName}
                      aspectRatio="16/9"
                    />
                  </div>
                  <CardContent style={{ flex: 1, display: "flex", flexDirection: "column", justifyContent: "space-between", gap: "16px" }} className="md:flex-row md:items-center">
                    <div>
                      <div style={{ marginBottom: "8px" }}>
                        <Badge variant="default" size="sm">
                          COMPLETED
                        </Badge>
                      </div>
                      <h3 style={{ fontSize: "20px", fontWeight: 700, marginBottom: "8px", color: "#fff" }}>
                        {report.tournamentName}
                      </h3>
                      <div style={{ display: "flex", alignItems: "center", gap: "16px", fontSize: "14px", color: "#888" }}>
                        <div style={{ display: "flex", alignItems: "center", gap: "4px" }}>
                          <Calendar style={{ width: "16px", height: "16px" }} />
                          <span>{formatDate(report.date)}</span>
                        </div>
                        <div style={{ display: "flex", alignItems: "center", gap: "4px" }}>
                          <Users style={{ width: "16px", height: "16px" }} />
                          <span>{report.totalEntries} entries</span>
                        </div>
                      </div>
                    </div>
                    <div style={{ display: "flex", alignItems: "center", gap: "16px" }}>
                      <div style={{ textAlign: "right" }}>
                        <p style={{ fontSize: "14px", color: "#666" }}>
                          Winner
                        </p>
                        <div style={{ display: "flex", alignItems: "center", gap: "8px", justifyContent: "flex-end" }}>
                          <img
                            src={`https://flagcdn.com/24x18/${report.winnerCountry.toLowerCase()}.png`}
                            alt=""
                            style={{ width: "20px", height: "16px" }}
                          />
                          <span style={{ fontWeight: 700, color: "#fff" }}>{report.winner}</span>
                        </div>
                        <p style={{ color: "#FFD700", fontWeight: 700 }}>
                          RM {(report.prize / 1000).toFixed(0)}K
                        </p>
                      </div>
                      <ChevronRight style={{ width: "20px", height: "20px", color: "#666" }} />
                    </div>
                  </CardContent>
                </Card>
              </Link>
            ))}
          </div>
        </div>
      </section>
    </div>
  );
}

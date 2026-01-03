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
    <div className="pt-20">
      {/* Hero Section */}
      <section className="py-16 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="max-w-2xl">
            <span className="inline-block px-4 py-2 mb-6 text-sm font-semibold text-[var(--gold)] bg-[var(--gold)]/10 rounded-full border border-[var(--gold)]/30">
              Tournament Coverage
            </span>
            <h1 className="text-4xl md:text-5xl font-bold mb-4">Live Reports</h1>
            <p className="text-xl text-[var(--foreground-secondary)]">
              Follow the action with live updates, chip counts, and key moments
              from ongoing Poker Dream tournaments.
            </p>
          </div>
        </div>
      </section>

      {/* Live Now Section */}
      {liveReports.length > 0 && (
        <section className="py-12">
          <div className="container">
            <h2 className="text-2xl font-bold mb-6 flex items-center gap-2">
              <span className="w-3 h-3 bg-[var(--error)] rounded-full animate-pulse" />
              Live Now
            </h2>
            <div className="grid md:grid-cols-2 gap-6">
              {liveReports.map((report) => (
                <Link key={report.id} href={`/live-reports/${report.id}`}>
                  <Card
                    hover
                    variant="bordered"
                    className="h-full border-[var(--primary)]/30"
                  >
                    <div className="relative">
                      <CardImage
                        src={report.imageUrl}
                        alt={report.tournamentName}
                        aspectRatio="16/9"
                      />
                      <div className="absolute top-4 left-4">
                        <Badge variant="live">LIVE</Badge>
                      </div>
                      <div className="absolute bottom-4 right-4 bg-black/70 backdrop-blur-sm rounded-lg px-3 py-2">
                        <p className="text-xs text-[var(--foreground-secondary)]">
                          Level {report.currentLevel}
                        </p>
                      </div>
                    </div>
                    <CardContent className="space-y-4">
                      <h3 className="text-xl font-bold">{report.tournamentName}</h3>
                      <div className="grid grid-cols-2 gap-4">
                        <div className="bg-[var(--background)] rounded-lg p-3">
                          <p className="text-xs text-[var(--foreground-muted)]">
                            Players Left
                          </p>
                          <p className="text-lg font-bold">
                            {report.playersRemaining} / {report.totalEntries}
                          </p>
                        </div>
                        <div className="bg-[var(--background)] rounded-lg p-3">
                          <p className="text-xs text-[var(--foreground-muted)]">
                            Last Update
                          </p>
                          <p className="text-lg font-bold">
                            {new Date(report.lastUpdate).toLocaleTimeString("en-US", {
                              hour: "2-digit",
                              minute: "2-digit",
                            })}
                          </p>
                        </div>
                      </div>
                      <div className="flex items-center justify-between text-sm">
                        <span className="text-[var(--foreground-secondary)]">
                          Follow live updates
                        </span>
                        <ChevronRight className="w-4 h-4 text-[var(--primary)]" />
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
      <section className="py-12 bg-[var(--background-secondary)]">
        <div className="container">
          <h2 className="text-2xl font-bold mb-6">Recent Completed Events</h2>
          <div className="space-y-4">
            {pastReports.map((report) => (
              <Link key={report.id} href={`/live-reports/${report.id}`}>
                <Card
                  hover
                  variant="bordered"
                  className="flex flex-col md:flex-row overflow-hidden"
                >
                  <div className="md:w-64 flex-shrink-0">
                    <CardImage
                      src={report.imageUrl}
                      alt={report.tournamentName}
                      aspectRatio="16/9"
                      className="md:aspect-auto md:h-full"
                    />
                  </div>
                  <CardContent className="flex-1 flex flex-col md:flex-row md:items-center justify-between gap-4">
                    <div>
                      <Badge variant="default" size="sm" className="mb-2">
                        COMPLETED
                      </Badge>
                      <h3 className="text-xl font-bold mb-2">
                        {report.tournamentName}
                      </h3>
                      <div className="flex items-center gap-4 text-sm text-[var(--foreground-secondary)]">
                        <div className="flex items-center gap-1">
                          <Calendar className="w-4 h-4" />
                          <span>{formatDate(report.date)}</span>
                        </div>
                        <div className="flex items-center gap-1">
                          <Users className="w-4 h-4" />
                          <span>{report.totalEntries} entries</span>
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <div className="text-right">
                        <p className="text-sm text-[var(--foreground-muted)]">
                          Winner
                        </p>
                        <div className="flex items-center gap-2">
                          <img
                            src={`https://flagcdn.com/24x18/${report.winnerCountry.toLowerCase()}.png`}
                            alt=""
                            className="w-5 h-4"
                          />
                          <span className="font-bold">{report.winner}</span>
                        </div>
                        <p className="text-[var(--gold)] font-bold">
                          RM {(report.prize / 1000).toFixed(0)}K
                        </p>
                      </div>
                      <ChevronRight className="w-5 h-5 text-[var(--foreground-muted)]" />
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

"use client";

import { useState } from "react";
import Link from "next/link";
import { ChevronLeft, X, Trophy } from "lucide-react";
import { Button } from "@/components/ui/button";
import { formatCurrency } from "@/lib/utils";

// Mock champions data
const champions = [
  {
    id: "1",
    name: "Michael Chen",
    country: "Malaysia",
    countryCode: "MY",
    event: "PD18 Main Event",
    prize: 1250000,
    date: "February 2025",
    imageUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800",
  },
  {
    id: "2",
    name: "Sarah Wong",
    country: "Singapore",
    countryCode: "SG",
    event: "PD18 High Roller",
    prize: 850000,
    date: "February 2025",
    imageUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800",
  },
  {
    id: "3",
    name: "James Liu",
    country: "Taiwan",
    countryCode: "TW",
    event: "PD17 Main Event",
    prize: 1150000,
    date: "December 2024",
    imageUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=800",
  },
  {
    id: "4",
    name: "David Park",
    country: "South Korea",
    countryCode: "KR",
    event: "PD17 High Roller",
    prize: 780000,
    date: "December 2024",
    imageUrl: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=800",
  },
  {
    id: "5",
    name: "Lisa Tanaka",
    country: "Japan",
    countryCode: "JP",
    event: "PD17 Ladies Championship",
    prize: 125000,
    date: "December 2024",
    imageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=800",
  },
  {
    id: "6",
    name: "Wei Zhang",
    country: "China",
    countryCode: "CN",
    event: "PD16 Main Event",
    prize: 980000,
    date: "September 2024",
    imageUrl: "https://images.unsplash.com/photo-1566492031773-4f4e44671857?w=800",
  },
  {
    id: "7",
    name: "Tommy Nguyen",
    country: "Vietnam",
    countryCode: "VN",
    event: "PD16 Mystery Bounty",
    prize: 420000,
    date: "September 2024",
    imageUrl: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=800",
  },
  {
    id: "8",
    name: "Anna Kim",
    country: "South Korea",
    countryCode: "KR",
    event: "PD15 Main Event",
    prize: 1050000,
    date: "June 2024",
    imageUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800",
  },
];

const years = ["2025", "2024", "2023", "2022"];

export default function ChampionsGalleryPage() {
  const [selectedChampion, setSelectedChampion] = useState<typeof champions[0] | null>(null);
  const [selectedYear, setSelectedYear] = useState<string>("all");

  const filteredChampions =
    selectedYear === "all"
      ? champions
      : champions.filter((c) => c.date.includes(selectedYear));

  return (
    <div style={{ paddingTop: "80px" }}>
      {/* Hero Section */}
      <section style={{ padding: "64px 0", background: "#121212" }}>
        <div className="container">
          <Link
            href="/gallery"
            style={{ display: "inline-flex", alignItems: "center", color: "#888", textDecoration: "none", marginBottom: "24px" }}
          >
            <ChevronLeft style={{ width: "16px", height: "16px", marginRight: "4px" }} />
            Back to Gallery
          </Link>
          <h1 style={{ fontSize: "clamp(32px, 5vw, 48px)", fontWeight: 700, marginBottom: "16px", display: "flex", alignItems: "center", gap: "12px", color: "#fff" }}>
            <Trophy style={{ width: "48px", height: "48px", color: "#FFD700" }} />
            Champions Gallery
          </h1>
          <p style={{ fontSize: "20px", color: "#888", lineHeight: 1.6 }}>
            Celebrating our tournament winners and their victories.
          </p>
        </div>
      </section>

      {/* Filter Tabs */}
      <section style={{ padding: "24px 0", borderBottom: "1px solid #333", position: "sticky", top: "80px", background: "#0A0A0A", zIndex: 30 }}>
        <div className="container">
          <div style={{ display: "flex", gap: "8px", overflowX: "auto" }}>
            <Button
              variant={selectedYear === "all" ? "primary" : "outline"}
              size="sm"
              onClick={() => setSelectedYear("all")}
            >
              All Years
            </Button>
            {years.map((year) => (
              <Button
                key={year}
                variant={selectedYear === year ? "primary" : "outline"}
                size="sm"
                onClick={() => setSelectedYear(year)}
              >
                {year}
              </Button>
            ))}
          </div>
        </div>
      </section>

      {/* Champions Grid */}
      <section style={{ padding: "48px 0" }}>
        <div className="container">
          <div style={{ display: "grid", gridTemplateColumns: "repeat(2, 1fr)", gap: "24px" }} className="md:grid-cols-3 lg:grid-cols-4">
            {filteredChampions.map((champion) => (
              <div
                key={champion.id}
                className="group cursor-pointer"
                onClick={() => setSelectedChampion(champion)}
              >
                <div className="relative aspect-[3/4] rounded-xl overflow-hidden" style={{ marginBottom: "16px" }}>
                  <img
                    src={champion.imageUrl}
                    alt={champion.name}
                    className="w-full h-full object-cover transition-transform duration-300 group-hover:scale-110"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
                  <div className="absolute bottom-0 left-0 right-0 p-4 translate-y-full group-hover:translate-y-0 transition-transform duration-300">
                    <p style={{ color: "#FFD700", fontWeight: 700, fontSize: "18px" }}>
                      {formatCurrency(champion.prize)}
                    </p>
                  </div>
                  <div style={{ position: "absolute", top: "16px", right: "16px" }}>
                    <Trophy style={{ width: "24px", height: "24px", color: "#FFD700" }} />
                  </div>
                </div>
                <h3 style={{ fontWeight: 700, marginBottom: "4px", color: "#fff" }}>{champion.name}</h3>
                <div style={{ display: "flex", alignItems: "center", gap: "8px", marginBottom: "4px" }}>
                  <img
                    src={`https://flagcdn.com/20x15/${champion.countryCode.toLowerCase()}.png`}
                    alt={champion.country}
                    style={{ width: "20px", height: "16px" }}
                  />
                  <span style={{ fontSize: "14px", color: "#888" }}>
                    {champion.country}
                  </span>
                </div>
                <p style={{ fontSize: "14px", color: "#666" }}>
                  {champion.event}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Lightbox Modal */}
      {selectedChampion && (
        <div
          style={{ position: "fixed", inset: 0, zIndex: 50, background: "rgba(0,0,0,0.9)", display: "flex", alignItems: "center", justifyContent: "center", padding: "16px" }}
          onClick={() => setSelectedChampion(null)}
        >
          <button
            style={{ position: "absolute", top: "16px", right: "16px", width: "40px", height: "40px", borderRadius: "50%", background: "rgba(255,255,255,0.1)", display: "flex", alignItems: "center", justifyContent: "center", color: "#fff", border: "none", cursor: "pointer" }}
            onClick={() => setSelectedChampion(null)}
          >
            <X style={{ width: "24px", height: "24px" }} />
          </button>
          <div
            style={{ maxWidth: "672px", width: "100%", background: "#1E1E1E", borderRadius: "16px", overflow: "hidden" }}
            onClick={(e) => e.stopPropagation()}
          >
            <div style={{ aspectRatio: "4/3", position: "relative" }}>
              <img
                src={selectedChampion.imageUrl.replace("w=800", "w=1200")}
                alt={selectedChampion.name}
                style={{ width: "100%", height: "100%", objectFit: "cover" }}
              />
              <div style={{ position: "absolute", bottom: "16px", left: "16px" }}>
                <Trophy style={{ width: "48px", height: "48px", color: "#FFD700" }} />
              </div>
            </div>
            <div style={{ padding: "24px" }}>
              <h2 style={{ fontSize: "24px", fontWeight: 700, marginBottom: "8px", color: "#fff" }}>{selectedChampion.name}</h2>
              <div style={{ display: "flex", alignItems: "center", gap: "8px", marginBottom: "16px" }}>
                <img
                  src={`https://flagcdn.com/24x18/${selectedChampion.countryCode.toLowerCase()}.png`}
                  alt={selectedChampion.country}
                  style={{ width: "24px", height: "16px" }}
                />
                <span style={{ color: "#888" }}>
                  {selectedChampion.country}
                </span>
              </div>
              <div style={{ display: "grid", gridTemplateColumns: "repeat(2, 1fr)", gap: "16px" }}>
                <div style={{ background: "#0A0A0A", borderRadius: "8px", padding: "16px" }}>
                  <p style={{ fontSize: "14px", color: "#666" }}>Event</p>
                  <p style={{ fontWeight: 700, color: "#fff" }}>{selectedChampion.event}</p>
                </div>
                <div style={{ background: "#0A0A0A", borderRadius: "8px", padding: "16px" }}>
                  <p style={{ fontSize: "14px", color: "#666" }}>Prize</p>
                  <p style={{ fontWeight: 700, color: "#FFD700" }}>
                    {formatCurrency(selectedChampion.prize)}
                  </p>
                </div>
              </div>
              <p style={{ color: "#888", marginTop: "16px" }}>
                {selectedChampion.date}
              </p>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

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
    <div className="pt-20">
      {/* Hero Section */}
      <section className="py-16 bg-[var(--background-secondary)]">
        <div className="container">
          <Link
            href="/gallery"
            className="inline-flex items-center text-[var(--foreground-secondary)] hover:text-white mb-6"
          >
            <ChevronLeft className="w-4 h-4 mr-1" />
            Back to Gallery
          </Link>
          <h1 className="text-4xl md:text-5xl font-bold mb-4 flex items-center gap-3">
            <Trophy className="w-12 h-12 text-[var(--gold)]" />
            Champions Gallery
          </h1>
          <p className="text-xl text-[var(--foreground-secondary)]">
            Celebrating our tournament winners and their victories.
          </p>
        </div>
      </section>

      {/* Filter Tabs */}
      <section className="py-6 border-b border-[var(--border)] sticky top-20 bg-[var(--background)] z-30">
        <div className="container">
          <div className="flex gap-2 overflow-x-auto">
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
      <section className="py-12">
        <div className="container">
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            {filteredChampions.map((champion) => (
              <div
                key={champion.id}
                className="group cursor-pointer"
                onClick={() => setSelectedChampion(champion)}
              >
                <div className="relative aspect-[3/4] rounded-xl overflow-hidden mb-4">
                  <img
                    src={champion.imageUrl}
                    alt={champion.name}
                    className="w-full h-full object-cover transition-transform duration-300 group-hover:scale-110"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
                  <div className="absolute bottom-0 left-0 right-0 p-4 translate-y-full group-hover:translate-y-0 transition-transform duration-300">
                    <p className="text-[var(--gold)] font-bold text-lg">
                      {formatCurrency(champion.prize)}
                    </p>
                  </div>
                  <div className="absolute top-4 right-4">
                    <Trophy className="w-6 h-6 text-[var(--gold)]" />
                  </div>
                </div>
                <h3 className="font-bold mb-1">{champion.name}</h3>
                <div className="flex items-center gap-2 mb-1">
                  <img
                    src={`https://flagcdn.com/20x15/${champion.countryCode.toLowerCase()}.png`}
                    alt={champion.country}
                    className="w-5 h-4"
                  />
                  <span className="text-sm text-[var(--foreground-secondary)]">
                    {champion.country}
                  </span>
                </div>
                <p className="text-sm text-[var(--foreground-muted)]">
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
          className="fixed inset-0 z-50 bg-black/90 flex items-center justify-center p-4"
          onClick={() => setSelectedChampion(null)}
        >
          <button
            className="absolute top-4 right-4 w-10 h-10 rounded-full bg-white/10 flex items-center justify-center text-white hover:bg-white/20 transition-colors"
            onClick={() => setSelectedChampion(null)}
          >
            <X className="w-6 h-6" />
          </button>
          <div
            className="max-w-2xl w-full bg-[var(--surface)] rounded-2xl overflow-hidden"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="aspect-[4/3] relative">
              <img
                src={selectedChampion.imageUrl.replace("w=800", "w=1200")}
                alt={selectedChampion.name}
                className="w-full h-full object-cover"
              />
              <div className="absolute bottom-4 left-4">
                <Trophy className="w-12 h-12 text-[var(--gold)]" />
              </div>
            </div>
            <div className="p-6">
              <h2 className="text-2xl font-bold mb-2">{selectedChampion.name}</h2>
              <div className="flex items-center gap-2 mb-4">
                <img
                  src={`https://flagcdn.com/24x18/${selectedChampion.countryCode.toLowerCase()}.png`}
                  alt={selectedChampion.country}
                  className="w-6 h-4"
                />
                <span className="text-[var(--foreground-secondary)]">
                  {selectedChampion.country}
                </span>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="bg-[var(--background)] rounded-lg p-4">
                  <p className="text-sm text-[var(--foreground-muted)]">Event</p>
                  <p className="font-bold">{selectedChampion.event}</p>
                </div>
                <div className="bg-[var(--background)] rounded-lg p-4">
                  <p className="text-sm text-[var(--foreground-muted)]">Prize</p>
                  <p className="font-bold text-[var(--gold)]">
                    {formatCurrency(selectedChampion.prize)}
                  </p>
                </div>
              </div>
              <p className="text-[var(--foreground-secondary)] mt-4">
                {selectedChampion.date}
              </p>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

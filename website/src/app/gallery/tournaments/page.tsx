"use client";

import { useState } from "react";
import Link from "next/link";
import { ChevronLeft, X } from "lucide-react";
import { Button } from "@/components/ui/button";

// Mock gallery data organized by series
const gallerySeries = [
  {
    id: "pd18",
    name: "Poker Dream 18",
    date: "February 2025",
    photos: [
      { id: "1", url: "https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=800", caption: "Main Event Day 1" },
      { id: "2", url: "https://images.unsplash.com/photo-1609743522653-52354461eb27?w=800", caption: "High Roller" },
      { id: "3", url: "https://images.unsplash.com/photo-1511193311914-0346f16efe90?w=800", caption: "Feature Table" },
      { id: "4", url: "https://images.unsplash.com/photo-1606167668584-78701c57f13d?w=800", caption: "Tournament Floor" },
    ],
  },
  {
    id: "pd17",
    name: "Poker Dream 17",
    date: "December 2024",
    photos: [
      { id: "5", url: "https://images.unsplash.com/photo-1541123603104-512919d6a96c?w=800", caption: "Main Event" },
      { id: "6", url: "https://images.unsplash.com/photo-1556866261-8763a7662333?w=800", caption: "Ladies Event" },
      { id: "7", url: "https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=800", caption: "Final Table" },
      { id: "8", url: "https://images.unsplash.com/photo-1609743522653-52354461eb27?w=800", caption: "Award Ceremony" },
    ],
  },
  {
    id: "pd16",
    name: "Poker Dream 16",
    date: "September 2024",
    photos: [
      { id: "9", url: "https://images.unsplash.com/photo-1511193311914-0346f16efe90?w=800", caption: "Opening Day" },
      { id: "10", url: "https://images.unsplash.com/photo-1606167668584-78701c57f13d?w=800", caption: "Tournament Action" },
      { id: "11", url: "https://images.unsplash.com/photo-1541123603104-512919d6a96c?w=800", caption: "Player Spotlight" },
      { id: "12", url: "https://images.unsplash.com/photo-1556866261-8763a7662333?w=800", caption: "Champion" },
    ],
  },
];

export default function TournamentGalleryPage() {
  const [selectedPhoto, setSelectedPhoto] = useState<{ url: string; caption: string } | null>(null);
  const [selectedSeries, setSelectedSeries] = useState<string>("all");

  const filteredSeries =
    selectedSeries === "all"
      ? gallerySeries
      : gallerySeries.filter((s) => s.id === selectedSeries);

  return (
    <div style={{ paddingTop: "80px" }}>
      {/* Hero Section */}
      <section
        style={{
          padding: "64px 0",
          background: "#121212",
        }}
      >
        <div className="container">
          <div style={{ marginBottom: "24px" }}>
            <Link
              href="/gallery"
              style={{
                display: "inline-flex",
                alignItems: "center",
                color: "#888",
                textDecoration: "none",
              }}
            >
              <ChevronLeft style={{ width: "16px", height: "16px", marginRight: "4px" }} />
              Back to Gallery
            </Link>
          </div>
          <h1
            style={{
              fontSize: "clamp(32px, 5vw, 48px)",
              fontWeight: 700,
              marginBottom: "16px",
              color: "#fff",
            }}
          >
            Tournament Photos
          </h1>
          <p
            style={{
              fontSize: "18px",
              color: "#888",
            }}
          >
            Browse action shots and moments from our poker tournaments.
          </p>
        </div>
      </section>

      {/* Filter Tabs */}
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
          <div style={{ display: "flex", gap: "8px", overflowX: "auto" }}>
            <Button
              variant={selectedSeries === "all" ? "primary" : "outline"}
              size="sm"
              onClick={() => setSelectedSeries("all")}
            >
              All Series
            </Button>
            {gallerySeries.map((series) => (
              <Button
                key={series.id}
                variant={selectedSeries === series.id ? "primary" : "outline"}
                size="sm"
                onClick={() => setSelectedSeries(series.id)}
              >
                {series.name}
              </Button>
            ))}
          </div>
        </div>
      </section>

      {/* Gallery Grid */}
      <section style={{ padding: "48px 0" }}>
        <div className="container">
          {filteredSeries.map((series) => (
            <div key={series.id} style={{ marginBottom: "48px" }}>
              <div
                style={{
                  display: "flex",
                  justifyContent: "space-between",
                  alignItems: "center",
                  marginBottom: "24px",
                }}
              >
                <div>
                  <h2 style={{ fontSize: "24px", fontWeight: 700, color: "#fff" }}>{series.name}</h2>
                  <p style={{ color: "#888", marginTop: "4px" }}>{series.date}</p>
                </div>
                <span style={{ color: "#666" }}>
                  {series.photos.length} photos
                </span>
              </div>
              <div
                style={{
                  display: "grid",
                  gridTemplateColumns: "repeat(2, 1fr)",
                  gap: "16px",
                }}
                className="md:grid-cols-3 lg:grid-cols-4">
                {series.photos.map((photo) => (
                  <div
                    key={photo.id}
                    className="relative aspect-square rounded-xl overflow-hidden group cursor-pointer"
                    onClick={() => setSelectedPhoto(photo)}
                  >
                    <img
                      src={photo.url}
                      alt={photo.caption}
                      className="w-full h-full object-cover transition-transform duration-300 group-hover:scale-110"
                    />
                    <div className="absolute inset-0 bg-black/0 group-hover:bg-black/50 transition-colors duration-300 flex items-end">
                      <p className="p-4 text-white text-sm opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                        {photo.caption}
                      </p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* Lightbox Modal */}
      {selectedPhoto && (
        <div
          className="fixed inset-0 z-50 bg-black/90 flex items-center justify-center p-4"
          onClick={() => setSelectedPhoto(null)}
        >
          <button
            className="absolute top-4 right-4 w-10 h-10 rounded-full bg-white/10 flex items-center justify-center text-white hover:bg-white/20 transition-colors"
            onClick={() => setSelectedPhoto(null)}
          >
            <X className="w-6 h-6" />
          </button>
          <div
            className="max-w-5xl max-h-[90vh] relative"
            onClick={(e) => e.stopPropagation()}
          >
            <img
              src={selectedPhoto.url.replace("w=800", "w=1600")}
              alt={selectedPhoto.caption}
              className="max-w-full max-h-[85vh] object-contain rounded-lg"
            />
            <p className="text-center text-white mt-4">{selectedPhoto.caption}</p>
          </div>
        </div>
      )}
    </div>
  );
}

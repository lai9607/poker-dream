"use client";

import { motion } from "framer-motion";
import { Sponsor } from "@/types";

// Helper to generate SVG placeholder for sponsor logos
const createSponsorSvg = (text: string): string => {
  const svg = `<svg xmlns="http://www.w3.org/2000/svg" width="180" height="60" viewBox="0 0 180 60">
    <rect width="180" height="60" fill="#1E1E1E" rx="8"/>
    <text x="90" y="36" fill="#888888" font-family="system-ui, sans-serif" font-size="16" font-weight="600" text-anchor="middle">${text}</text>
  </svg>`;
  return `data:image/svg+xml,${encodeURIComponent(svg)}`;
};

// Mock data - replace with API call
const sponsors: Sponsor[] = [
  {
    id: "1",
    name: "Resorts World Genting",
    logoUrl: createSponsorSvg("Resorts World Genting"),
    website: "https://rwgenting.com",
    tier: "PLATINUM",
    displayOrder: 1,
  },
  {
    id: "2",
    name: "Poker Stars",
    logoUrl: createSponsorSvg("PokerStars"),
    website: "https://pokerstars.com",
    tier: "PLATINUM",
    displayOrder: 2,
  },
  {
    id: "3",
    name: "888Poker",
    logoUrl: createSponsorSvg("888Poker"),
    website: "https://888poker.com",
    tier: "GOLD",
    displayOrder: 3,
  },
  {
    id: "4",
    name: "GG Poker",
    logoUrl: createSponsorSvg("GGPoker"),
    website: "https://ggpoker.com",
    tier: "GOLD",
    displayOrder: 4,
  },
  {
    id: "5",
    name: "Natural8",
    logoUrl: createSponsorSvg("Natural8"),
    website: "https://natural8.com",
    tier: "SILVER",
    displayOrder: 5,
  },
  {
    id: "6",
    name: "Shuffle Master",
    logoUrl: createSponsorSvg("Shuffle Master"),
    website: "https://shufflemaster.com",
    tier: "SILVER",
    displayOrder: 6,
  },
];

export function SponsorsSection() {
  return (
    <section
      style={{
        padding: "48px 0",
        background: "#121212",
        borderTop: "1px solid #333",
        borderBottom: "1px solid #333",
      }}
    >
      <div className="container">
        {/* Section Header */}
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          style={{
            textAlign: "center",
            marginBottom: "32px",
          }}
        >
          <span
            style={{
              color: "#666",
              fontWeight: 500,
              fontSize: "14px",
              textTransform: "uppercase",
              letterSpacing: "0.1em",
            }}
          >
            Proudly Sponsored By
          </span>
        </motion.div>

        {/* Sponsors Grid */}
        <motion.div
          initial={{ opacity: 0 }}
          whileInView={{ opacity: 1 }}
          viewport={{ once: true }}
          transition={{ delay: 0.2 }}
          style={{
            display: "flex",
            flexWrap: "wrap",
            justifyContent: "center",
            alignItems: "center",
            gap: "32px",
          }}
          className="md:gap-12"
        >
          {sponsors.map((sponsor) => (
            <a
              key={sponsor.id}
              href={sponsor.website}
              target="_blank"
              rel="noopener noreferrer"
              style={{
                opacity: 0.6,
                transition: "all 0.3s",
              }}
              onMouseOver={(e) => {
                e.currentTarget.style.opacity = "1";
              }}
              onMouseOut={(e) => {
                e.currentTarget.style.opacity = "0.6";
              }}
            >
              <img
                src={sponsor.logoUrl}
                alt={sponsor.name}
                style={{
                  height: "60px",
                  width: "auto",
                }}
              />
            </a>
          ))}
        </motion.div>
      </div>
    </section>
  );
}

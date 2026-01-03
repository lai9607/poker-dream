"use client";

import { motion } from "framer-motion";
import { Sponsor } from "@/types";

// Mock data - replace with API call
const sponsors: Sponsor[] = [
  {
    id: "1",
    name: "Resorts World Genting",
    logoUrl: "https://via.placeholder.com/200x80/1a1a1a/ffffff?text=RWG",
    website: "https://rwgenting.com",
    tier: "PLATINUM",
    displayOrder: 1,
  },
  {
    id: "2",
    name: "Poker Stars",
    logoUrl: "https://via.placeholder.com/200x80/1a1a1a/ffffff?text=PokerStars",
    website: "https://pokerstars.com",
    tier: "PLATINUM",
    displayOrder: 2,
  },
  {
    id: "3",
    name: "888Poker",
    logoUrl: "https://via.placeholder.com/200x80/1a1a1a/ffffff?text=888Poker",
    tier: "GOLD",
    displayOrder: 3,
  },
  {
    id: "4",
    name: "GG Poker",
    logoUrl: "https://via.placeholder.com/200x80/1a1a1a/ffffff?text=GGPoker",
    tier: "GOLD",
    displayOrder: 4,
  },
  {
    id: "5",
    name: "Natural8",
    logoUrl: "https://via.placeholder.com/200x80/1a1a1a/ffffff?text=Natural8",
    tier: "SILVER",
    displayOrder: 5,
  },
  {
    id: "6",
    name: "Shuffle Master",
    logoUrl: "https://via.placeholder.com/200x80/1a1a1a/ffffff?text=ShuffleMaster",
    tier: "SILVER",
    displayOrder: 6,
  },
];

export function SponsorsSection() {
  return (
    <section className="py-16 bg-[var(--background-tertiary)] border-y border-[var(--border)]">
      <div className="container">
        {/* Section Header */}
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="text-center mb-10"
        >
          <span className="text-[var(--foreground-muted)] font-medium text-sm uppercase tracking-wider">
            Proudly Sponsored By
          </span>
        </motion.div>

        {/* Sponsors Grid */}
        <motion.div
          initial={{ opacity: 0 }}
          whileInView={{ opacity: 1 }}
          viewport={{ once: true }}
          transition={{ delay: 0.2 }}
          className="flex flex-wrap justify-center items-center gap-8 md:gap-12"
        >
          {sponsors.map((sponsor) => (
            <a
              key={sponsor.id}
              href={sponsor.website}
              target="_blank"
              rel="noopener noreferrer"
              className="opacity-50 hover:opacity-100 transition-opacity duration-300"
            >
              <img
                src={sponsor.logoUrl}
                alt={sponsor.name}
                className="h-10 md:h-12 w-auto grayscale hover:grayscale-0 transition-all duration-300"
              />
            </a>
          ))}
        </motion.div>
      </div>
    </section>
  );
}

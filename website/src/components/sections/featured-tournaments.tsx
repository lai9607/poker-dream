"use client";

import Link from "next/link";
import { motion } from "framer-motion";
import { Calendar, MapPin, Users, Trophy, ArrowRight } from "lucide-react";
import { Card, CardContent, CardImage } from "@/components/ui/card";
import { formatCurrency, formatDate } from "@/lib/utils";
import { Tournament } from "@/types";

// Mock data - replace with API call
const featuredTournaments: Tournament[] = [
  {
    id: "1",
    name: "Poker Dream 18 Main Event",
    description: "The flagship event of the Poker Dream series",
    startDate: "2025-02-15",
    endDate: "2025-02-20",
    location: "Genting Highlands",
    venue: "Resorts World Genting",
    status: "UPCOMING",
    prizePool: 5000000,
    buyIn: 3300,
    totalEntries: 0,
    imageUrl: "https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=800",
  },
  {
    id: "2",
    name: "High Roller Championship",
    description: "Elite tournament for high stakes players",
    startDate: "2025-02-18",
    endDate: "2025-02-19",
    location: "Genting Highlands",
    venue: "Resorts World Genting",
    status: "UPCOMING",
    prizePool: 2000000,
    buyIn: 11000,
    totalEntries: 0,
    imageUrl: "https://images.unsplash.com/photo-1606167668584-78701c57f13d?w=800",
  },
  {
    id: "3",
    name: "Super Stack Turbo",
    description: "Fast-paced action with deep stacks",
    startDate: "2025-02-16",
    endDate: "2025-02-16",
    location: "Genting Highlands",
    venue: "Resorts World Genting",
    status: "LIVE",
    prizePool: 500000,
    buyIn: 550,
    totalEntries: 245,
    imageUrl: "https://images.unsplash.com/photo-1609743522653-52354461eb27?w=800",
  },
];

const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: {
      staggerChildren: 0.1,
    },
  },
};

const item = {
  hidden: { opacity: 0, y: 20 },
  show: { opacity: 1, y: 0 },
};

export function FeaturedTournaments() {
  return (
    <section
      style={{
        padding: "80px 0",
        background: "#0A0A0A",
      }}
    >
      <div className="container">
        {/* Section Header */}
        <div
          style={{
            display: "flex",
            flexDirection: "column",
            justifyContent: "space-between",
            alignItems: "flex-start",
            gap: "16px",
            marginBottom: "48px",
          }}
          className="md:flex-row md:items-end"
        >
          <div>
            <motion.span
              initial={{ opacity: 0, y: 10 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              style={{
                color: "#E53935",
                fontWeight: 600,
                fontSize: "14px",
                textTransform: "uppercase",
                letterSpacing: "0.1em",
              }}
            >
              Featured Events
            </motion.span>
            <motion.h2
              initial={{ opacity: 0, y: 10 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.1 }}
              style={{
                fontSize: "clamp(28px, 4vw, 40px)",
                fontWeight: 700,
                marginTop: "8px",
                color: "#fff",
              }}
            >
              Upcoming Tournaments
            </motion.h2>
          </div>
          <motion.div
            initial={{ opacity: 0, y: 10 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.2 }}
          >
            <Link
              href="/tournaments"
              style={{
                display: "inline-flex",
                alignItems: "center",
                color: "#888",
                textDecoration: "none",
                transition: "color 0.2s",
              }}
            >
              View All Events
              <ArrowRight style={{ width: "16px", height: "16px", marginLeft: "8px" }} />
            </Link>
          </motion.div>
        </div>

        {/* Tournament Cards */}
        <motion.div
          variants={container}
          initial="hidden"
          whileInView="show"
          viewport={{ once: true }}
          style={{
            display: "grid",
            gridTemplateColumns: "repeat(1, 1fr)",
            gap: "24px",
          }}
          className="md:grid-cols-2 lg:grid-cols-3"
        >
          {featuredTournaments.map((tournament) => (
            <motion.div key={tournament.id} variants={item}>
              <Link href={`/tournaments/${tournament.id}`} style={{ textDecoration: "none" }}>
                <Card hover variant="bordered" style={{ height: "100%" }}>
                  <div style={{ position: "relative" }}>
                    <CardImage
                      src={tournament.imageUrl}
                      alt={tournament.name}
                      aspectRatio="16/9"
                    />
                    <div style={{ position: "absolute", top: "16px", left: "16px" }}>
                      <span
                        style={{
                          display: "inline-block",
                          padding: "6px 12px",
                          fontSize: "12px",
                          fontWeight: 600,
                          textTransform: "uppercase",
                          color: "#fff",
                          background: tournament.status === "LIVE" ? "#4CAF50" : "#E53935",
                          borderRadius: "6px",
                        }}
                      >
                        {tournament.status === "LIVE" ? "LIVE NOW" : tournament.status}
                      </span>
                    </div>
                    <div style={{ position: "absolute", top: "16px", right: "16px" }}>
                      <div
                        style={{
                          background: "rgba(0,0,0,0.7)",
                          backdropFilter: "blur(8px)",
                          borderRadius: "8px",
                          padding: "8px 12px",
                        }}
                      >
                        <p style={{ fontSize: "12px", color: "#888", marginBottom: "2px" }}>
                          Buy-in
                        </p>
                        <p style={{ fontSize: "14px", fontWeight: 700, color: "#FFD700" }}>
                          {formatCurrency(tournament.buyIn)}
                        </p>
                      </div>
                    </div>
                  </div>
                  <CardContent>
                    <div style={{ marginBottom: "16px" }}>
                      <h3 style={{ fontSize: "20px", fontWeight: 700, marginBottom: "4px", color: "#fff" }}>
                        {tournament.name}
                      </h3>
                      <p style={{ color: "#888", fontSize: "14px" }}>
                        {tournament.description}
                      </p>
                    </div>

                    <div style={{ display: "flex", flexDirection: "column", gap: "8px", marginBottom: "16px" }}>
                      <div style={{ display: "flex", alignItems: "center", gap: "8px", fontSize: "14px", color: "#888" }}>
                        <Calendar style={{ width: "16px", height: "16px" }} />
                        <span>{formatDate(tournament.startDate)}</span>
                      </div>
                      <div style={{ display: "flex", alignItems: "center", gap: "8px", fontSize: "14px", color: "#888" }}>
                        <MapPin style={{ width: "16px", height: "16px" }} />
                        <span>{tournament.venue}</span>
                      </div>
                    </div>

                    <div
                      style={{
                        paddingTop: "16px",
                        borderTop: "1px solid #333",
                        display: "flex",
                        justifyContent: "space-between",
                        alignItems: "center",
                      }}
                    >
                      <div style={{ display: "flex", alignItems: "center", gap: "8px" }}>
                        <Trophy style={{ width: "16px", height: "16px", color: "#FFD700" }} />
                        <span style={{ fontWeight: 600, color: "#FFD700" }}>
                          {formatCurrency(tournament.prizePool)}
                        </span>
                      </div>
                      {tournament.totalEntries > 0 && (
                        <div style={{ display: "flex", alignItems: "center", gap: "8px", fontSize: "14px", color: "#888" }}>
                          <Users style={{ width: "16px", height: "16px" }} />
                          <span>{tournament.totalEntries} entries</span>
                        </div>
                      )}
                    </div>
                  </CardContent>
                </Card>
              </Link>
            </motion.div>
          ))}
        </motion.div>
      </div>
    </section>
  );
}

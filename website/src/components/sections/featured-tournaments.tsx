"use client";

import Link from "next/link";
import { motion } from "framer-motion";
import { Calendar, MapPin, Users, Trophy, ArrowRight } from "lucide-react";
import { Card, CardContent, CardImage } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
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
    <section className="py-20 bg-[var(--background)]">
      <div className="container">
        {/* Section Header */}
        <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-4 mb-12">
          <div>
            <motion.span
              initial={{ opacity: 0, y: 10 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              className="text-[var(--primary)] font-semibold text-sm uppercase tracking-wider"
            >
              Featured Events
            </motion.span>
            <motion.h2
              initial={{ opacity: 0, y: 10 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.1 }}
              className="text-3xl md:text-4xl font-bold mt-2"
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
            <Link href="/tournaments" className="group inline-flex items-center text-[var(--foreground-secondary)] hover:text-white transition-colors">
              View All Events
              <ArrowRight className="w-4 h-4 ml-2 transition-transform group-hover:translate-x-1" />
            </Link>
          </motion.div>
        </div>

        {/* Tournament Cards */}
        <motion.div
          variants={container}
          initial="hidden"
          whileInView="show"
          viewport={{ once: true }}
          className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6"
        >
          {featuredTournaments.map((tournament) => (
            <motion.div key={tournament.id} variants={item}>
              <Link href={`/tournaments/${tournament.id}`}>
                <Card hover variant="bordered" className="h-full">
                  <div className="relative">
                    <CardImage
                      src={tournament.imageUrl}
                      alt={tournament.name}
                      aspectRatio="16/9"
                    />
                    <div className="absolute top-4 left-4">
                      <Badge
                        variant={
                          tournament.status === "LIVE" ? "live" : "primary"
                        }
                      >
                        {tournament.status === "LIVE" ? "LIVE NOW" : tournament.status}
                      </Badge>
                    </div>
                    <div className="absolute top-4 right-4">
                      <div className="bg-black/70 backdrop-blur-sm rounded-lg px-3 py-1.5">
                        <p className="text-xs text-[var(--foreground-secondary)]">
                          Buy-in
                        </p>
                        <p className="text-sm font-bold text-[var(--gold)]">
                          {formatCurrency(tournament.buyIn)}
                        </p>
                      </div>
                    </div>
                  </div>
                  <CardContent className="space-y-4">
                    <div>
                      <h3 className="text-xl font-bold mb-1">{tournament.name}</h3>
                      <p className="text-[var(--foreground-secondary)] text-sm line-clamp-2">
                        {tournament.description}
                      </p>
                    </div>

                    <div className="space-y-2">
                      <div className="flex items-center gap-2 text-sm text-[var(--foreground-secondary)]">
                        <Calendar className="w-4 h-4" />
                        <span>{formatDate(tournament.startDate)}</span>
                      </div>
                      <div className="flex items-center gap-2 text-sm text-[var(--foreground-secondary)]">
                        <MapPin className="w-4 h-4" />
                        <span>{tournament.venue}</span>
                      </div>
                    </div>

                    <div className="pt-4 border-t border-[var(--border)] flex justify-between items-center">
                      <div className="flex items-center gap-2">
                        <Trophy className="w-4 h-4 text-[var(--gold)]" />
                        <span className="font-semibold text-[var(--gold)]">
                          {formatCurrency(tournament.prizePool)}
                        </span>
                      </div>
                      {tournament.totalEntries > 0 && (
                        <div className="flex items-center gap-2 text-sm text-[var(--foreground-secondary)]">
                          <Users className="w-4 h-4" />
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

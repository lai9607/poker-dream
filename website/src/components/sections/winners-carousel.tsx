"use client";

import { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { ChevronLeft, ChevronRight, Trophy } from "lucide-react";
import { formatCurrency } from "@/lib/utils";

interface Winner {
  id: string;
  name: string;
  country: string;
  countryCode: string;
  tournament: string;
  prize: number;
  imageUrl: string;
}

// Mock data - replace with API call
const winners: Winner[] = [
  {
    id: "1",
    name: "Michael Chen",
    country: "Malaysia",
    countryCode: "MY",
    tournament: "Poker Dream 17 Main Event",
    prize: 1250000,
    imageUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
  },
  {
    id: "2",
    name: "Sarah Wong",
    country: "Singapore",
    countryCode: "SG",
    tournament: "High Roller Championship",
    prize: 850000,
    imageUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400",
  },
  {
    id: "3",
    name: "James Liu",
    country: "Taiwan",
    countryCode: "TW",
    tournament: "Super Stack Main Event",
    prize: 620000,
    imageUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400",
  },
  {
    id: "4",
    name: "David Park",
    country: "South Korea",
    countryCode: "KR",
    tournament: "Mystery Bounty",
    prize: 480000,
    imageUrl: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400",
  },
  {
    id: "5",
    name: "Lisa Tanaka",
    country: "Japan",
    countryCode: "JP",
    tournament: "Ladies Championship",
    prize: 320000,
    imageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400",
  },
];

export function WinnersCarousel() {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [autoPlay, setAutoPlay] = useState(true);

  useEffect(() => {
    if (!autoPlay) return;

    const interval = setInterval(() => {
      setCurrentIndex((prev) => (prev + 1) % winners.length);
    }, 5000);

    return () => clearInterval(interval);
  }, [autoPlay]);

  const goToPrevious = () => {
    setAutoPlay(false);
    setCurrentIndex((prev) => (prev - 1 + winners.length) % winners.length);
  };

  const goToNext = () => {
    setAutoPlay(false);
    setCurrentIndex((prev) => (prev + 1) % winners.length);
  };

  const currentWinner = winners[currentIndex];

  return (
    <section className="py-20 bg-[var(--background-secondary)]">
      <div className="container">
        {/* Section Header */}
        <div className="text-center mb-12">
          <motion.span
            initial={{ opacity: 0, y: 10 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="text-[var(--gold)] font-semibold text-sm uppercase tracking-wider"
          >
            Hall of Champions
          </motion.span>
          <motion.h2
            initial={{ opacity: 0, y: 10 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.1 }}
            className="text-3xl md:text-4xl font-bold mt-2"
          >
            Recent Winners
          </motion.h2>
        </div>

        {/* Carousel */}
        <div className="relative max-w-4xl mx-auto">
          <div className="relative overflow-hidden rounded-2xl bg-[var(--surface)] border border-[var(--border)]">
            <AnimatePresence mode="wait">
              <motion.div
                key={currentIndex}
                initial={{ opacity: 0, x: 100 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: -100 }}
                transition={{ duration: 0.5 }}
                className="flex flex-col md:flex-row"
              >
                {/* Image */}
                <div className="relative md:w-1/2">
                  <div className="aspect-square md:aspect-auto md:h-full">
                    <img
                      src={currentWinner.imageUrl}
                      alt={currentWinner.name}
                      className="w-full h-full object-cover"
                    />
                  </div>
                  <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent md:bg-gradient-to-r" />
                  <div className="absolute bottom-4 left-4 md:hidden">
                    <Trophy className="w-12 h-12 text-[var(--gold)]" />
                  </div>
                </div>

                {/* Content */}
                <div className="p-8 md:w-1/2 flex flex-col justify-center">
                  <div className="hidden md:block mb-6">
                    <Trophy className="w-16 h-16 text-[var(--gold)]" />
                  </div>
                  <h3 className="text-2xl md:text-3xl font-bold mb-2">
                    {currentWinner.name}
                  </h3>
                  <div className="flex items-center gap-2 mb-4">
                    <img
                      src={`https://flagcdn.com/24x18/${currentWinner.countryCode.toLowerCase()}.png`}
                      alt={currentWinner.country}
                      className="w-6 h-4 object-cover rounded"
                    />
                    <span className="text-[var(--foreground-secondary)]">
                      {currentWinner.country}
                    </span>
                  </div>
                  <p className="text-[var(--foreground-secondary)] mb-4">
                    {currentWinner.tournament}
                  </p>
                  <div className="bg-[var(--background)] rounded-lg p-4 inline-block">
                    <p className="text-sm text-[var(--foreground-secondary)]">
                      Prize Won
                    </p>
                    <p className="text-3xl font-bold text-[var(--gold)]">
                      {formatCurrency(currentWinner.prize)}
                    </p>
                  </div>
                </div>
              </motion.div>
            </AnimatePresence>
          </div>

          {/* Navigation Arrows */}
          <button
            onClick={goToPrevious}
            className="absolute left-4 top-1/2 -translate-y-1/2 w-12 h-12 rounded-full bg-black/50 backdrop-blur-sm flex items-center justify-center text-white hover:bg-black/70 transition-colors"
            aria-label="Previous winner"
          >
            <ChevronLeft className="w-6 h-6" />
          </button>
          <button
            onClick={goToNext}
            className="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 rounded-full bg-black/50 backdrop-blur-sm flex items-center justify-center text-white hover:bg-black/70 transition-colors"
            aria-label="Next winner"
          >
            <ChevronRight className="w-6 h-6" />
          </button>

          {/* Dots */}
          <div className="flex justify-center gap-2 mt-6">
            {winners.map((_, index) => (
              <button
                key={index}
                onClick={() => {
                  setAutoPlay(false);
                  setCurrentIndex(index);
                }}
                className={`w-3 h-3 rounded-full transition-colors ${
                  index === currentIndex
                    ? "bg-[var(--primary)]"
                    : "bg-[var(--border)] hover:bg-[var(--border-light)]"
                }`}
                aria-label={`Go to winner ${index + 1}`}
              />
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}

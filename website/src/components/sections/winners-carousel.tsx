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
    <section
      style={{
        padding: "80px 0",
        background: "#121212",
      }}
    >
      <div className="container">
        {/* Section Header */}
        <div style={{ textAlign: "center", marginBottom: "48px" }}>
          <motion.span
            initial={{ opacity: 0, y: 10 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            style={{
              color: "#FFD700",
              fontWeight: 600,
              fontSize: "14px",
              textTransform: "uppercase",
              letterSpacing: "0.1em",
            }}
          >
            Hall of Champions
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
            Recent Winners
          </motion.h2>
        </div>

        {/* Carousel */}
        <div style={{ position: "relative", maxWidth: "900px", margin: "0 auto" }}>
          <div
            style={{
              position: "relative",
              overflow: "hidden",
              borderRadius: "16px",
              background: "#1E1E1E",
              border: "1px solid #333",
            }}
          >
            <AnimatePresence mode="wait">
              <motion.div
                key={currentIndex}
                initial={{ opacity: 0, x: 100 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: -100 }}
                transition={{ duration: 0.5 }}
                style={{
                  display: "flex",
                  flexDirection: "row",
                }}
                className="flex-col md:flex-row"
              >
                {/* Image */}
                <div
                  style={{
                    position: "relative",
                    width: "50%",
                    minHeight: "400px",
                  }}
                  className="w-full md:w-1/2"
                >
                  <img
                    src={currentWinner.imageUrl}
                    alt={currentWinner.name}
                    style={{
                      width: "100%",
                      height: "100%",
                      objectFit: "cover",
                      position: "absolute",
                      top: 0,
                      left: 0,
                    }}
                  />
                  <div
                    style={{
                      position: "absolute",
                      inset: 0,
                      background: "linear-gradient(to right, transparent 0%, rgba(30,30,30,0.8) 100%)",
                    }}
                  />
                </div>

                {/* Content */}
                <div
                  style={{
                    padding: "40px",
                    width: "50%",
                    display: "flex",
                    flexDirection: "column",
                    justifyContent: "center",
                  }}
                  className="w-full md:w-1/2"
                >
                  <div style={{ marginBottom: "24px" }}>
                    <Trophy style={{ width: "64px", height: "64px", color: "#FFD700" }} />
                  </div>
                  <h3
                    style={{
                      fontSize: "32px",
                      fontWeight: 700,
                      marginBottom: "8px",
                      color: "#fff",
                    }}
                  >
                    {currentWinner.name}
                  </h3>
                  <div
                    style={{
                      display: "flex",
                      alignItems: "center",
                      gap: "8px",
                      marginBottom: "16px",
                    }}
                  >
                    <img
                      src={`https://flagcdn.com/24x18/${currentWinner.countryCode.toLowerCase()}.png`}
                      alt={currentWinner.country}
                      style={{
                        width: "24px",
                        height: "18px",
                        objectFit: "cover",
                        borderRadius: "2px",
                      }}
                    />
                    <span style={{ color: "#888" }}>{currentWinner.country}</span>
                  </div>
                  <p style={{ color: "#888", marginBottom: "16px" }}>
                    {currentWinner.tournament}
                  </p>
                  <div
                    style={{
                      background: "#0A0A0A",
                      borderRadius: "12px",
                      padding: "16px 20px",
                      display: "inline-block",
                    }}
                  >
                    <p style={{ fontSize: "14px", color: "#888", marginBottom: "4px" }}>
                      Prize Won
                    </p>
                    <p
                      style={{
                        fontSize: "28px",
                        fontWeight: 700,
                        color: "#FFD700",
                      }}
                    >
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
            style={{
              position: "absolute",
              left: "16px",
              top: "50%",
              transform: "translateY(-50%)",
              width: "48px",
              height: "48px",
              borderRadius: "50%",
              background: "rgba(0,0,0,0.5)",
              backdropFilter: "blur(8px)",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              color: "#fff",
              border: "none",
              cursor: "pointer",
              transition: "background 0.2s",
            }}
            aria-label="Previous winner"
          >
            <ChevronLeft style={{ width: "24px", height: "24px" }} />
          </button>
          <button
            onClick={goToNext}
            style={{
              position: "absolute",
              right: "16px",
              top: "50%",
              transform: "translateY(-50%)",
              width: "48px",
              height: "48px",
              borderRadius: "50%",
              background: "rgba(0,0,0,0.5)",
              backdropFilter: "blur(8px)",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              color: "#fff",
              border: "none",
              cursor: "pointer",
              transition: "background 0.2s",
            }}
            aria-label="Next winner"
          >
            <ChevronRight style={{ width: "24px", height: "24px" }} />
          </button>

          {/* Dots */}
          <div
            style={{
              display: "flex",
              justifyContent: "center",
              gap: "8px",
              marginTop: "24px",
            }}
          >
            {winners.map((_, index) => (
              <button
                key={index}
                onClick={() => {
                  setAutoPlay(false);
                  setCurrentIndex(index);
                }}
                style={{
                  width: "12px",
                  height: "12px",
                  borderRadius: "50%",
                  background: index === currentIndex ? "#E53935" : "#333",
                  border: "none",
                  cursor: "pointer",
                  transition: "background 0.2s",
                }}
                aria-label={`Go to winner ${index + 1}`}
              />
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}

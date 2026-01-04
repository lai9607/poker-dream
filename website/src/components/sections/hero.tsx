"use client";

import Link from "next/link";
import { motion } from "framer-motion";
import { Calendar, Trophy } from "lucide-react";

export function HeroSection() {
  return (
    <section className="hero-section">
      {/* Background Image */}
      <div className="hero-bg-image" />
      {/* Gradient Overlay */}
      <div className="hero-overlay" />

      {/* Content */}
      <div className="container relative z-10 py-32">
        <div className="max-w-3xl">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
          >
            <span
              style={{
                display: "inline-block",
                padding: "8px 20px",
                marginBottom: "32px",
                fontSize: "12px",
                fontWeight: 600,
                textTransform: "uppercase",
                letterSpacing: "0.1em",
                color: "#000",
                background: "linear-gradient(135deg, #FFD700 0%, #FFA500 100%)",
                borderRadius: "9999px",
              }}
            >
              Asia&apos;s Premier Poker Tournament Series
            </span>
          </motion.div>

          <motion.h1
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.1 }}
            style={{
              fontSize: "clamp(48px, 8vw, 80px)",
              fontWeight: 700,
              lineHeight: 1.1,
              marginBottom: "24px",
              color: "#fff",
            }}
          >
            Where
            <br />
            <span
              style={{
                background: "linear-gradient(135deg, #E53935 0%, #FF6B6B 100%)",
                WebkitBackgroundClip: "text",
                WebkitTextFillColor: "transparent",
                backgroundClip: "text",
              }}
            >
              Champions
            </span>{" "}
            Are
            <br />
            Made
          </motion.h1>

          <motion.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            style={{
              fontSize: "18px",
              lineHeight: 1.7,
              color: "#B3B3B3",
              marginBottom: "32px",
              maxWidth: "500px",
            }}
          >
            Join thousands of players from around the world competing for glory
            and life-changing prizes at Malaysia&apos;s most prestigious poker
            events.
          </motion.p>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.3 }}
            style={{ display: "flex", gap: "16px", flexWrap: "wrap" }}
          >
            <Link href="/tournaments">
              <button
                style={{
                  display: "inline-flex",
                  alignItems: "center",
                  gap: "8px",
                  padding: "14px 28px",
                  fontSize: "16px",
                  fontWeight: 600,
                  color: "#fff",
                  background: "linear-gradient(135deg, #E53935 0%, #C62828 100%)",
                  border: "none",
                  borderRadius: "8px",
                  cursor: "pointer",
                  transition: "transform 0.2s, box-shadow 0.2s",
                }}
              >
                <Calendar style={{ width: "20px", height: "20px" }} />
                View Tournaments
              </button>
            </Link>
            <Link href="/dpoy">
              <button
                style={{
                  display: "inline-flex",
                  alignItems: "center",
                  gap: "8px",
                  padding: "14px 28px",
                  fontSize: "16px",
                  fontWeight: 600,
                  color: "#fff",
                  background: "transparent",
                  border: "2px solid rgba(255,255,255,0.3)",
                  borderRadius: "8px",
                  cursor: "pointer",
                  transition: "border-color 0.2s",
                }}
              >
                <Trophy style={{ width: "20px", height: "20px" }} />
                DPOY Rankings
              </button>
            </Link>
          </motion.div>

          {/* Stats */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.4 }}
            style={{
              display: "flex",
              gap: "48px",
              marginTop: "48px",
              paddingTop: "32px",
              borderTop: "1px solid rgba(255,255,255,0.1)",
            }}
          >
            <div>
              <p
                style={{
                  fontSize: "32px",
                  fontWeight: 700,
                  color: "#FFD700",
                  whiteSpace: "nowrap",
                }}
              >
                50+
              </p>
              <p style={{ fontSize: "14px", color: "#888", marginTop: "4px" }}>
                Events Per Year
              </p>
            </div>
            <div>
              <p
                style={{
                  fontSize: "32px",
                  fontWeight: 700,
                  color: "#FFD700",
                  whiteSpace: "nowrap",
                }}
              >
                RM 50M+
              </p>
              <p style={{ fontSize: "14px", color: "#888", marginTop: "4px" }}>
                Total Prize Pool
              </p>
            </div>
            <div>
              <p
                style={{
                  fontSize: "32px",
                  fontWeight: 700,
                  color: "#FFD700",
                  whiteSpace: "nowrap",
                }}
              >
                10K+
              </p>
              <p style={{ fontSize: "14px", color: "#888", marginTop: "4px" }}>
                Players Worldwide
              </p>
            </div>
          </motion.div>
        </div>
      </div>

      {/* Scroll Indicator */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 1, delay: 1 }}
        style={{
          position: "absolute",
          bottom: "32px",
          left: "50%",
          transform: "translateX(-50%)",
        }}
      >
        <div
          style={{
            width: "24px",
            height: "40px",
            border: "2px solid rgba(255,255,255,0.2)",
            borderRadius: "9999px",
            display: "flex",
            justifyContent: "center",
          }}
        >
          <motion.div
            animate={{ y: [0, 12, 0] }}
            transition={{ duration: 1.5, repeat: Infinity }}
            style={{
              width: "6px",
              height: "12px",
              background: "rgba(255,255,255,0.4)",
              borderRadius: "9999px",
              marginTop: "8px",
            }}
          />
        </div>
      </motion.div>
    </section>
  );
}

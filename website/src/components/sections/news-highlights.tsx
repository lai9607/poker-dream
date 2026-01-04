"use client";

import Link from "next/link";
import { motion } from "framer-motion";
import { ArrowRight, Clock } from "lucide-react";
import { Card, CardContent, CardImage } from "@/components/ui/card";
import { formatDate } from "@/lib/utils";
import { NewsArticle } from "@/types";

// Mock data - replace with API call
const newsArticles: NewsArticle[] = [
  {
    id: "1",
    title: "Poker Dream 18 Announces Record-Breaking Guarantee",
    summary:
      "The upcoming Poker Dream 18 series will feature a RM 10 Million guaranteed prize pool, the largest in Malaysian poker history.",
    content: "",
    imageUrl: "https://images.unsplash.com/photo-1541123603104-512919d6a96c?w=800",
    category: "ANNOUNCEMENT",
    author: "Poker Dream Team",
    publishedAt: "2025-01-15T10:00:00Z",
    createdAt: "2025-01-15T10:00:00Z",
    updatedAt: "2025-01-15T10:00:00Z",
  },
  {
    id: "2",
    title: "Strategy: How to Navigate Deep Stack Tournaments",
    summary:
      "Professional player Michael Chen shares his top tips for maximizing value in deep stack poker tournaments.",
    content: "",
    imageUrl: "https://images.unsplash.com/photo-1609743522653-52354461eb27?w=800",
    category: "STRATEGY",
    author: "Michael Chen",
    publishedAt: "2025-01-12T14:30:00Z",
    createdAt: "2025-01-12T14:30:00Z",
    updatedAt: "2025-01-12T14:30:00Z",
  },
  {
    id: "3",
    title: "Interview: 2024 DPOY Champion Reveals His Secrets",
    summary:
      "Exclusive interview with James Liu, the 2024 Poker Dream Player of the Year, on his winning strategies.",
    content: "",
    imageUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800",
    category: "PLAYER_INTERVIEW",
    author: "Poker Dream Media",
    publishedAt: "2025-01-10T09:00:00Z",
    createdAt: "2025-01-10T09:00:00Z",
    updatedAt: "2025-01-10T09:00:00Z",
  },
];

const categoryColors: Record<string, string> = {
  ANNOUNCEMENT: "#E53935",
  STRATEGY: "#4CAF50",
  PLAYER_INTERVIEW: "#FFD700",
  TOURNAMENT: "#E53935",
  PROMOTION: "#FF9800",
};

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

export function NewsHighlights() {
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
              Latest Updates
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
              News & Events
            </motion.h2>
          </div>
          <motion.div
            initial={{ opacity: 0, y: 10 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.2 }}
          >
            <Link
              href="/news"
              style={{
                display: "inline-flex",
                alignItems: "center",
                color: "#888",
                textDecoration: "none",
                transition: "color 0.2s",
              }}
            >
              View All News
              <ArrowRight style={{ width: "16px", height: "16px", marginLeft: "8px" }} />
            </Link>
          </motion.div>
        </div>

        {/* News Grid */}
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
          {newsArticles.map((article) => (
            <motion.div key={article.id} variants={item}>
              <Link href={`/news/${article.id}`} style={{ textDecoration: "none" }}>
                <Card hover variant="bordered" style={{ height: "100%" }}>
                  <div style={{ position: "relative" }}>
                    <CardImage
                      src={article.imageUrl}
                      alt={article.title}
                      aspectRatio="16/9"
                    />
                    <div style={{ position: "absolute", top: "16px", left: "16px" }}>
                      <span
                        style={{
                          display: "inline-block",
                          padding: "4px 10px",
                          fontSize: "11px",
                          fontWeight: 600,
                          textTransform: "uppercase",
                          color: article.category === "PLAYER_INTERVIEW" ? "#000" : "#fff",
                          background: categoryColors[article.category] || "#E53935",
                          borderRadius: "4px",
                        }}
                      >
                        {article.category.replace("_", " ")}
                      </span>
                    </div>
                  </div>
                  <CardContent>
                    <div style={{ marginBottom: "16px" }}>
                      <h3
                        style={{
                          fontSize: "18px",
                          fontWeight: 700,
                          marginBottom: "8px",
                          color: "#fff",
                          display: "-webkit-box",
                          WebkitLineClamp: 2,
                          WebkitBoxOrient: "vertical",
                          overflow: "hidden",
                        }}
                      >
                        {article.title}
                      </h3>
                      <p
                        style={{
                          color: "#888",
                          fontSize: "14px",
                          display: "-webkit-box",
                          WebkitLineClamp: 2,
                          WebkitBoxOrient: "vertical",
                          overflow: "hidden",
                        }}
                      >
                        {article.summary}
                      </p>
                    </div>

                    <div
                      style={{
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "space-between",
                        fontSize: "14px",
                        color: "#666",
                      }}
                    >
                      <span>{article.author}</span>
                      <div style={{ display: "flex", alignItems: "center", gap: "4px" }}>
                        <Clock style={{ width: "16px", height: "16px" }} />
                        <span>{formatDate(article.publishedAt)}</span>
                      </div>
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

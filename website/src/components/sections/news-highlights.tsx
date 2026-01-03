"use client";

import Link from "next/link";
import { motion } from "framer-motion";
import { ArrowRight, Clock } from "lucide-react";
import { Card, CardContent, CardImage } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
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

const categoryColors: Record<string, "primary" | "success" | "warning" | "gold"> = {
  ANNOUNCEMENT: "primary",
  STRATEGY: "success",
  PLAYER_INTERVIEW: "gold",
  TOURNAMENT: "primary",
  PROMOTION: "warning",
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
              Latest Updates
            </motion.span>
            <motion.h2
              initial={{ opacity: 0, y: 10 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.1 }}
              className="text-3xl md:text-4xl font-bold mt-2"
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
            <Link href="/news" className="group inline-flex items-center text-[var(--foreground-secondary)] hover:text-white transition-colors">
              View All News
              <ArrowRight className="w-4 h-4 ml-2 transition-transform group-hover:translate-x-1" />
            </Link>
          </motion.div>
        </div>

        {/* News Grid */}
        <motion.div
          variants={container}
          initial="hidden"
          whileInView="show"
          viewport={{ once: true }}
          className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6"
        >
          {newsArticles.map((article) => (
            <motion.div key={article.id} variants={item}>
              <Link href={`/news/${article.id}`}>
                <Card hover variant="bordered" className="h-full">
                  <div className="relative">
                    <CardImage
                      src={article.imageUrl}
                      alt={article.title}
                      aspectRatio="16/9"
                    />
                    <div className="absolute top-4 left-4">
                      <Badge
                        variant={categoryColors[article.category] || "default"}
                        size="sm"
                      >
                        {article.category.replace("_", " ")}
                      </Badge>
                    </div>
                  </div>
                  <CardContent className="space-y-4">
                    <div>
                      <h3 className="text-lg font-bold mb-2 line-clamp-2">
                        {article.title}
                      </h3>
                      <p className="text-[var(--foreground-secondary)] text-sm line-clamp-2">
                        {article.summary}
                      </p>
                    </div>

                    <div className="flex items-center justify-between text-sm text-[var(--foreground-muted)]">
                      <span>{article.author}</span>
                      <div className="flex items-center gap-1">
                        <Clock className="w-4 h-4" />
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

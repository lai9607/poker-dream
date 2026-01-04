"use client";

import { useState } from "react";
import Link from "next/link";
import { motion } from "framer-motion";
import { Clock, Search, Filter } from "lucide-react";
import { Card, CardContent, CardImage } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { formatDate } from "@/lib/utils";
import { NewsArticle, NewsCategory } from "@/types";

// Mock data
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
  {
    id: "4",
    title: "New Partnership: Poker Dream Teams Up with GGPoker",
    summary:
      "Exciting announcement as Poker Dream partners with GGPoker to offer online satellites for upcoming events.",
    content: "",
    imageUrl: "https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=800",
    category: "ANNOUNCEMENT",
    author: "Poker Dream Team",
    publishedAt: "2025-01-08T11:00:00Z",
    createdAt: "2025-01-08T11:00:00Z",
    updatedAt: "2025-01-08T11:00:00Z",
  },
  {
    id: "5",
    title: "Poker Dream 17 Main Event Recap",
    summary:
      "A look back at an incredible Main Event that saw 1,250 entries and a massive prize pool.",
    content: "",
    imageUrl: "https://images.unsplash.com/photo-1511193311914-0346f16efe90?w=800",
    category: "TOURNAMENT",
    author: "Poker Dream Media",
    publishedAt: "2025-01-05T16:00:00Z",
    createdAt: "2025-01-05T16:00:00Z",
    updatedAt: "2025-01-05T16:00:00Z",
  },
  {
    id: "6",
    title: "Early Bird Special: 20% Off Main Event Buy-In",
    summary:
      "Register early for Poker Dream 18 Main Event and save 20% on your buy-in. Limited time offer!",
    content: "",
    imageUrl: "https://images.unsplash.com/photo-1606167668584-78701c57f13d?w=800",
    category: "PROMOTION",
    author: "Poker Dream Team",
    publishedAt: "2025-01-03T09:00:00Z",
    createdAt: "2025-01-03T09:00:00Z",
    updatedAt: "2025-01-03T09:00:00Z",
  },
];

const categories: { value: NewsCategory | "ALL"; label: string }[] = [
  { value: "ALL", label: "All News" },
  { value: "ANNOUNCEMENT", label: "Announcements" },
  { value: "TOURNAMENT", label: "Tournaments" },
  { value: "STRATEGY", label: "Strategy" },
  { value: "PLAYER_INTERVIEW", label: "Interviews" },
  { value: "PROMOTION", label: "Promotions" },
];

const categoryColors: Record<NewsCategory, "primary" | "success" | "warning" | "gold"> = {
  ANNOUNCEMENT: "primary",
  STRATEGY: "success",
  PLAYER_INTERVIEW: "gold",
  TOURNAMENT: "primary",
  PROMOTION: "warning",
};

export default function NewsPage() {
  const [searchQuery, setSearchQuery] = useState("");
  const [categoryFilter, setCategoryFilter] = useState<NewsCategory | "ALL">("ALL");

  const filteredArticles = newsArticles.filter((article) => {
    if (
      searchQuery &&
      !article.title.toLowerCase().includes(searchQuery.toLowerCase())
    ) {
      return false;
    }
    if (categoryFilter !== "ALL" && article.category !== categoryFilter) {
      return false;
    }
    return true;
  });

  const featuredArticle = filteredArticles[0];
  const restArticles = filteredArticles.slice(1);

  return (
    <div style={{ paddingTop: "80px" }}>
      {/* Hero Section */}
      <section style={{ padding: "64px 0", background: "#121212" }}>
        <div className="container">
          <div style={{ maxWidth: "672px" }}>
            <span
              style={{
                display: "inline-block",
                padding: "8px 16px",
                marginBottom: "24px",
                fontSize: "14px",
                fontWeight: 600,
                color: "#FFD700",
                background: "rgba(255, 215, 0, 0.1)",
                borderRadius: "9999px",
                border: "1px solid rgba(255, 215, 0, 0.3)",
              }}
            >
              Latest Updates
            </span>
            <h1 style={{ fontSize: "clamp(32px, 5vw, 48px)", fontWeight: 700, marginBottom: "16px", color: "#fff" }}>News & Events</h1>
            <p style={{ fontSize: "20px", color: "#888", lineHeight: 1.6 }}>
              Stay updated with the latest poker news, tournament announcements,
              player interviews, and strategy tips.
            </p>
          </div>
        </div>
      </section>

      {/* Filters Section */}
      <section style={{ padding: "32px 0", borderBottom: "1px solid #333" }}>
        <div className="container">
          <div style={{ display: "flex", flexDirection: "column", gap: "16px" }} className="md:flex-row">
            <div style={{ position: "relative", flex: 1, maxWidth: "448px" }}>
              <Search style={{ position: "absolute", left: "14px", top: "50%", transform: "translateY(-50%)", width: "20px", height: "20px", color: "#666" }} />
              <Input
                type="text"
                placeholder="Search articles..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                hasIcon
              />
            </div>
            <div style={{ display: "flex", flexWrap: "wrap", gap: "8px" }}>
              {categories.map((cat) => (
                <Button
                  key={cat.value}
                  variant={categoryFilter === cat.value ? "primary" : "outline"}
                  size="sm"
                  onClick={() => setCategoryFilter(cat.value)}
                >
                  {cat.label}
                </Button>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* Articles Section */}
      <section style={{ padding: "48px 0" }}>
        <div className="container">
          {filteredArticles.length === 0 ? (
            <div style={{ textAlign: "center", padding: "64px 0" }}>
              <p style={{ color: "#666", fontSize: "18px" }}>
                No articles found matching your criteria.
              </p>
              <div style={{ marginTop: "16px" }}>
                <Button
                  variant="outline"
                  onClick={() => {
                    setSearchQuery("");
                    setCategoryFilter("ALL");
                  }}
                >
                  Clear Filters
                </Button>
              </div>
            </div>
          ) : (
            <>
              {/* Featured Article */}
              {featuredArticle && (
                <motion.div
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  style={{ marginBottom: "48px" }}
                >
                  <Link href={`/news/${featuredArticle.id}`}>
                    <Card hover variant="bordered" style={{ overflow: "hidden" }}>
                      <div style={{ display: "grid", gridTemplateColumns: "1fr" }} className="md:grid-cols-2">
                        <CardImage
                          src={featuredArticle.imageUrl}
                          alt={featuredArticle.title}
                          aspectRatio="16/10"
                        />
                        <CardContent style={{ padding: "32px", display: "flex", flexDirection: "column", justifyContent: "center" }}>
                          <div style={{ marginBottom: "16px", width: "fit-content" }}>
                            <Badge
                              variant={categoryColors[featuredArticle.category]}
                            >
                              {featuredArticle.category.replace("_", " ")}
                            </Badge>
                          </div>
                          <h2 style={{ fontSize: "clamp(24px, 3vw, 30px)", fontWeight: 700, marginBottom: "16px", color: "#fff" }}>
                            {featuredArticle.title}
                          </h2>
                          <p style={{ color: "#888", marginBottom: "24px" }}>
                            {featuredArticle.summary}
                          </p>
                          <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", fontSize: "14px", color: "#666" }}>
                            <span>{featuredArticle.author}</span>
                            <div style={{ display: "flex", alignItems: "center", gap: "4px" }}>
                              <Clock style={{ width: "16px", height: "16px" }} />
                              <span>{formatDate(featuredArticle.publishedAt)}</span>
                            </div>
                          </div>
                        </CardContent>
                      </div>
                    </Card>
                  </Link>
                </motion.div>
              )}

              {/* Articles Grid */}
              <div style={{ display: "grid", gridTemplateColumns: "repeat(1, 1fr)", gap: "24px" }} className="md:grid-cols-2 lg:grid-cols-3">
                {restArticles.map((article, index) => (
                  <motion.div
                    key={article.id}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: index * 0.1 }}
                  >
                    <Link href={`/news/${article.id}`}>
                      <Card hover variant="bordered" style={{ height: "100%" }}>
                        <div style={{ position: "relative" }}>
                          <CardImage
                            src={article.imageUrl}
                            alt={article.title}
                            aspectRatio="16/9"
                          />
                          <div style={{ position: "absolute", top: "16px", left: "16px" }}>
                            <Badge
                              variant={categoryColors[article.category]}
                              size="sm"
                            >
                              {article.category.replace("_", " ")}
                            </Badge>
                          </div>
                        </div>
                        <CardContent style={{ display: "flex", flexDirection: "column", gap: "16px" }}>
                          <div>
                            <h3 style={{ fontSize: "18px", fontWeight: 700, marginBottom: "8px", color: "#fff" }} className="line-clamp-2">
                              {article.title}
                            </h3>
                            <p style={{ color: "#888", fontSize: "14px" }} className="line-clamp-2">
                              {article.summary}
                            </p>
                          </div>
                          <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", fontSize: "14px", color: "#666" }}>
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
              </div>
            </>
          )}
        </div>
      </section>
    </div>
  );
}

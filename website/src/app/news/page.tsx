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
    <div className="pt-20">
      {/* Hero Section */}
      <section className="py-16 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="max-w-2xl">
            <span className="inline-block px-4 py-2 mb-6 text-sm font-semibold text-[var(--gold)] bg-[var(--gold)]/10 rounded-full border border-[var(--gold)]/30">
              Latest Updates
            </span>
            <h1 className="text-4xl md:text-5xl font-bold mb-4">News & Events</h1>
            <p className="text-xl text-[var(--foreground-secondary)]">
              Stay updated with the latest poker news, tournament announcements,
              player interviews, and strategy tips.
            </p>
          </div>
        </div>
      </section>

      {/* Filters Section */}
      <section className="py-8 border-b border-[var(--border)]">
        <div className="container">
          <div className="flex flex-col md:flex-row gap-4">
            <div className="relative flex-1 max-w-md">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-[var(--foreground-muted)]" />
              <Input
                type="text"
                placeholder="Search articles..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="pl-10"
              />
            </div>
            <div className="flex flex-wrap gap-2">
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
      <section className="py-12">
        <div className="container">
          {filteredArticles.length === 0 ? (
            <div className="text-center py-16">
              <p className="text-[var(--foreground-muted)] text-lg">
                No articles found matching your criteria.
              </p>
              <Button
                variant="outline"
                className="mt-4"
                onClick={() => {
                  setSearchQuery("");
                  setCategoryFilter("ALL");
                }}
              >
                Clear Filters
              </Button>
            </div>
          ) : (
            <>
              {/* Featured Article */}
              {featuredArticle && (
                <motion.div
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  className="mb-12"
                >
                  <Link href={`/news/${featuredArticle.id}`}>
                    <Card hover variant="bordered" className="overflow-hidden">
                      <div className="grid md:grid-cols-2">
                        <CardImage
                          src={featuredArticle.imageUrl}
                          alt={featuredArticle.title}
                          aspectRatio="16/10"
                          className="md:aspect-auto md:h-full"
                        />
                        <CardContent className="p-8 flex flex-col justify-center">
                          <Badge
                            variant={categoryColors[featuredArticle.category]}
                            className="mb-4 w-fit"
                          >
                            {featuredArticle.category.replace("_", " ")}
                          </Badge>
                          <h2 className="text-2xl md:text-3xl font-bold mb-4">
                            {featuredArticle.title}
                          </h2>
                          <p className="text-[var(--foreground-secondary)] mb-6">
                            {featuredArticle.summary}
                          </p>
                          <div className="flex items-center justify-between text-sm text-[var(--foreground-muted)]">
                            <span>{featuredArticle.author}</span>
                            <div className="flex items-center gap-1">
                              <Clock className="w-4 h-4" />
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
              <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
                {restArticles.map((article, index) => (
                  <motion.div
                    key={article.id}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: index * 0.1 }}
                  >
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
                              variant={categoryColors[article.category]}
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
              </div>
            </>
          )}
        </div>
      </section>
    </div>
  );
}

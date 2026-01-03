import { Metadata } from "next";
import Link from "next/link";
import {
  ChevronLeft,
  Clock,
  Share2,
  Facebook,
  Twitter,
  Linkedin,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardImage } from "@/components/ui/card";
import { formatDate } from "@/lib/utils";
import { NewsArticle, NewsCategory } from "@/types";

export const metadata: Metadata = {
  title: "Article",
  description: "Read the latest news from Poker Dream",
};

// Mock article data
const articleData: NewsArticle = {
  id: "1",
  title: "Poker Dream 18 Announces Record-Breaking Guarantee",
  summary:
    "The upcoming Poker Dream 18 series will feature a RM 10 Million guaranteed prize pool, the largest in Malaysian poker history.",
  content: `
    <p>Poker Dream is thrilled to announce the largest guaranteed prize pool in Malaysian poker history for our upcoming Poker Dream 18 series. The flagship Main Event will feature an unprecedented RM 10 Million guarantee, cementing our position as Asia's premier poker destination.</p>

    <h2>What to Expect</h2>
    <p>The Poker Dream 18 series will run from February 15-28, 2025, at the prestigious Resorts World Genting. The series will feature over 30 events catering to players of all bankroll levels, from RM 550 turbo events to the RM 33,000 Super High Roller.</p>

    <h2>Main Event Details</h2>
    <ul>
      <li><strong>Buy-in:</strong> RM 3,300</li>
      <li><strong>Starting Stack:</strong> 50,000 chips</li>
      <li><strong>Blind Levels:</strong> 40 minutes</li>
      <li><strong>Day 1 Flights:</strong> February 15-18</li>
      <li><strong>Final Day:</strong> February 20</li>
    </ul>

    <h2>Satellite Schedule</h2>
    <p>Players looking to win their seats can take advantage of our extensive satellite schedule. Daily satellites will run throughout the series, with buy-ins starting from just RM 165. Online satellites are also available through our partner GGPoker.</p>

    <h2>Additional Events</h2>
    <p>Beyond the Main Event, players can look forward to:</p>
    <ul>
      <li>Mystery Bounty (RM 1,100 buy-in, RM 2M GTD)</li>
      <li>High Roller (RM 11,000 buy-in, RM 3M GTD)</li>
      <li>Super High Roller (RM 33,000 buy-in)</li>
      <li>Ladies Championship (RM 550 buy-in)</li>
      <li>Team Event (RM 2,200 per team)</li>
    </ul>

    <h2>Early Bird Special</h2>
    <p>Register before January 31st and receive a 20% discount on the Main Event buy-in. This limited-time offer is our way of thanking loyal players for their continued support.</p>

    <p>For more information and to register, visit our tournaments page or contact our team at info@pokerdream.com.</p>
  `,
  imageUrl: "https://images.unsplash.com/photo-1541123603104-512919d6a96c?w=1920",
  category: "ANNOUNCEMENT",
  author: "Poker Dream Team",
  publishedAt: "2025-01-15T10:00:00Z",
  createdAt: "2025-01-15T10:00:00Z",
  updatedAt: "2025-01-15T10:00:00Z",
};

// Related articles
const relatedArticles: NewsArticle[] = [
  {
    id: "2",
    title: "Strategy: How to Navigate Deep Stack Tournaments",
    summary: "Professional player Michael Chen shares his top tips.",
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
    summary: "Exclusive interview with James Liu.",
    content: "",
    imageUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800",
    category: "PLAYER_INTERVIEW",
    author: "Poker Dream Media",
    publishedAt: "2025-01-10T09:00:00Z",
    createdAt: "2025-01-10T09:00:00Z",
    updatedAt: "2025-01-10T09:00:00Z",
  },
];

const categoryColors: Record<NewsCategory, "primary" | "success" | "warning" | "gold"> = {
  ANNOUNCEMENT: "primary",
  STRATEGY: "success",
  PLAYER_INTERVIEW: "gold",
  TOURNAMENT: "primary",
  PROMOTION: "warning",
};

export default function NewsArticlePage() {
  return (
    <div className="pt-20">
      {/* Hero Image */}
      <section className="relative h-[50vh] min-h-[400px]">
        <div
          className="absolute inset-0 bg-cover bg-center"
          style={{ backgroundImage: `url('${articleData.imageUrl}')` }}
        />
        <div className="absolute inset-0 bg-gradient-to-b from-black/50 via-black/30 to-[var(--background)]" />
      </section>

      {/* Article Content */}
      <section className="relative -mt-32 pb-16">
        <div className="container">
          <div className="max-w-3xl mx-auto">
            <Link
              href="/news"
              className="inline-flex items-center text-[var(--foreground-secondary)] hover:text-white mb-6"
            >
              <ChevronLeft className="w-4 h-4 mr-1" />
              Back to News
            </Link>

            <article className="bg-[var(--surface)] rounded-2xl p-8 md:p-12 border border-[var(--border)]">
              <Badge
                variant={categoryColors[articleData.category]}
                className="mb-4"
              >
                {articleData.category.replace("_", " ")}
              </Badge>

              <h1 className="text-3xl md:text-4xl font-bold mb-6">
                {articleData.title}
              </h1>

              <div className="flex items-center justify-between pb-6 mb-8 border-b border-[var(--border)]">
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 rounded-full bg-[var(--background)] flex items-center justify-center">
                    <span className="font-bold">
                      {articleData.author.charAt(0)}
                    </span>
                  </div>
                  <div>
                    <p className="font-medium">{articleData.author}</p>
                    <div className="flex items-center gap-1 text-sm text-[var(--foreground-muted)]">
                      <Clock className="w-4 h-4" />
                      <span>{formatDate(articleData.publishedAt)}</span>
                    </div>
                  </div>
                </div>

                {/* Share Buttons */}
                <div className="flex items-center gap-2">
                  <span className="text-sm text-[var(--foreground-muted)] mr-2">
                    Share:
                  </span>
                  <button className="w-8 h-8 rounded-full bg-[var(--background)] flex items-center justify-center text-[var(--foreground-secondary)] hover:text-[#1877F2] transition-colors">
                    <Facebook className="w-4 h-4" />
                  </button>
                  <button className="w-8 h-8 rounded-full bg-[var(--background)] flex items-center justify-center text-[var(--foreground-secondary)] hover:text-[#1DA1F2] transition-colors">
                    <Twitter className="w-4 h-4" />
                  </button>
                  <button className="w-8 h-8 rounded-full bg-[var(--background)] flex items-center justify-center text-[var(--foreground-secondary)] hover:text-[#0A66C2] transition-colors">
                    <Linkedin className="w-4 h-4" />
                  </button>
                </div>
              </div>

              {/* Article Body */}
              <div
                className="prose prose-invert max-w-none
                  prose-headings:text-[var(--foreground)] prose-headings:font-bold
                  prose-h2:text-2xl prose-h2:mt-8 prose-h2:mb-4
                  prose-p:text-[var(--foreground-secondary)] prose-p:leading-relaxed prose-p:mb-4
                  prose-ul:text-[var(--foreground-secondary)] prose-ul:my-4
                  prose-li:my-2
                  prose-strong:text-[var(--foreground)]"
                dangerouslySetInnerHTML={{ __html: articleData.content }}
              />
            </article>
          </div>
        </div>
      </section>

      {/* Related Articles */}
      <section className="py-16 bg-[var(--background-secondary)]">
        <div className="container">
          <h2 className="text-2xl font-bold mb-8">Related Articles</h2>
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {relatedArticles.map((article) => (
              <Link key={article.id} href={`/news/${article.id}`}>
                <Card hover variant="bordered" className="h-full">
                  <CardImage
                    src={article.imageUrl}
                    alt={article.title}
                    aspectRatio="16/9"
                  />
                  <CardContent>
                    <Badge
                      variant={categoryColors[article.category]}
                      size="sm"
                      className="mb-2"
                    >
                      {article.category.replace("_", " ")}
                    </Badge>
                    <h3 className="font-bold mb-2 line-clamp-2">
                      {article.title}
                    </h3>
                    <p className="text-sm text-[var(--foreground-secondary)] line-clamp-2">
                      {article.summary}
                    </p>
                  </CardContent>
                </Card>
              </Link>
            ))}
          </div>
        </div>
      </section>
    </div>
  );
}

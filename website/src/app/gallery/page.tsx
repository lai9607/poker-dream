import { Metadata } from "next";
import Link from "next/link";
import { Camera, Trophy, ChevronRight } from "lucide-react";
import { Card, CardContent, CardImage } from "@/components/ui/card";

export const metadata: Metadata = {
  title: "Gallery",
  description: "Browse photos from Poker Dream tournaments and champion celebrations.",
};

const galleryCategories = [
  {
    id: "tournaments",
    title: "Tournament Photos",
    description: "Action shots and moments from our poker tournaments",
    icon: Camera,
    imageUrl: "https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=800",
    count: 2500,
    href: "/gallery/tournaments",
  },
  {
    id: "champions",
    title: "Champions Gallery",
    description: "Celebrating our tournament winners and their victories",
    icon: Trophy,
    imageUrl: "https://images.unsplash.com/photo-1511193311914-0346f16efe90?w=800",
    count: 450,
    href: "/gallery/champions",
  },
];

const recentPhotos = [
  {
    id: "1",
    url: "https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=600",
    caption: "PD18 Main Event Day 1",
  },
  {
    id: "2",
    url: "https://images.unsplash.com/photo-1609743522653-52354461eb27?w=600",
    caption: "High Roller Final Table",
  },
  {
    id: "3",
    url: "https://images.unsplash.com/photo-1511193311914-0346f16efe90?w=600",
    caption: "Winner Celebration",
  },
  {
    id: "4",
    url: "https://images.unsplash.com/photo-1606167668584-78701c57f13d?w=600",
    caption: "Tournament Floor",
  },
  {
    id: "5",
    url: "https://images.unsplash.com/photo-1541123603104-512919d6a96c?w=600",
    caption: "Feature Table Action",
  },
  {
    id: "6",
    url: "https://images.unsplash.com/photo-1556866261-8763a7662333?w=600",
    caption: "Ladies Championship",
  },
];

export default function GalleryPage() {
  return (
    <div className="pt-20">
      {/* Hero Section */}
      <section className="py-16 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="max-w-2xl">
            <span className="inline-block px-4 py-2 mb-6 text-sm font-semibold text-[var(--gold)] bg-[var(--gold)]/10 rounded-full border border-[var(--gold)]/30">
              Photo Gallery
            </span>
            <h1 className="text-4xl md:text-5xl font-bold mb-4">Gallery</h1>
            <p className="text-xl text-[var(--foreground-secondary)]">
              Explore memorable moments from Poker Dream tournaments and
              celebrations.
            </p>
          </div>
        </div>
      </section>

      {/* Gallery Categories */}
      <section className="py-12">
        <div className="container">
          <div className="grid md:grid-cols-2 gap-8">
            {galleryCategories.map((category) => (
              <Link key={category.id} href={category.href}>
                <Card hover variant="bordered" className="h-full overflow-hidden">
                  <div className="relative">
                    <CardImage
                      src={category.imageUrl}
                      alt={category.title}
                      aspectRatio="16/9"
                    />
                    <div className="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent" />
                    <div className="absolute bottom-0 left-0 right-0 p-6">
                      <div className="flex items-center gap-3 mb-2">
                        <div className="w-12 h-12 rounded-lg bg-[var(--primary)] flex items-center justify-center">
                          <category.icon className="w-6 h-6 text-white" />
                        </div>
                        <div>
                          <h2 className="text-2xl font-bold">{category.title}</h2>
                          <p className="text-sm text-[var(--foreground-secondary)]">
                            {category.count.toLocaleString()} photos
                          </p>
                        </div>
                      </div>
                      <p className="text-[var(--foreground-secondary)]">
                        {category.description}
                      </p>
                    </div>
                  </div>
                </Card>
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* Recent Photos Grid */}
      <section className="py-12 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="flex justify-between items-center mb-8">
            <h2 className="text-2xl font-bold">Recent Photos</h2>
            <Link
              href="/gallery/tournaments"
              className="inline-flex items-center text-[var(--primary)] hover:text-[var(--primary-light)]"
            >
              View All
              <ChevronRight className="w-4 h-4 ml-1" />
            </Link>
          </div>
          <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
            {recentPhotos.map((photo) => (
              <div
                key={photo.id}
                className="relative aspect-square rounded-xl overflow-hidden group cursor-pointer"
              >
                <img
                  src={photo.url}
                  alt={photo.caption}
                  className="w-full h-full object-cover transition-transform duration-300 group-hover:scale-110"
                />
                <div className="absolute inset-0 bg-black/0 group-hover:bg-black/50 transition-colors duration-300 flex items-end">
                  <p className="p-4 text-white opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                    {photo.caption}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>
    </div>
  );
}

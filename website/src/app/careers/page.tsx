import { Metadata } from "next";
import Link from "next/link";
import {
  Briefcase,
  MapPin,
  Clock,
  ChevronRight,
  Users,
  Trophy,
  Heart,
  Zap,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { JobListing, JobType } from "@/types";

export const metadata: Metadata = {
  title: "Careers",
  description:
    "Join the Poker Dream team. Explore career opportunities and become part of Asia's premier poker tournament organization.",
};

const benefits = [
  {
    icon: Trophy,
    title: "Competitive Salary",
    description: "Industry-leading compensation packages",
  },
  {
    icon: Heart,
    title: "Health Benefits",
    description: "Comprehensive medical, dental, and vision coverage",
  },
  {
    icon: Users,
    title: "Great Team",
    description: "Work with passionate professionals",
  },
  {
    icon: Zap,
    title: "Career Growth",
    description: "Continuous learning and development opportunities",
  },
];

const jobListings: JobListing[] = [
  {
    id: "1",
    title: "Tournament Director",
    department: "Operations",
    location: "Genting Highlands, Malaysia",
    type: "FULL_TIME",
    description:
      "Lead and manage poker tournaments, ensuring smooth operations and exceptional player experiences.",
    requirements: [
      "5+ years experience in poker tournament management",
      "Strong leadership and communication skills",
      "Knowledge of TDA rules and regulations",
      "Ability to work under pressure",
    ],
    responsibilities: [
      "Oversee all aspects of tournament operations",
      "Manage floor staff and dealers",
      "Handle player disputes and rulings",
      "Coordinate with other departments",
    ],
    createdAt: "2025-01-10T00:00:00Z",
  },
  {
    id: "2",
    title: "Marketing Manager",
    department: "Marketing",
    location: "Kuala Lumpur, Malaysia",
    type: "FULL_TIME",
    description:
      "Drive marketing strategies to grow brand awareness and player engagement across Asia.",
    requirements: [
      "3+ years marketing experience in gaming or hospitality",
      "Strong digital marketing skills",
      "Experience with social media management",
      "Data-driven mindset",
    ],
    responsibilities: [
      "Develop and execute marketing campaigns",
      "Manage social media presence",
      "Analyze campaign performance",
      "Collaborate with design team",
    ],
    createdAt: "2025-01-08T00:00:00Z",
  },
  {
    id: "3",
    title: "Poker Dealer",
    department: "Gaming",
    location: "Genting Highlands, Malaysia",
    type: "FULL_TIME",
    description:
      "Deal poker games professionally while ensuring game integrity and player satisfaction.",
    requirements: [
      "Poker dealing certification preferred",
      "Knowledge of Texas Hold'em and other variants",
      "Excellent math skills",
      "Customer service orientation",
    ],
    responsibilities: [
      "Deal cards according to procedures",
      "Manage chip stacks and pots",
      "Enforce game rules",
      "Provide excellent customer service",
    ],
    createdAt: "2025-01-05T00:00:00Z",
  },
  {
    id: "4",
    title: "Content Creator",
    department: "Media",
    location: "Remote / Kuala Lumpur",
    type: "FULL_TIME",
    description:
      "Create engaging content for social media, website, and marketing materials.",
    requirements: [
      "2+ years content creation experience",
      "Strong writing and editing skills",
      "Video editing proficiency",
      "Knowledge of poker preferred",
    ],
    responsibilities: [
      "Create social media content",
      "Write articles and blog posts",
      "Produce video content",
      "Manage content calendar",
    ],
    createdAt: "2025-01-03T00:00:00Z",
  },
  {
    id: "5",
    title: "Software Developer",
    department: "Technology",
    location: "Kuala Lumpur, Malaysia",
    type: "FULL_TIME",
    description:
      "Build and maintain tournament management systems and player-facing applications.",
    requirements: [
      "3+ years software development experience",
      "Proficiency in React, Node.js, TypeScript",
      "Experience with databases (PostgreSQL)",
      "Problem-solving skills",
    ],
    responsibilities: [
      "Develop web and mobile applications",
      "Maintain existing systems",
      "Collaborate with product team",
      "Write clean, maintainable code",
    ],
    createdAt: "2025-01-01T00:00:00Z",
  },
  {
    id: "6",
    title: "Customer Service Representative",
    department: "Support",
    location: "Kuala Lumpur, Malaysia",
    type: "FULL_TIME",
    description:
      "Provide excellent customer support to players via email, chat, and phone.",
    requirements: [
      "1+ years customer service experience",
      "Excellent communication skills",
      "Fluent in English and Mandarin",
      "Problem-solving abilities",
    ],
    responsibilities: [
      "Respond to customer inquiries",
      "Resolve player issues",
      "Process registrations",
      "Maintain customer records",
    ],
    createdAt: "2024-12-28T00:00:00Z",
  },
  {
    id: "7",
    title: "Event Coordinator Intern",
    department: "Operations",
    location: "Genting Highlands, Malaysia",
    type: "INTERNSHIP",
    description:
      "Support the events team in organizing and executing poker tournaments.",
    requirements: [
      "Currently pursuing degree in related field",
      "Strong organizational skills",
      "Interest in gaming industry",
      "Available for 3-6 months",
    ],
    responsibilities: [
      "Assist with event setup",
      "Support registration process",
      "Help coordinate logistics",
      "Administrative tasks",
    ],
    createdAt: "2024-12-25T00:00:00Z",
  },
];

const jobTypeLabels: Record<JobType, string> = {
  FULL_TIME: "Full Time",
  PART_TIME: "Part Time",
  CONTRACT: "Contract",
  INTERNSHIP: "Internship",
};

const jobTypeBadgeVariant: Record<JobType, "primary" | "success" | "warning" | "gold"> = {
  FULL_TIME: "primary",
  PART_TIME: "success",
  CONTRACT: "warning",
  INTERNSHIP: "gold",
};

export default function CareersPage() {
  return (
    <div className="pt-20">
      {/* Hero Section */}
      <section className="relative py-20 overflow-hidden">
        <div className="absolute inset-0 z-0">
          <div
            className="absolute inset-0 bg-cover bg-center"
            style={{
              backgroundImage:
                "url('https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=1920')",
            }}
          />
          <div className="absolute inset-0 bg-black/70" />
        </div>
        <div className="container relative z-10">
          <div className="max-w-3xl">
            <span className="inline-block px-4 py-2 mb-6 text-sm font-semibold text-[var(--gold)] bg-[var(--gold)]/10 rounded-full border border-[var(--gold)]/30">
              Join Our Team
            </span>
            <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold mb-6">
              Build Your Career at Poker Dream
            </h1>
            <p className="text-xl text-[var(--foreground-secondary)]">
              Join Asia&apos;s premier poker tournament organization and be part
              of creating unforgettable experiences for players worldwide.
            </p>
          </div>
        </div>
      </section>

      {/* Benefits Section */}
      <section className="py-16 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="text-center mb-12">
            <h2 className="text-3xl font-bold">Why Work With Us</h2>
          </div>
          <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
            {benefits.map((benefit) => (
              <div
                key={benefit.title}
                className="bg-[var(--surface)] rounded-xl p-6 border border-[var(--border)] text-center"
              >
                <div className="w-14 h-14 rounded-full bg-[var(--primary)]/10 flex items-center justify-center mx-auto mb-4">
                  <benefit.icon className="w-7 h-7 text-[var(--primary)]" />
                </div>
                <h3 className="font-bold mb-2">{benefit.title}</h3>
                <p className="text-sm text-[var(--foreground-secondary)]">
                  {benefit.description}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Job Listings Section */}
      <section className="py-20">
        <div className="container">
          <div className="text-center mb-12">
            <span className="text-[var(--primary)] font-semibold text-sm uppercase tracking-wider">
              Open Positions
            </span>
            <h2 className="text-3xl md:text-4xl font-bold mt-2">
              Current Opportunities
            </h2>
            <p className="text-[var(--foreground-secondary)] mt-4 max-w-2xl mx-auto">
              We&apos;re looking for talented individuals to join our growing
              team. Explore our open positions below.
            </p>
          </div>

          <div className="space-y-4">
            {jobListings.map((job) => (
              <div
                key={job.id}
                className="bg-[var(--surface)] rounded-xl p-6 border border-[var(--border)] hover:border-[var(--primary)]/50 transition-colors"
              >
                <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                  <div className="flex-1">
                    <div className="flex items-center gap-3 mb-2">
                      <h3 className="text-xl font-bold">{job.title}</h3>
                      <Badge variant={jobTypeBadgeVariant[job.type]} size="sm">
                        {jobTypeLabels[job.type]}
                      </Badge>
                    </div>
                    <p className="text-[var(--foreground-secondary)] mb-3">
                      {job.description}
                    </p>
                    <div className="flex flex-wrap gap-4 text-sm text-[var(--foreground-muted)]">
                      <div className="flex items-center gap-1">
                        <Briefcase className="w-4 h-4" />
                        <span>{job.department}</span>
                      </div>
                      <div className="flex items-center gap-1">
                        <MapPin className="w-4 h-4" />
                        <span>{job.location}</span>
                      </div>
                    </div>
                  </div>
                  <div>
                    <Link href={`/careers/${job.id}`}>
                      <Button variant="outline">
                        View Details
                        <ChevronRight className="w-4 h-4 ml-2" />
                      </Button>
                    </Link>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="max-w-3xl mx-auto text-center">
            <h2 className="text-3xl md:text-4xl font-bold mb-4">
              Don&apos;t See the Right Fit?
            </h2>
            <p className="text-[var(--foreground-secondary)] mb-8">
              We&apos;re always looking for talented individuals. Send us your
              resume and we&apos;ll keep you in mind for future opportunities.
            </p>
            <Link href="/contact">
              <Button size="lg">
                Send Your Resume
                <ChevronRight className="w-5 h-5 ml-2" />
              </Button>
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}

import { Metadata } from "next";
import Image from "next/image";
import { Trophy, Users, Calendar, Globe, Target, Heart } from "lucide-react";

export const metadata: Metadata = {
  title: "About Us",
  description:
    "Learn about Poker Dream - Asia's premier poker tournament series bringing world-class poker events to Malaysia.",
};

const stats = [
  { icon: Trophy, label: "Tournaments Hosted", value: "200+" },
  { icon: Users, label: "Players Worldwide", value: "10,000+" },
  { icon: Calendar, label: "Years of Excellence", value: "8+" },
  { icon: Globe, label: "Countries Represented", value: "50+" },
];

const values = [
  {
    icon: Target,
    title: "Excellence",
    description:
      "We strive to deliver world-class poker experiences that meet the highest international standards.",
  },
  {
    icon: Users,
    title: "Community",
    description:
      "Building a vibrant poker community where players of all levels can compete, learn, and grow together.",
  },
  {
    icon: Heart,
    title: "Integrity",
    description:
      "Maintaining the highest standards of fairness and transparency in all our tournaments and operations.",
  },
];

const team = [
  {
    name: "David Tan",
    role: "Founder & CEO",
    image: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400",
    bio: "20+ years in gaming industry",
  },
  {
    name: "Sarah Lee",
    role: "Tournament Director",
    image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400",
    bio: "Former WSOP Tournament Director",
  },
  {
    name: "Michael Wong",
    role: "Head of Operations",
    image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
    bio: "15+ years hospitality management",
  },
  {
    name: "Jennifer Lim",
    role: "Marketing Director",
    image: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400",
    bio: "Expert in gaming marketing",
  },
];

export default function AboutPage() {
  return (
    <div className="pt-20">
      {/* Hero Section */}
      <section className="relative py-20 overflow-hidden">
        <div className="absolute inset-0 z-0">
          <div
            className="absolute inset-0 bg-cover bg-center"
            style={{
              backgroundImage:
                "url('https://images.unsplash.com/photo-1596838132731-3301c3fd4317?w=1920')",
            }}
          />
          <div className="absolute inset-0 bg-black/70" />
        </div>
        <div className="container relative z-10">
          <div className="max-w-3xl">
            <span className="inline-block px-4 py-2 mb-6 text-sm font-semibold text-[var(--gold)] bg-[var(--gold)]/10 rounded-full border border-[var(--gold)]/30">
              About Poker Dream
            </span>
            <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold mb-6">
              Asia&apos;s Premier Poker Tournament Series
            </h1>
            <p className="text-xl text-[var(--foreground-secondary)]">
              Since 2016, Poker Dream has been at the forefront of bringing
              world-class poker tournaments to Asia, creating unforgettable
              experiences for players from around the globe.
            </p>
          </div>
        </div>
      </section>

      {/* Stats Section */}
      <section className="py-16 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
            {stats.map((stat) => (
              <div key={stat.label} className="text-center">
                <stat.icon className="w-10 h-10 mx-auto mb-4 text-[var(--primary)]" />
                <p className="text-3xl md:text-4xl font-bold text-[var(--gold)] mb-2">
                  {stat.value}
                </p>
                <p className="text-[var(--foreground-secondary)]">{stat.label}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Story Section */}
      <section className="py-20">
        <div className="container">
          <div className="grid lg:grid-cols-2 gap-12 items-center">
            <div>
              <span className="text-[var(--primary)] font-semibold text-sm uppercase tracking-wider">
                Our Story
              </span>
              <h2 className="text-3xl md:text-4xl font-bold mt-2 mb-6">
                Building the Future of Poker in Asia
              </h2>
              <div className="space-y-4 text-[var(--foreground-secondary)]">
                <p>
                  Founded in 2016 at Resorts World Genting, Poker Dream began
                  with a simple vision: to create a world-class poker destination
                  in the heart of Asia. What started as a small series of
                  tournaments has grown into one of the region&apos;s most
                  prestigious poker events.
                </p>
                <p>
                  Over the years, we&apos;ve hosted thousands of players from
                  over 50 countries, distributed millions in prize money, and
                  created countless memorable moments at the felt. Our commitment
                  to excellence has made Poker Dream synonymous with quality poker
                  in Asia.
                </p>
                <p>
                  Today, Poker Dream continues to push boundaries, introducing
                  innovative tournament formats, state-of-the-art facilities, and
                  unforgettable experiences for players of all levels.
                </p>
              </div>
            </div>
            <div className="relative">
              <div className="aspect-square rounded-2xl overflow-hidden">
                <img
                  src="https://images.unsplash.com/photo-1511193311914-0346f16efe90?w=800"
                  alt="Poker Dream Event"
                  className="w-full h-full object-cover"
                />
              </div>
              <div className="absolute -bottom-6 -left-6 bg-[var(--primary)] rounded-2xl p-6 shadow-xl">
                <p className="text-4xl font-bold text-white">2016</p>
                <p className="text-white/80">Founded</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Values Section */}
      <section className="py-20 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="text-center mb-12">
            <span className="text-[var(--primary)] font-semibold text-sm uppercase tracking-wider">
              Our Values
            </span>
            <h2 className="text-3xl md:text-4xl font-bold mt-2">
              What Drives Us
            </h2>
          </div>
          <div className="grid md:grid-cols-3 gap-8">
            {values.map((value) => (
              <div
                key={value.title}
                className="bg-[var(--surface)] rounded-xl p-8 border border-[var(--border)]"
              >
                <div className="w-14 h-14 rounded-lg bg-[var(--primary)]/10 flex items-center justify-center mb-6">
                  <value.icon className="w-7 h-7 text-[var(--primary)]" />
                </div>
                <h3 className="text-xl font-bold mb-3">{value.title}</h3>
                <p className="text-[var(--foreground-secondary)]">
                  {value.description}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Team Section */}
      <section className="py-20">
        <div className="container">
          <div className="text-center mb-12">
            <span className="text-[var(--primary)] font-semibold text-sm uppercase tracking-wider">
              Leadership Team
            </span>
            <h2 className="text-3xl md:text-4xl font-bold mt-2">
              Meet Our Team
            </h2>
          </div>
          <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
            {team.map((member) => (
              <div key={member.name} className="text-center">
                <div className="relative w-48 h-48 mx-auto mb-4 rounded-full overflow-hidden">
                  <img
                    src={member.image}
                    alt={member.name}
                    className="w-full h-full object-cover"
                  />
                </div>
                <h3 className="text-xl font-bold">{member.name}</h3>
                <p className="text-[var(--primary)] font-medium mb-2">
                  {member.role}
                </p>
                <p className="text-sm text-[var(--foreground-muted)]">
                  {member.bio}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Partners Section */}
      <section className="py-20 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="text-center mb-12">
            <span className="text-[var(--primary)] font-semibold text-sm uppercase tracking-wider">
              Our Partners
            </span>
            <h2 className="text-3xl md:text-4xl font-bold mt-2">
              Trusted by Industry Leaders
            </h2>
          </div>
          <div className="flex flex-wrap justify-center items-center gap-12">
            {["Partner 1", "Partner 2", "Partner 3", "Partner 4", "Partner 5"].map(
              (partner) => (
                <div
                  key={partner}
                  className="w-40 h-16 bg-[var(--surface)] rounded-lg flex items-center justify-center text-[var(--foreground-muted)]"
                >
                  {partner}
                </div>
              )
            )}
          </div>
        </div>
      </section>
    </div>
  );
}

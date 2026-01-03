"use client";

import Link from "next/link";
import { motion } from "framer-motion";
import { Play, Calendar, Trophy } from "lucide-react";
import { Button } from "@/components/ui/button";

export function HeroSection() {
  return (
    <section className="relative min-h-screen flex items-center justify-center overflow-hidden">
      {/* Background Image with Overlay */}
      <div className="absolute inset-0 z-0">
        <div
          className="absolute inset-0 bg-cover bg-center"
          style={{
            backgroundImage:
              "url('https://images.unsplash.com/photo-1511193311914-0346f16efe90?q=80&w=2073')",
          }}
        />
        <div className="absolute inset-0 bg-gradient-to-b from-black/70 via-black/50 to-[var(--background)]" />
        <div className="absolute inset-0 bg-gradient-to-r from-black/50 to-transparent" />
      </div>

      {/* Content */}
      <div className="container relative z-10 pt-20">
        <div className="max-w-3xl">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
          >
            <span className="inline-block px-4 py-2 mb-6 text-sm font-semibold text-[var(--gold)] bg-[var(--gold)]/10 rounded-full border border-[var(--gold)]/30">
              Asia&apos;s Premier Poker Tournament Series
            </span>
          </motion.div>

          <motion.h1
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.1 }}
            className="text-4xl md:text-6xl lg:text-7xl font-bold mb-6 leading-tight"
          >
            Where{" "}
            <span className="text-gradient-primary">Champions</span>
            <br />
            Are Made
          </motion.h1>

          <motion.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            className="text-lg md:text-xl text-[var(--foreground-secondary)] mb-8 max-w-xl"
          >
            Join thousands of players from around the world competing for glory
            and life-changing prizes at Malaysia&apos;s most prestigious poker
            events.
          </motion.p>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.3 }}
            className="flex flex-wrap gap-4"
          >
            <Link href="/tournaments">
              <Button size="lg">
                <Calendar className="w-5 h-5 mr-2" />
                View Tournaments
              </Button>
            </Link>
            <Link href="/dpoy">
              <Button variant="outline" size="lg">
                <Trophy className="w-5 h-5 mr-2" />
                DPOY Rankings
              </Button>
            </Link>
          </motion.div>

          {/* Stats */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.4 }}
            className="grid grid-cols-3 gap-8 mt-16 pt-8 border-t border-white/10"
          >
            <div>
              <p className="text-3xl md:text-4xl font-bold text-[var(--gold)]">
                50+
              </p>
              <p className="text-sm text-[var(--foreground-secondary)]">
                Events Per Year
              </p>
            </div>
            <div>
              <p className="text-3xl md:text-4xl font-bold text-[var(--gold)]">
                RM 50M+
              </p>
              <p className="text-sm text-[var(--foreground-secondary)]">
                Total Prize Pool
              </p>
            </div>
            <div>
              <p className="text-3xl md:text-4xl font-bold text-[var(--gold)]">
                10K+
              </p>
              <p className="text-sm text-[var(--foreground-secondary)]">
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
        className="absolute bottom-8 left-1/2 -translate-x-1/2"
      >
        <div className="w-6 h-10 border-2 border-white/30 rounded-full flex justify-center">
          <motion.div
            animate={{ y: [0, 12, 0] }}
            transition={{ duration: 1.5, repeat: Infinity }}
            className="w-1.5 h-3 bg-white/50 rounded-full mt-2"
          />
        </div>
      </motion.div>
    </section>
  );
}

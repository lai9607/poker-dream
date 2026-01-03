"use client";

import Link from "next/link";
import { motion } from "framer-motion";
import { ArrowRight, Download, Smartphone } from "lucide-react";
import { Button } from "@/components/ui/button";

export function CTASection() {
  return (
    <section className="py-20 bg-[var(--background)]">
      <div className="container">
        <div className="relative overflow-hidden rounded-3xl bg-gradient-to-r from-[var(--primary)] to-[var(--primary-dark)] p-8 md:p-16">
          {/* Background Pattern */}
          <div className="absolute inset-0 opacity-10">
            <div
              className="absolute inset-0"
              style={{
                backgroundImage: `url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.4'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E")`,
              }}
            />
          </div>

          <div className="relative z-10 flex flex-col lg:flex-row items-center gap-8">
            {/* Content */}
            <div className="flex-1 text-center lg:text-left">
              <motion.h2
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                className="text-3xl md:text-4xl lg:text-5xl font-bold text-white mb-4"
              >
                Download the Poker Dream App
              </motion.h2>
              <motion.p
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ delay: 0.1 }}
                className="text-white/80 text-lg max-w-xl mx-auto lg:mx-0 mb-8"
              >
                Get real-time tournament updates, live standings, player
                rankings, and exclusive content right on your phone.
              </motion.p>

              <motion.div
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ delay: 0.2 }}
                className="flex flex-col sm:flex-row gap-4 justify-center lg:justify-start"
              >
                <Button variant="gold" size="lg">
                  <Download className="w-5 h-5 mr-2" />
                  Download for iOS
                </Button>
                <Button
                  variant="outline"
                  size="lg"
                  className="border-white text-white hover:bg-white hover:text-[var(--primary)]"
                >
                  <Download className="w-5 h-5 mr-2" />
                  Download for Android
                </Button>
              </motion.div>
            </div>

            {/* Phone Mockup */}
            <motion.div
              initial={{ opacity: 0, x: 50 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.3 }}
              className="flex-shrink-0 hidden lg:block"
            >
              <div className="relative">
                <div className="w-64 h-[500px] bg-black rounded-[3rem] p-3 shadow-2xl">
                  <div className="w-full h-full bg-[var(--background)] rounded-[2.5rem] overflow-hidden">
                    <div className="h-8 bg-[var(--surface)] flex items-center justify-center">
                      <div className="w-20 h-5 bg-black rounded-full" />
                    </div>
                    <div className="p-4">
                      <div className="flex items-center gap-2 mb-4">
                        <div className="w-10 h-10 bg-[var(--primary)] rounded-lg flex items-center justify-center">
                          <span className="text-white font-bold text-sm">PD</span>
                        </div>
                        <div>
                          <p className="text-sm font-bold">Poker Dream</p>
                          <p className="text-xs text-[var(--foreground-muted)]">
                            Tournament Tracker
                          </p>
                        </div>
                      </div>
                      <div className="space-y-3">
                        {[1, 2, 3].map((i) => (
                          <div
                            key={i}
                            className="bg-[var(--surface)] rounded-lg p-3"
                          >
                            <div className="h-3 bg-[var(--border)] rounded w-3/4 mb-2" />
                            <div className="h-2 bg-[var(--border)] rounded w-1/2" />
                          </div>
                        ))}
                      </div>
                    </div>
                  </div>
                </div>
                {/* Floating Elements */}
                <div className="absolute -top-4 -right-4 bg-[var(--gold)] text-black px-4 py-2 rounded-full text-sm font-bold shadow-lg">
                  FREE
                </div>
              </div>
            </motion.div>
          </div>
        </div>
      </div>
    </section>
  );
}

"use client";

import Link from "next/link";
import {
  Facebook,
  Instagram,
  Twitter,
  Youtube,
  Mail,
  Phone,
  MapPin,
} from "lucide-react";
import { footerNavigation, siteConfig } from "@/config/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

export function Footer() {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="bg-[var(--background-secondary)] border-t border-[var(--border)]">
      {/* Newsletter Section */}
      <div className="border-b border-[var(--border)]">
        <div className="container py-12">
          <div className="max-w-2xl mx-auto text-center">
            <h3 className="text-2xl font-bold mb-2">Stay Updated</h3>
            <p className="text-[var(--foreground-secondary)] mb-6">
              Subscribe to our newsletter for the latest tournament updates,
              exclusive promotions, and poker news.
            </p>
            <form className="flex flex-col sm:flex-row gap-3 max-w-md mx-auto">
              <Input
                type="email"
                placeholder="Enter your email"
                className="flex-1"
              />
              <Button type="submit">Subscribe</Button>
            </form>
          </div>
        </div>
      </div>

      {/* Main Footer Content */}
      <div className="container py-12">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          {/* Brand Column */}
          <div className="lg:col-span-1">
            <Link href="/" className="flex items-center gap-2 mb-4">
              <div className="w-10 h-10 bg-gradient-primary rounded-lg flex items-center justify-center">
                <span className="text-white font-bold text-xl">PD</span>
              </div>
              <span className="text-xl font-bold text-white">
                {siteConfig.name}
              </span>
            </Link>
            <p className="text-[var(--foreground-secondary)] text-sm mb-4">
              {siteConfig.description}. Join thousands of players competing for
              glory and life-changing prizes.
            </p>
            {/* Social Links */}
            <div className="flex gap-3">
              {footerNavigation.social.map((item) => (
                <a
                  key={item.label}
                  href={item.href}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="w-10 h-10 rounded-full bg-[var(--surface)] flex items-center justify-center text-[var(--foreground-secondary)] hover:bg-[var(--primary)] hover:text-white transition-colors"
                  aria-label={item.label}
                >
                  {item.icon === "facebook" && <Facebook className="w-5 h-5" />}
                  {item.icon === "instagram" && <Instagram className="w-5 h-5" />}
                  {item.icon === "twitter" && <Twitter className="w-5 h-5" />}
                  {item.icon === "youtube" && <Youtube className="w-5 h-5" />}
                </a>
              ))}
            </div>
          </div>

          {/* Company Links */}
          <div>
            <h4 className="font-semibold mb-4">Company</h4>
            <ul className="space-y-3">
              {footerNavigation.company.map((item) => (
                <li key={item.label}>
                  <Link
                    href={item.href}
                    className="text-[var(--foreground-secondary)] hover:text-white text-sm transition-colors"
                  >
                    {item.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Legal Links */}
          <div>
            <h4 className="font-semibold mb-4">Legal</h4>
            <ul className="space-y-3">
              {footerNavigation.legal.map((item) => (
                <li key={item.label}>
                  <Link
                    href={item.href}
                    className="text-[var(--foreground-secondary)] hover:text-white text-sm transition-colors"
                  >
                    {item.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Contact Info */}
          <div>
            <h4 className="font-semibold mb-4">Contact Us</h4>
            <ul className="space-y-3">
              <li>
                <a
                  href={`mailto:${siteConfig.email}`}
                  className="flex items-center gap-2 text-[var(--foreground-secondary)] hover:text-white text-sm transition-colors"
                >
                  <Mail className="w-4 h-4" />
                  {siteConfig.email}
                </a>
              </li>
              <li>
                <a
                  href={`tel:${siteConfig.phone}`}
                  className="flex items-center gap-2 text-[var(--foreground-secondary)] hover:text-white text-sm transition-colors"
                >
                  <Phone className="w-4 h-4" />
                  {siteConfig.phone}
                </a>
              </li>
              <li>
                <div className="flex items-start gap-2 text-[var(--foreground-secondary)] text-sm">
                  <MapPin className="w-4 h-4 mt-0.5 flex-shrink-0" />
                  <span>
                    {siteConfig.address.line1}
                    <br />
                    {siteConfig.address.line2}
                    <br />
                    {siteConfig.address.city}, {siteConfig.address.country}
                  </span>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </div>

      {/* Bottom Bar */}
      <div className="border-t border-[var(--border)]">
        <div className="container py-6">
          <div className="flex flex-col md:flex-row justify-between items-center gap-4">
            <p className="text-[var(--foreground-muted)] text-sm">
              © {currentYear} {siteConfig.name}. All rights reserved.
            </p>
            <p className="text-[var(--foreground-muted)] text-sm">
              Play Responsibly. 21+ Only.
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
}

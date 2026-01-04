"use client";

import Link from "next/link";
import {
  Facebook,
  Instagram,
  Twitter,
  Youtube,
} from "lucide-react";
import { siteConfig } from "@/config/navigation";

export function Footer() {
  const currentYear = new Date().getFullYear();

  const navLinks = [
    { label: "Tournaments", href: "/tournaments" },
    { label: "DPOY", href: "/dpoy" },
    { label: "News", href: "/news" },
    { label: "About", href: "/about" },
    { label: "Contact", href: "/contact" },
  ];

  const socialLinks = [
    { icon: Facebook, href: "https://facebook.com/pokerdream", label: "Facebook" },
    { icon: Instagram, href: "https://instagram.com/pokerdream", label: "Instagram" },
    { icon: Twitter, href: "https://twitter.com/pokerdream", label: "Twitter" },
    { icon: Youtube, href: "https://youtube.com/pokerdream", label: "YouTube" },
  ];

  return (
    <footer
      style={{
        background: "#121212",
        borderTop: "1px solid #333",
      }}
    >
      {/* Main Row */}
      <div className="container">
        <div
          style={{
            padding: "40px 0",
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
            flexWrap: "wrap",
            gap: "24px",
          }}
        >
          {/* Brand Section */}
          <div
            style={{
              display: "flex",
              alignItems: "center",
              gap: "24px",
            }}
          >
            <Link
              href="/"
              style={{
                display: "flex",
                alignItems: "center",
                gap: "10px",
                textDecoration: "none",
              }}
            >
              <div
                style={{
                  width: "40px",
                  height: "40px",
                  background: "linear-gradient(135deg, #E53935 0%, #C62828 100%)",
                  borderRadius: "10px",
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                }}
              >
                <span
                  style={{
                    color: "#fff",
                    fontWeight: 700,
                    fontSize: "18px",
                  }}
                >
                  PD
                </span>
              </div>
              <span
                style={{
                  fontSize: "20px",
                  fontWeight: 700,
                  color: "#fff",
                }}
              >
                {siteConfig.name}
              </span>
            </Link>

            {/* Divider */}
            <div
              style={{
                width: "1px",
                height: "40px",
                background: "#333",
              }}
              className="hidden md:block"
            />

            {/* Tagline */}
            <p
              style={{
                color: "#888",
                fontSize: "14px",
              }}
              className="hidden md:block"
            >
              {siteConfig.description}
            </p>
          </div>

          {/* Nav Links */}
          <nav
            style={{
              display: "flex",
              gap: "32px",
            }}
            className="hidden lg:flex"
          >
            {navLinks.map((link) => (
              <Link
                key={link.label}
                href={link.href}
                style={{
                  color: "#888",
                  textDecoration: "none",
                  fontSize: "14px",
                  transition: "color 0.2s",
                }}
                onMouseOver={(e) => (e.currentTarget.style.color = "#fff")}
                onMouseOut={(e) => (e.currentTarget.style.color = "#888")}
              >
                {link.label}
              </Link>
            ))}
          </nav>

          {/* Social Icons */}
          <div
            style={{
              display: "flex",
              gap: "8px",
            }}
          >
            {socialLinks.map((social) => (
              <a
                key={social.label}
                href={social.href}
                target="_blank"
                rel="noopener noreferrer"
                aria-label={social.label}
                style={{
                  width: "36px",
                  height: "36px",
                  borderRadius: "50%",
                  background: "#1E1E1E",
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  color: "#888",
                  textDecoration: "none",
                  transition: "all 0.2s",
                }}
                onMouseOver={(e) => {
                  e.currentTarget.style.background = "#E53935";
                  e.currentTarget.style.color = "#fff";
                }}
                onMouseOut={(e) => {
                  e.currentTarget.style.background = "#1E1E1E";
                  e.currentTarget.style.color = "#888";
                }}
              >
                <social.icon style={{ width: "18px", height: "18px" }} />
              </a>
            ))}
          </div>
        </div>
      </div>

      {/* Bottom Bar */}
      <div style={{ borderTop: "1px solid #333" }}>
        <div className="container">
          <div
            style={{
              padding: "16px 0",
              display: "flex",
              justifyContent: "space-between",
              alignItems: "center",
              flexWrap: "wrap",
              gap: "16px",
            }}
          >
            <p style={{ color: "#666", fontSize: "13px" }}>
              &copy; {currentYear} {siteConfig.name}. All rights reserved. Play Responsibly. 21+ Only.
            </p>
            <div style={{ display: "flex", gap: "24px" }}>
              <Link
                href="/privacy"
                style={{
                  color: "#666",
                  textDecoration: "none",
                  fontSize: "13px",
                  transition: "color 0.2s",
                }}
                onMouseOver={(e) => (e.currentTarget.style.color = "#fff")}
                onMouseOut={(e) => (e.currentTarget.style.color = "#666")}
              >
                Privacy
              </Link>
              <Link
                href="/terms"
                style={{
                  color: "#666",
                  textDecoration: "none",
                  fontSize: "13px",
                  transition: "color 0.2s",
                }}
                onMouseOver={(e) => (e.currentTarget.style.color = "#fff")}
                onMouseOut={(e) => (e.currentTarget.style.color = "#666")}
              >
                Terms
              </Link>
            </div>
          </div>
        </div>
      </div>
    </footer>
  );
}

"use client";

import { useState, useEffect } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { Menu, X, ChevronDown } from "lucide-react";
import { mainNavigation, siteConfig } from "@/config/navigation";

export function Header() {
  const [isScrolled, setIsScrolled] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [openDropdown, setOpenDropdown] = useState<string | null>(null);
  const pathname = usePathname();

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 10);
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  useEffect(() => {
    setIsMobileMenuOpen(false);
    setOpenDropdown(null);
  }, [pathname]);

  return (
    <header
      style={{
        position: "fixed",
        top: 0,
        left: 0,
        right: 0,
        zIndex: 50,
        transition: "all 0.3s ease",
        background: isScrolled
          ? "rgba(10, 10, 10, 0.95)"
          : "transparent",
        backdropFilter: isScrolled ? "blur(12px)" : "none",
        boxShadow: isScrolled ? "0 4px 20px rgba(0,0,0,0.3)" : "none",
      }}
    >
      <div className="container">
        <nav
          style={{
            display: "flex",
            alignItems: "center",
            justifyContent: "space-between",
            height: "80px",
          }}
        >
          {/* Logo */}
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

          {/* Desktop Navigation */}
          <div
            style={{
              display: "flex",
              alignItems: "center",
              gap: "4px",
            }}
            className="hidden lg:flex"
          >
            {mainNavigation.map((item) => (
              <div key={item.label} style={{ position: "relative" }}>
                {item.children ? (
                  <div
                    style={{ position: "relative" }}
                    onMouseEnter={() => setOpenDropdown(item.label)}
                    onMouseLeave={() => setOpenDropdown(null)}
                  >
                    <button
                      style={{
                        display: "flex",
                        alignItems: "center",
                        gap: "4px",
                        padding: "8px 16px",
                        borderRadius: "8px",
                        fontSize: "14px",
                        fontWeight: 500,
                        color: pathname.startsWith(item.href)
                          ? "#E53935"
                          : "rgba(255,255,255,0.8)",
                        background: "transparent",
                        border: "none",
                        cursor: "pointer",
                        transition: "color 0.2s",
                      }}
                    >
                      {item.label}
                      <ChevronDown style={{ width: "16px", height: "16px" }} />
                    </button>
                    {openDropdown === item.label && (
                      <div
                        style={{
                          position: "absolute",
                          top: "100%",
                          left: 0,
                          marginTop: "4px",
                          padding: "8px 0",
                          width: "200px",
                          background: "#1E1E1E",
                          borderRadius: "12px",
                          boxShadow: "0 10px 40px rgba(0,0,0,0.5)",
                          border: "1px solid #333",
                        }}
                      >
                        {item.children.map((child) => (
                          <Link
                            key={child.label}
                            href={child.href}
                            style={{
                              display: "block",
                              padding: "10px 16px",
                              fontSize: "14px",
                              color:
                                pathname === child.href
                                  ? "#E53935"
                                  : "rgba(255,255,255,0.7)",
                              textDecoration: "none",
                              transition: "all 0.2s",
                            }}
                          >
                            {child.label}
                          </Link>
                        ))}
                      </div>
                    )}
                  </div>
                ) : (
                  <Link
                    href={item.href}
                    style={{
                      padding: "8px 16px",
                      borderRadius: "8px",
                      fontSize: "14px",
                      fontWeight: 500,
                      color:
                        pathname === item.href
                          ? "#E53935"
                          : "rgba(255,255,255,0.8)",
                      textDecoration: "none",
                      transition: "color 0.2s",
                    }}
                  >
                    {item.label}
                  </Link>
                )}
              </div>
            ))}
          </div>

          {/* CTA Buttons */}
          <div
            style={{
              display: "flex",
              alignItems: "center",
              gap: "12px",
            }}
            className="hidden lg:flex"
          >
            <button
              style={{
                padding: "10px 20px",
                fontSize: "14px",
                fontWeight: 600,
                color: "#fff",
                background: "transparent",
                border: "1px solid rgba(255,255,255,0.3)",
                borderRadius: "8px",
                cursor: "pointer",
                transition: "all 0.2s",
              }}
            >
              Download App
            </button>
            <button
              style={{
                padding: "10px 20px",
                fontSize: "14px",
                fontWeight: 600,
                color: "#fff",
                background: "linear-gradient(135deg, #E53935 0%, #C62828 100%)",
                border: "none",
                borderRadius: "8px",
                cursor: "pointer",
                transition: "all 0.2s",
              }}
            >
              Register Now
            </button>
          </div>

          {/* Mobile Menu Button */}
          <button
            style={{
              padding: "8px",
              color: "#fff",
              background: "transparent",
              border: "none",
              cursor: "pointer",
            }}
            className="lg:hidden"
            onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
            aria-label="Toggle menu"
          >
            {isMobileMenuOpen ? (
              <X style={{ width: "24px", height: "24px" }} />
            ) : (
              <Menu style={{ width: "24px", height: "24px" }} />
            )}
          </button>
        </nav>
      </div>

      {/* Mobile Menu */}
      {isMobileMenuOpen && (
        <div
          style={{
            background: "#0A0A0A",
            borderTop: "1px solid #333",
          }}
          className="lg:hidden"
        >
          <div className="container" style={{ padding: "16px" }}>
            {mainNavigation.map((item) => (
              <div key={item.label}>
                {item.children ? (
                  <div>
                    <button
                      onClick={() =>
                        setOpenDropdown(
                          openDropdown === item.label ? null : item.label
                        )
                      }
                      style={{
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "space-between",
                        width: "100%",
                        padding: "12px 16px",
                        color: "rgba(255,255,255,0.7)",
                        background: "transparent",
                        border: "none",
                        cursor: "pointer",
                        fontSize: "16px",
                      }}
                    >
                      {item.label}
                      <ChevronDown
                        style={{
                          width: "16px",
                          height: "16px",
                          transform:
                            openDropdown === item.label
                              ? "rotate(180deg)"
                              : "rotate(0deg)",
                          transition: "transform 0.2s",
                        }}
                      />
                    </button>
                    {openDropdown === item.label && (
                      <div style={{ paddingLeft: "16px" }}>
                        {item.children.map((child) => (
                          <Link
                            key={child.label}
                            href={child.href}
                            style={{
                              display: "block",
                              padding: "8px 16px",
                              fontSize: "14px",
                              color: "rgba(255,255,255,0.5)",
                              textDecoration: "none",
                            }}
                          >
                            {child.label}
                          </Link>
                        ))}
                      </div>
                    )}
                  </div>
                ) : (
                  <Link
                    href={item.href}
                    style={{
                      display: "block",
                      padding: "12px 16px",
                      color:
                        pathname === item.href
                          ? "#E53935"
                          : "rgba(255,255,255,0.7)",
                      textDecoration: "none",
                      fontSize: "16px",
                    }}
                  >
                    {item.label}
                  </Link>
                )}
              </div>
            ))}
            <div style={{ paddingTop: "16px", display: "flex", flexDirection: "column", gap: "8px" }}>
              <button
                style={{
                  width: "100%",
                  padding: "12px 20px",
                  fontSize: "14px",
                  fontWeight: 600,
                  color: "#fff",
                  background: "transparent",
                  border: "1px solid rgba(255,255,255,0.3)",
                  borderRadius: "8px",
                  cursor: "pointer",
                }}
              >
                Download App
              </button>
              <button
                style={{
                  width: "100%",
                  padding: "12px 20px",
                  fontSize: "14px",
                  fontWeight: 600,
                  color: "#fff",
                  background: "linear-gradient(135deg, #E53935 0%, #C62828 100%)",
                  border: "none",
                  borderRadius: "8px",
                  cursor: "pointer",
                }}
              >
                Register Now
              </button>
            </div>
          </div>
        </div>
      )}
    </header>
  );
}

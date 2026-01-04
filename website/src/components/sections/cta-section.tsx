"use client";

import { motion } from "framer-motion";
import { Download } from "lucide-react";

export function CTASection() {
  return (
    <section
      style={{
        padding: "80px 0",
        background: "#0A0A0A",
      }}
    >
      <div className="container">
        <div
          style={{
            position: "relative",
            overflow: "hidden",
            borderRadius: "24px",
            background: "linear-gradient(135deg, #E53935 0%, #C62828 100%)",
            padding: "48px",
          }}
          className="md:p-16"
        >
          {/* Background Pattern */}
          <div
            style={{
              position: "absolute",
              inset: 0,
              opacity: 0.1,
              backgroundImage: `url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.4'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E")`,
            }}
          />

          <div
            style={{
              position: "relative",
              zIndex: 10,
              display: "flex",
              flexDirection: "column",
              alignItems: "center",
              gap: "32px",
            }}
            className="lg:flex-row"
          >
            {/* Content */}
            <div
              style={{
                flex: 1,
                textAlign: "center",
              }}
              className="lg:text-left"
            >
              <motion.h2
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                style={{
                  fontSize: "clamp(28px, 5vw, 48px)",
                  fontWeight: 700,
                  color: "#fff",
                  marginBottom: "16px",
                }}
              >
                Download the Poker Dream App
              </motion.h2>
              <motion.p
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ delay: 0.1 }}
                style={{
                  color: "rgba(255,255,255,0.8)",
                  fontSize: "18px",
                  maxWidth: "600px",
                  marginBottom: "32px",
                  lineHeight: 1.7,
                }}
                className="mx-auto lg:mx-0"
              >
                Get real-time tournament updates, live standings, player
                rankings, and exclusive content right on your phone.
              </motion.p>

              <motion.div
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ delay: 0.2 }}
                style={{
                  display: "flex",
                  flexDirection: "column",
                  gap: "16px",
                  justifyContent: "center",
                }}
                className="sm:flex-row lg:justify-start"
              >
                <button
                  style={{
                    display: "inline-flex",
                    alignItems: "center",
                    justifyContent: "center",
                    gap: "8px",
                    padding: "14px 28px",
                    fontSize: "16px",
                    fontWeight: 600,
                    color: "#000",
                    background: "linear-gradient(135deg, #FFD700 0%, #FFA500 100%)",
                    border: "none",
                    borderRadius: "8px",
                    cursor: "pointer",
                    transition: "transform 0.2s",
                  }}
                >
                  <Download style={{ width: "20px", height: "20px" }} />
                  Download for iOS
                </button>
                <button
                  style={{
                    display: "inline-flex",
                    alignItems: "center",
                    justifyContent: "center",
                    gap: "8px",
                    padding: "14px 28px",
                    fontSize: "16px",
                    fontWeight: 600,
                    color: "#fff",
                    background: "transparent",
                    border: "2px solid #fff",
                    borderRadius: "8px",
                    cursor: "pointer",
                    transition: "all 0.2s",
                  }}
                >
                  <Download style={{ width: "20px", height: "20px" }} />
                  Download for Android
                </button>
              </motion.div>
            </div>

            {/* Phone Mockup */}
            <motion.div
              initial={{ opacity: 0, x: 50 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.3 }}
              style={{ flexShrink: 0 }}
              className="hidden lg:block"
            >
              <div style={{ position: "relative" }}>
                <div
                  style={{
                    width: "256px",
                    height: "500px",
                    background: "#000",
                    borderRadius: "48px",
                    padding: "12px",
                    boxShadow: "0 25px 50px rgba(0,0,0,0.5)",
                  }}
                >
                  <div
                    style={{
                      width: "100%",
                      height: "100%",
                      background: "#121212",
                      borderRadius: "40px",
                      overflow: "hidden",
                    }}
                  >
                    <div
                      style={{
                        height: "32px",
                        background: "#1E1E1E",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "center",
                      }}
                    >
                      <div
                        style={{
                          width: "80px",
                          height: "20px",
                          background: "#000",
                          borderRadius: "9999px",
                        }}
                      />
                    </div>
                    <div style={{ padding: "16px" }}>
                      <div
                        style={{
                          display: "flex",
                          alignItems: "center",
                          gap: "8px",
                          marginBottom: "16px",
                        }}
                      >
                        <div
                          style={{
                            width: "40px",
                            height: "40px",
                            background: "#E53935",
                            borderRadius: "8px",
                            display: "flex",
                            alignItems: "center",
                            justifyContent: "center",
                          }}
                        >
                          <span
                            style={{
                              color: "#fff",
                              fontWeight: 700,
                              fontSize: "14px",
                            }}
                          >
                            PD
                          </span>
                        </div>
                        <div>
                          <p
                            style={{
                              fontSize: "14px",
                              fontWeight: 700,
                              color: "#fff",
                            }}
                          >
                            Poker Dream
                          </p>
                          <p style={{ fontSize: "12px", color: "#666" }}>
                            Tournament Tracker
                          </p>
                        </div>
                      </div>
                      <div
                        style={{
                          display: "flex",
                          flexDirection: "column",
                          gap: "12px",
                        }}
                      >
                        {[1, 2, 3].map((i) => (
                          <div
                            key={i}
                            style={{
                              background: "#1E1E1E",
                              borderRadius: "8px",
                              padding: "12px",
                            }}
                          >
                            <div
                              style={{
                                height: "12px",
                                background: "#333",
                                borderRadius: "4px",
                                width: "75%",
                                marginBottom: "8px",
                              }}
                            />
                            <div
                              style={{
                                height: "8px",
                                background: "#333",
                                borderRadius: "4px",
                                width: "50%",
                              }}
                            />
                          </div>
                        ))}
                      </div>
                    </div>
                  </div>
                </div>
                {/* Floating Elements */}
                <div
                  style={{
                    position: "absolute",
                    top: "-16px",
                    right: "-16px",
                    background: "#FFD700",
                    color: "#000",
                    padding: "8px 16px",
                    borderRadius: "9999px",
                    fontSize: "14px",
                    fontWeight: 700,
                    boxShadow: "0 4px 20px rgba(0,0,0,0.3)",
                  }}
                >
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

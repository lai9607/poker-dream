"use client";

import { forwardRef, HTMLAttributes, CSSProperties } from "react";
import { cn } from "@/lib/utils";

export interface CardProps extends HTMLAttributes<HTMLDivElement> {
  variant?: "default" | "bordered" | "elevated";
  hover?: boolean;
}

const Card = forwardRef<HTMLDivElement, CardProps>(
  ({ className, variant = "default", hover = false, style, children, ...props }, ref) => {
    const baseStyle: CSSProperties = {
      borderRadius: "12px",
      overflow: "hidden",
      background: "#1E1E1E",
      transition: hover ? "all 0.3s ease" : undefined,
      cursor: hover ? "pointer" : undefined,
    };

    const variantStyles: Record<string, CSSProperties> = {
      default: {},
      bordered: { border: "1px solid #333" },
      elevated: { boxShadow: "0 10px 40px rgba(0,0,0,0.3)" },
    };

    return (
      <div
        ref={ref}
        className={className}
        style={{ ...baseStyle, ...variantStyles[variant], ...style }}
        {...props}
      >
        {children}
      </div>
    );
  }
);

Card.displayName = "Card";

const CardHeader = forwardRef<HTMLDivElement, HTMLAttributes<HTMLDivElement>>(
  ({ className, style, ...props }, ref) => (
    <div
      ref={ref}
      className={className}
      style={{ padding: "24px", paddingBottom: 0, ...style }}
      {...props}
    />
  )
);

CardHeader.displayName = "CardHeader";

const CardContent = forwardRef<HTMLDivElement, HTMLAttributes<HTMLDivElement>>(
  ({ className, style, ...props }, ref) => (
    <div
      ref={ref}
      className={className}
      style={{ padding: "24px", ...style }}
      {...props}
    />
  )
);

CardContent.displayName = "CardContent";

const CardFooter = forwardRef<HTMLDivElement, HTMLAttributes<HTMLDivElement>>(
  ({ className, style, ...props }, ref) => (
    <div
      ref={ref}
      className={className}
      style={{
        padding: "24px",
        paddingTop: 0,
        display: "flex",
        alignItems: "center",
        ...style,
      }}
      {...props}
    />
  )
);

CardFooter.displayName = "CardFooter";

const CardImage = forwardRef<
  HTMLImageElement,
  React.ImgHTMLAttributes<HTMLImageElement> & { aspectRatio?: string }
>(({ className, aspectRatio = "16/9", alt = "", style, ...props }, ref) => (
  <div style={{ position: "relative", width: "100%", aspectRatio }}>
    <img
      ref={ref}
      style={{
        position: "absolute",
        inset: 0,
        width: "100%",
        height: "100%",
        objectFit: "cover",
        ...style,
      }}
      alt={alt}
      {...props}
    />
  </div>
));

CardImage.displayName = "CardImage";

export { Card, CardHeader, CardContent, CardFooter, CardImage };

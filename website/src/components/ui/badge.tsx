"use client";

import { forwardRef, HTMLAttributes } from "react";
import { cn } from "@/lib/utils";

export interface BadgeProps extends HTMLAttributes<HTMLSpanElement> {
  variant?: "default" | "primary" | "success" | "warning" | "error" | "gold" | "live";
  size?: "sm" | "md" | "lg";
}

const Badge = forwardRef<HTMLSpanElement, BadgeProps>(
  ({ className, variant = "default", size = "md", children, ...props }, ref) => {
    const baseStyles =
      "inline-flex items-center justify-center font-semibold rounded-full";

    const variants = {
      default: "bg-[var(--surface)] text-[var(--foreground-secondary)]",
      primary: "bg-[var(--primary)] text-white",
      success: "bg-[var(--success)] text-white",
      warning: "bg-[var(--warning)] text-black",
      error: "bg-[var(--error)] text-white",
      gold: "bg-[var(--gold)] text-black",
      live: "bg-[var(--error)] text-white animate-pulse",
    };

    const sizes = {
      sm: "px-2 py-0.5 text-xs",
      md: "px-3 py-1 text-sm",
      lg: "px-4 py-1.5 text-base",
    };

    return (
      <span
        ref={ref}
        className={cn(baseStyles, variants[variant], sizes[size], className)}
        {...props}
      >
        {variant === "live" && (
          <span className="w-2 h-2 bg-white rounded-full mr-1.5 animate-pulse" />
        )}
        {children}
      </span>
    );
  }
);

Badge.displayName = "Badge";

export { Badge };

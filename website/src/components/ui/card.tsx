"use client";

import { forwardRef, HTMLAttributes } from "react";
import { cn } from "@/lib/utils";

export interface CardProps extends HTMLAttributes<HTMLDivElement> {
  variant?: "default" | "bordered" | "elevated";
  hover?: boolean;
}

const Card = forwardRef<HTMLDivElement, CardProps>(
  ({ className, variant = "default", hover = false, children, ...props }, ref) => {
    const baseStyles = "rounded-xl overflow-hidden";

    const variants = {
      default: "bg-[var(--surface)]",
      bordered: "bg-[var(--surface)] border border-[var(--border)]",
      elevated: "bg-[var(--surface)] shadow-lg",
    };

    const hoverStyles = hover
      ? "transition-all duration-300 hover:transform hover:-translate-y-1 hover:shadow-xl cursor-pointer"
      : "";

    return (
      <div
        ref={ref}
        className={cn(baseStyles, variants[variant], hoverStyles, className)}
        {...props}
      >
        {children}
      </div>
    );
  }
);

Card.displayName = "Card";

const CardHeader = forwardRef<HTMLDivElement, HTMLAttributes<HTMLDivElement>>(
  ({ className, ...props }, ref) => (
    <div ref={ref} className={cn("p-6 pb-0", className)} {...props} />
  )
);

CardHeader.displayName = "CardHeader";

const CardContent = forwardRef<HTMLDivElement, HTMLAttributes<HTMLDivElement>>(
  ({ className, ...props }, ref) => (
    <div ref={ref} className={cn("p-6", className)} {...props} />
  )
);

CardContent.displayName = "CardContent";

const CardFooter = forwardRef<HTMLDivElement, HTMLAttributes<HTMLDivElement>>(
  ({ className, ...props }, ref) => (
    <div
      ref={ref}
      className={cn("p-6 pt-0 flex items-center", className)}
      {...props}
    />
  )
);

CardFooter.displayName = "CardFooter";

const CardImage = forwardRef<
  HTMLImageElement,
  React.ImgHTMLAttributes<HTMLImageElement> & { aspectRatio?: string }
>(({ className, aspectRatio = "16/9", alt = "", ...props }, ref) => (
  <div className="relative w-full" style={{ aspectRatio }}>
    <img
      ref={ref}
      className={cn("absolute inset-0 w-full h-full object-cover", className)}
      alt={alt}
      {...props}
    />
  </div>
));

CardImage.displayName = "CardImage";

export { Card, CardHeader, CardContent, CardFooter, CardImage };

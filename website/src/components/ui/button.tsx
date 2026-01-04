"use client";

import { forwardRef, ButtonHTMLAttributes, CSSProperties } from "react";

export interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: "primary" | "secondary" | "outline" | "ghost" | "gold";
  size?: "sm" | "md" | "lg";
  isLoading?: boolean;
}

const Button = forwardRef<HTMLButtonElement, ButtonProps>(
  (
    {
      className,
      variant = "primary",
      size = "md",
      isLoading = false,
      disabled,
      children,
      style,
      ...props
    },
    ref
  ) => {
    const baseStyles: CSSProperties = {
      display: "inline-flex",
      alignItems: "center",
      justifyContent: "center",
      fontWeight: 600,
      borderRadius: "8px",
      transition: "all 0.2s",
      cursor: disabled || isLoading ? "not-allowed" : "pointer",
      opacity: disabled || isLoading ? 0.5 : 1,
      border: "none",
    };

    const variantStyles: Record<string, CSSProperties> = {
      primary: {
        background: "linear-gradient(135deg, #E53935 0%, #C62828 100%)",
        color: "#fff",
      },
      secondary: {
        background: "#1E1E1E",
        color: "#fff",
      },
      outline: {
        background: "transparent",
        border: "2px solid #E53935",
        color: "#E53935",
      },
      ghost: {
        background: "transparent",
        color: "#888",
      },
      gold: {
        background: "linear-gradient(135deg, #FFD700 0%, #FFA500 100%)",
        color: "#000",
      },
    };

    const sizeStyles: Record<string, CSSProperties> = {
      sm: {
        padding: "8px 16px",
        fontSize: "14px",
      },
      md: {
        padding: "12px 24px",
        fontSize: "16px",
      },
      lg: {
        padding: "16px 32px",
        fontSize: "18px",
      },
    };

    const combinedStyles: CSSProperties = {
      ...baseStyles,
      ...variantStyles[variant],
      ...sizeStyles[size],
      ...style,
    };

    return (
      <button
        ref={ref}
        className={className}
        style={combinedStyles}
        disabled={disabled || isLoading}
        {...props}
      >
        {isLoading ? (
          <>
            <svg
              style={{
                animation: "spin 1s linear infinite",
                marginLeft: "-4px",
                marginRight: "8px",
                width: "16px",
                height: "16px",
              }}
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
            >
              <circle
                style={{ opacity: 0.25 }}
                cx="12"
                cy="12"
                r="10"
                stroke="currentColor"
                strokeWidth="4"
              />
              <path
                style={{ opacity: 0.75 }}
                fill="currentColor"
                d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
              />
            </svg>
            Loading...
          </>
        ) : (
          children
        )}
      </button>
    );
  }
);

Button.displayName = "Button";

export { Button };

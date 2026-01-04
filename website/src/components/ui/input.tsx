"use client";

import { forwardRef, InputHTMLAttributes, CSSProperties } from "react";
import { cn } from "@/lib/utils";

export interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  label?: string;
  error?: string;
  helperText?: string;
  hasIcon?: boolean;
}

const Input = forwardRef<HTMLInputElement, InputProps>(
  ({ className, label, error, helperText, id, hasIcon, style, ...props }, ref) => {
    const inputId = id || label?.toLowerCase().replace(/\s+/g, "-");

    const inputStyles: CSSProperties = {
      width: "100%",
      padding: hasIcon ? "14px 16px 14px 44px" : "14px 16px",
      borderRadius: "8px",
      background: "#1E1E1E",
      border: error ? "1px solid #E53935" : "1px solid #333",
      color: "#fff",
      fontSize: "16px",
      transition: "all 0.2s",
      outline: "none",
      ...style,
    };

    return (
      <div style={{ width: "100%" }}>
        {label && (
          <label
            htmlFor={inputId}
            style={{
              display: "block",
              fontSize: "14px",
              fontWeight: 500,
              color: "#888",
              marginBottom: "8px",
            }}
          >
            {label}
          </label>
        )}
        <input
          ref={ref}
          id={inputId}
          className={cn(className)}
          style={inputStyles}
          {...props}
        />
        {error && (
          <p style={{ marginTop: "4px", fontSize: "14px", color: "#E53935" }}>{error}</p>
        )}
        {helperText && !error && (
          <p style={{ marginTop: "4px", fontSize: "14px", color: "#666" }}>
            {helperText}
          </p>
        )}
      </div>
    );
  }
);

Input.displayName = "Input";

export interface TextareaProps
  extends React.TextareaHTMLAttributes<HTMLTextAreaElement> {
  label?: string;
  error?: string;
  helperText?: string;
}

const Textarea = forwardRef<HTMLTextAreaElement, TextareaProps>(
  ({ className, label, error, helperText, id, ...props }, ref) => {
    const inputId = id || label?.toLowerCase().replace(/\s+/g, "-");

    return (
      <div className="w-full">
        {label && (
          <label
            htmlFor={inputId}
            className="block text-sm font-medium text-[var(--foreground-secondary)] mb-2"
          >
            {label}
          </label>
        )}
        <textarea
          ref={ref}
          id={inputId}
          className={cn(
            "w-full px-4 py-3 rounded-lg resize-y min-h-[120px]",
            "bg-[var(--surface)] border border-[var(--border)]",
            "text-[var(--foreground)] placeholder-[var(--foreground-muted)]",
            "transition-colors duration-200",
            "focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:border-transparent",
            "disabled:opacity-50 disabled:cursor-not-allowed",
            error && "border-[var(--error)] focus:ring-[var(--error)]",
            className
          )}
          {...props}
        />
        {error && (
          <p className="mt-1 text-sm text-[var(--error)]">{error}</p>
        )}
        {helperText && !error && (
          <p className="mt-1 text-sm text-[var(--foreground-muted)]">
            {helperText}
          </p>
        )}
      </div>
    );
  }
);

Textarea.displayName = "Textarea";

export { Input, Textarea };

'use client';

import { useState, useRef, ChangeEvent } from 'react';
import { Upload, X, Loader2, Image as ImageIcon } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';

interface ImageUploadProps {
  value?: string;
  onChange: (url: string) => void;
  label?: string;
  disabled?: boolean;
}

export function ImageUpload({
  value,
  onChange,
  label = 'Upload Image',
  disabled = false,
}: ImageUploadProps) {
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [preview, setPreview] = useState<string | null>(value || null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleFileChange = async (e: ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    // Validate file type
    const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/webp', 'image/gif'];
    if (!validTypes.includes(file.type)) {
      setError('Invalid file type. Only JPEG, PNG, WebP, and GIF are allowed.');
      return;
    }

    // Validate file size (max 5MB)
    const maxSize = 5 * 1024 * 1024;
    if (file.size > maxSize) {
      setError('File too large. Maximum size is 5MB.');
      return;
    }

    setError(null);
    setUploading(true);

    try {
      // Create preview
      const reader = new FileReader();
      reader.onloadend = () => {
        setPreview(reader.result as string);
      };
      reader.readAsDataURL(file);

      // Upload file
      const formData = new FormData();
      formData.append('file', file);

      const response = await fetch('/api/upload', {
        method: 'POST',
        body: formData,
      });

      if (!response.ok) {
        const data = await response.json();
        throw new Error(data.error || 'Upload failed');
      }

      const data = await response.json();

      // Convert relative URL to absolute URL for external access
      const absoluteUrl = `${window.location.origin}${data.url}`;
      onChange(absoluteUrl);
      setPreview(absoluteUrl);
    } catch (err: any) {
      setError(err.message || 'Failed to upload image');
      setPreview(null);
    } finally {
      setUploading(false);
    }
  };

  const handleRemove = () => {
    setPreview(null);
    onChange('');
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
  };

  const handleClick = () => {
    fileInputRef.current?.click();
  };

  return (
    <div className="space-y-3">
      {label && <Label>{label}</Label>}

      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        onChange={handleFileChange}
        disabled={disabled || uploading}
        className="hidden"
      />

      {!preview ? (
        <button
          type="button"
          onClick={handleClick}
          disabled={disabled || uploading}
          className="relative flex flex-col items-center justify-center w-full h-48 border-2 border-dashed border-border rounded-xl hover:border-primary/50 transition-colors bg-card/50 hover:bg-card group disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {uploading ? (
            <>
              <Loader2 className="h-10 w-10 text-primary animate-spin mb-3" />
              <p className="text-sm text-muted-foreground">Uploading...</p>
            </>
          ) : (
            <>
              <Upload className="h-10 w-10 text-muted-foreground group-hover:text-primary transition-colors mb-3" />
              <p className="text-sm font-medium text-foreground">
                Click to upload
              </p>
              <p className="text-xs text-muted-foreground mt-1">
                PNG, JPG, WebP, or GIF (max 5MB)
              </p>
            </>
          )}
        </button>
      ) : (
        <div className="relative w-full h-48 rounded-xl overflow-hidden border border-border/50 group">
          <img
            src={preview}
            alt="Preview"
            className="w-full h-full object-cover"
            onError={() => {
              setError('Failed to load image');
              setPreview(null);
            }}
          />
          <div className="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center gap-2">
            <Button
              type="button"
              variant="secondary"
              size="sm"
              onClick={handleClick}
              disabled={disabled || uploading}
              className="shadow-lg"
            >
              <ImageIcon className="h-4 w-4 mr-2" />
              Change
            </Button>
            <Button
              type="button"
              variant="destructive"
              size="sm"
              onClick={handleRemove}
              disabled={disabled || uploading}
              className="shadow-lg"
            >
              <X className="h-4 w-4 mr-2" />
              Remove
            </Button>
          </div>
        </div>
      )}

      {error && (
        <p className="text-sm text-destructive">{error}</p>
      )}
    </div>
  );
}

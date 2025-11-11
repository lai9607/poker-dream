'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import toast from 'react-hot-toast';

export default function CreateVideoPage() {
  const router = useRouter();
  const [loading, setLoading] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [imagePreview, setImagePreview] = useState<string>('');
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    videoUrl: '',
    thumbnailUrl: '',
    durationSeconds: '',
  });

  const handleImageUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setUploading(true);
    const uploadFormData = new FormData();
    uploadFormData.append('image', file);

    try {
      const res = await fetch('http://localhost:3001/api/upload/image', {
        method: 'POST',
        body: uploadFormData,
      });

      if (res.ok) {
        const data = await res.json();
        setFormData(prev => ({ ...prev, thumbnailUrl: data.imageUrl }));
        setImagePreview(data.imageUrl);
        toast.success('Thumbnail uploaded successfully');
      } else {
        toast.error('Failed to upload thumbnail');
      }
    } catch (error) {
      console.error('Error uploading image:', error);
      toast.error('Error uploading thumbnail');
    } finally {
      setUploading(false);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      const payload = {
        ...formData,
        durationSeconds: formData.durationSeconds ? parseInt(formData.durationSeconds) : undefined,
      };

      const res = await fetch('http://localhost:3001/api/videos', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
      });

      if (res.ok) {
        toast.success('Video created successfully');
        router.push('/videos');
      } else {
        const errorData = await res.json().catch(() => ({}));
        toast.error(errorData.message || 'Failed to create video');
      }
    } catch (error) {
      console.error('Error creating video:', error);
      toast.error('Error creating video');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="p-8">
      <h1 className="text-3xl font-bold text-foreground mb-6">Add New Video</h1>

      <div className="bg-card rounded-xl border border-border/50 p-6 max-w-2xl">
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-foreground mb-2">
              Title *
            </label>
            <input
              type="text"
              required
              value={formData.title}
              onChange={(e) => setFormData({ ...formData, title: e.target.value })}
              className="w-full px-3 py-2 bg-background border border-border rounded-lg text-foreground"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-foreground mb-2">
              Description
            </label>
            <textarea
              value={formData.description}
              onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              rows={3}
              className="w-full px-3 py-2 bg-background border border-border rounded-lg text-foreground"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-foreground mb-2">
              Video URL *
            </label>
            <input
              type="url"
              required
              value={formData.videoUrl}
              onChange={(e) => setFormData({ ...formData, videoUrl: e.target.value })}
              className="w-full px-3 py-2 bg-background border border-border rounded-lg text-foreground"
              placeholder="https://youtube.com/..."
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-foreground mb-2">
              Thumbnail
            </label>

            {/* Image Preview */}
            {(imagePreview || formData.thumbnailUrl) && (
              <div className="mb-3">
                <img
                  src={imagePreview || formData.thumbnailUrl}
                  alt="Thumbnail preview"
                  className="w-full max-w-md h-48 object-cover rounded-lg border border-border"
                />
              </div>
            )}

            {/* File Upload */}
            <div className="mb-3">
              <label className="block">
                <span className="sr-only">Choose thumbnail</span>
                <input
                  type="file"
                  accept="image/*"
                  onChange={handleImageUpload}
                  disabled={uploading}
                  className="block w-full text-sm text-foreground file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-primary file:text-primary-foreground hover:file:bg-primary/90 disabled:opacity-50"
                />
              </label>
              {uploading && (
                <p className="text-sm text-muted-foreground mt-2">Uploading...</p>
              )}
            </div>

            {/* Or manual URL input */}
            <div className="text-sm text-muted-foreground mb-2">Or enter URL manually:</div>
            <input
              type="url"
              value={formData.thumbnailUrl}
              onChange={(e) => {
                setFormData({ ...formData, thumbnailUrl: e.target.value });
                setImagePreview(e.target.value);
              }}
              placeholder="https://example.com/thumbnail.jpg"
              className="w-full px-3 py-2 bg-background border border-border rounded-lg text-foreground"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-foreground mb-2">
              Duration (seconds)
            </label>
            <input
              type="number"
              value={formData.durationSeconds}
              onChange={(e) => setFormData({ ...formData, durationSeconds: e.target.value })}
              className="w-full px-3 py-2 bg-background border border-border rounded-lg text-foreground"
              placeholder="930"
            />
          </div>

          <div className="flex gap-4 pt-4">
            <button
              type="submit"
              disabled={loading}
              className="bg-primary hover:bg-primary/90 text-primary-foreground px-6 py-2 rounded-lg disabled:opacity-50"
            >
              {loading ? 'Creating...' : 'Create Video'}
            </button>
            <button
              type="button"
              onClick={() => router.push('/videos')}
              className="bg-muted hover:bg-muted/80 text-foreground px-6 py-2 rounded-lg"
            >
              Cancel
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

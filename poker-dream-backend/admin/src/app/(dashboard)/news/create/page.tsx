'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import toast from 'react-hot-toast';

export default function CreateNewsPage() {
  const router = useRouter();
  const [loading, setLoading] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [imagePreview, setImagePreview] = useState<string>('');
  const [formData, setFormData] = useState({
    title: '',
    summary: '',
    content: '',
    imageUrl: '',
    category: 'GENERAL',
    author: '',
    isPublished: false,
  });

  const handleImageUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setUploading(true);
    const formData = new FormData();
    formData.append('image', file);

    try {
      const res = await fetch('http://localhost:3001/api/upload/image', {
        method: 'POST',
        body: formData,
      });

      if (res.ok) {
        const data = await res.json();
        setFormData(prev => ({ ...prev, imageUrl: data.imageUrl }));
        setImagePreview(data.imageUrl);
        toast.success('Image uploaded successfully');
      } else {
        toast.error('Failed to upload image');
      }
    } catch (error) {
      console.error('Error uploading image:', error);
      toast.error('Error uploading image');
    } finally {
      setUploading(false);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      const res = await fetch('http://localhost:3001/api/news', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
      });

      if (res.ok) {
        toast.success('Article created successfully');
        router.push('/news');
      } else {
        const errorData = await res.json().catch(() => ({}));
        toast.error(errorData.message || 'Failed to create article');
      }
    } catch (error) {
      console.error('Error creating article:', error);
      toast.error('Error creating article');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="p-8">
      <h1 className="text-3xl font-bold text-foreground mb-6">Add New Article</h1>

      <div className="bg-card rounded-xl border border-border/50 p-6 max-w-3xl">
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
              Summary
            </label>
            <textarea
              value={formData.summary}
              onChange={(e) => setFormData({ ...formData, summary: e.target.value })}
              rows={2}
              className="w-full px-3 py-2 bg-background border border-border rounded-lg text-foreground"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-foreground mb-2">
              Content *
            </label>
            <textarea
              required
              value={formData.content}
              onChange={(e) => setFormData({ ...formData, content: e.target.value })}
              rows={8}
              className="w-full px-3 py-2 bg-background border border-border rounded-lg text-foreground"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-foreground mb-2">
              Image
            </label>

            {/* Image Preview */}
            {(imagePreview || formData.imageUrl) && (
              <div className="mb-3">
                <img
                  src={imagePreview || formData.imageUrl}
                  alt="Preview"
                  className="w-full max-w-md h-48 object-cover rounded-lg border border-border"
                />
              </div>
            )}

            {/* File Upload */}
            <div className="mb-3">
              <label className="block">
                <span className="sr-only">Choose image</span>
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
              value={formData.imageUrl}
              onChange={(e) => {
                setFormData({ ...formData, imageUrl: e.target.value });
                setImagePreview(e.target.value);
              }}
              placeholder="https://example.com/image.jpg"
              className="w-full px-3 py-2 bg-background border border-border rounded-lg text-foreground"
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-foreground mb-2">
                Category
              </label>
              <select
                value={formData.category}
                onChange={(e) => setFormData({ ...formData, category: e.target.value })}
                className="w-full px-3 py-2 bg-background border border-border rounded-lg text-foreground"
              >
                <option value="GENERAL">General</option>
                <option value="TOURNAMENTS">Tournaments</option>
                <option value="INDUSTRY">Industry</option>
                <option value="STRATEGY">Strategy</option>
                <option value="PLAYER_INTERVIEW">Player Interview</option>
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-foreground mb-2">
                Author
              </label>
              <input
                type="text"
                value={formData.author}
                onChange={(e) => setFormData({ ...formData, author: e.target.value })}
                className="w-full px-3 py-2 bg-background border border-border rounded-lg text-foreground"
              />
            </div>
          </div>

          <div className="flex items-center gap-2">
            <input
              type="checkbox"
              id="isPublished"
              checked={formData.isPublished}
              onChange={(e) => setFormData({ ...formData, isPublished: e.target.checked })}
              className="w-4 h-4"
            />
            <label htmlFor="isPublished" className="text-sm text-foreground">
              Publish immediately
            </label>
          </div>

          <div className="flex gap-4 pt-4">
            <button
              type="submit"
              disabled={loading}
              className="bg-primary hover:bg-primary/90 text-primary-foreground px-6 py-2 rounded-lg disabled:opacity-50"
            >
              {loading ? 'Creating...' : 'Create Article'}
            </button>
            <button
              type="button"
              onClick={() => router.push('/news')}
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

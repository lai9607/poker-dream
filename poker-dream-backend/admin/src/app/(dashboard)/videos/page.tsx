'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';

interface Video {
  id: string;
  title: string;
  description: string | null;
  thumbnailUrl: string | null;
  durationSeconds: number | null;
  viewCount: number;
  publishedAt: string;
}

export default function VideosPage() {
  const [videos, setVideos] = useState<Video[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchVideos();
  }, []);

  const fetchVideos = async () => {
    try {
      const res = await fetch('http://localhost:3001/api/videos');
      const data = await res.json();
      setVideos(data.data);
    } catch (error) {
      console.error('Error fetching videos:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id: string) => {
    if (!confirm('Are you sure you want to delete this video?')) return;

    try {
      await fetch(`http://localhost:3001/api/videos/${id}`, {
        method: 'DELETE',
      });
      fetchVideos();
    } catch (error) {
      console.error('Error deleting video:', error);
    }
  };

  const formatDuration = (seconds: number | null) => {
    if (!seconds) return 'N/A';
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  if (loading) {
    return <div className="p-8">Loading...</div>;
  }

  return (
    <div className="p-8">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold text-foreground">Video Highlights</h1>
        <Link
          href="/videos/create"
          className="bg-primary hover:bg-primary/90 text-primary-foreground px-4 py-2 rounded-lg"
        >
          Add New Video
        </Link>
      </div>

      <div className="bg-card rounded-xl border border-border/50 overflow-hidden">
        <table className="w-full">
          <thead className="bg-muted/50">
            <tr>
              <th className="text-left p-4 text-sm font-semibold text-foreground">Thumbnail</th>
              <th className="text-left p-4 text-sm font-semibold text-foreground">Title</th>
              <th className="text-left p-4 text-sm font-semibold text-foreground">Duration</th>
              <th className="text-left p-4 text-sm font-semibold text-foreground">Views</th>
              <th className="text-left p-4 text-sm font-semibold text-foreground">Published</th>
              <th className="text-right p-4 text-sm font-semibold text-foreground">Actions</th>
            </tr>
          </thead>
          <tbody>
            {videos.map((video) => (
              <tr key={video.id} className="border-t border-border/50 hover:bg-muted/20">
                <td className="p-4">
                  {video.thumbnailUrl ? (
                    <img
                      src={video.thumbnailUrl}
                      alt={video.title}
                      className="w-24 h-16 object-cover rounded"
                    />
                  ) : (
                    <div className="w-24 h-16 bg-muted rounded flex items-center justify-center text-muted-foreground">
                      No Image
                    </div>
                  )}
                </td>
                <td className="p-4">
                  <div className="font-medium text-foreground">{video.title}</div>
                  {video.description && (
                    <div className="text-sm text-muted-foreground truncate max-w-md">
                      {video.description}
                    </div>
                  )}
                </td>
                <td className="p-4 text-muted-foreground">
                  {formatDuration(video.durationSeconds)}
                </td>
                <td className="p-4 text-muted-foreground">{video.viewCount.toLocaleString()}</td>
                <td className="p-4 text-muted-foreground">
                  {new Date(video.publishedAt).toLocaleDateString()}
                </td>
                <td className="p-4 text-right">
                  <Link
                    href={`/videos/${video.id}`}
                    className="text-primary hover:underline mr-4"
                  >
                    Edit
                  </Link>
                  <button
                    onClick={() => handleDelete(video.id)}
                    className="text-destructive hover:underline"
                  >
                    Delete
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

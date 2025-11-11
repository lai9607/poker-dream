'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';

interface NewsArticle {
  id: string;
  title: string;
  summary: string | null;
  imageUrl: string | null;
  category: string;
  author: string | null;
  isPublished: boolean;
  publishedAt: string | null;
}

export default function NewsPage() {
  const [articles, setArticles] = useState<NewsArticle[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchNews();
  }, []);

  const fetchNews = async () => {
    try {
      const res = await fetch('http://localhost:3001/api/news');
      const data = await res.json();
      setArticles(data.data);
    } catch (error) {
      console.error('Error fetching news:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id: string) => {
    if (!confirm('Are you sure you want to delete this article?')) return;

    try {
      await fetch(`http://localhost:3001/api/news/${id}`, {
        method: 'DELETE',
      });
      fetchNews();
    } catch (error) {
      console.error('Error deleting article:', error);
    }
  };

  if (loading) {
    return <div className="p-8">Loading...</div>;
  }

  return (
    <div className="p-8">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold text-foreground">News Articles</h1>
        <Link
          href="/news/create"
          className="bg-primary hover:bg-primary/90 text-primary-foreground px-4 py-2 rounded-lg"
        >
          Add New Article
        </Link>
      </div>

      <div className="bg-card rounded-xl border border-border/50 overflow-hidden">
        <table className="w-full">
          <thead className="bg-muted/50">
            <tr>
              <th className="text-left p-4 text-sm font-semibold text-foreground">Image</th>
              <th className="text-left p-4 text-sm font-semibold text-foreground">Title</th>
              <th className="text-left p-4 text-sm font-semibold text-foreground">Category</th>
              <th className="text-left p-4 text-sm font-semibold text-foreground">Author</th>
              <th className="text-left p-4 text-sm font-semibold text-foreground">Status</th>
              <th className="text-left p-4 text-sm font-semibold text-foreground">Published</th>
              <th className="text-right p-4 text-sm font-semibold text-foreground">Actions</th>
            </tr>
          </thead>
          <tbody>
            {articles.map((article) => (
              <tr key={article.id} className="border-t border-border/50 hover:bg-muted/20">
                <td className="p-4">
                  {article.imageUrl ? (
                    <img
                      src={article.imageUrl}
                      alt={article.title}
                      className="w-24 h-16 object-cover rounded"
                    />
                  ) : (
                    <div className="w-24 h-16 bg-muted rounded flex items-center justify-center text-muted-foreground">
                      No Image
                    </div>
                  )}
                </td>
                <td className="p-4">
                  <div className="font-medium text-foreground">{article.title}</div>
                  {article.summary && (
                    <div className="text-sm text-muted-foreground truncate max-w-md">
                      {article.summary}
                    </div>
                  )}
                </td>
                <td className="p-4">
                  <span className="px-2 py-1 rounded-full text-xs font-medium bg-primary/20 text-primary">
                    {article.category}
                  </span>
                </td>
                <td className="p-4 text-muted-foreground">{article.author || 'N/A'}</td>
                <td className="p-4">
                  {article.isPublished ? (
                    <span className="px-2 py-1 rounded-full text-xs font-medium bg-green-500/20 text-green-600">
                      Published
                    </span>
                  ) : (
                    <span className="px-2 py-1 rounded-full text-xs font-medium bg-yellow-500/20 text-yellow-600">
                      Draft
                    </span>
                  )}
                </td>
                <td className="p-4 text-muted-foreground">
                  {article.publishedAt
                    ? new Date(article.publishedAt).toLocaleDateString()
                    : 'Not published'}
                </td>
                <td className="p-4 text-right">
                  <Link
                    href={`/news/${article.id}`}
                    className="text-primary hover:underline mr-4"
                  >
                    Edit
                  </Link>
                  <button
                    onClick={() => handleDelete(article.id)}
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

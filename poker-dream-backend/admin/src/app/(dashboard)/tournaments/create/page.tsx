'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { useMutation } from '@tanstack/react-query';
import { ArrowLeft } from 'lucide-react';
import Link from 'next/link';
import { tournamentsApi, Tournament } from '@/lib/api';
import { TournamentForm } from '@/components/forms/TournamentForm';
import { Button } from '@/components/ui/button';

export default function CreateTournamentPage() {
  const router = useRouter();
  const [error, setError] = useState<string | null>(null);

  const createMutation = useMutation({
    mutationFn: (data: Partial<Tournament>) => tournamentsApi.create(data),
    onSuccess: () => {
      router.push('/tournaments');
    },
    onError: (error: any) => {
      setError(
        error?.response?.data?.error ||
          'Failed to create tournament. Please try again.'
      );
    },
  });

  const handleSubmit = async (data: Partial<Tournament>) => {
    setError(null);
    await createMutation.mutateAsync(data);
  };

  const handleCancel = () => {
    router.push('/tournaments');
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center gap-4">
        <Link href="/tournaments">
          <Button variant="ghost" size="icon">
            <ArrowLeft className="h-4 w-4" />
          </Button>
        </Link>
        <div>
          <h1 className="text-3xl font-bold">Create Tournament</h1>
          <p className="text-muted-foreground mt-1">
            Add a new poker tournament
          </p>
        </div>
      </div>

      {/* Error Message */}
      {error && (
        <div className="bg-red-50 border border-red-200 text-red-800 rounded-lg p-4">
          <p className="font-medium">Error</p>
          <p className="text-sm mt-1">{error}</p>
        </div>
      )}

      {/* Form */}
      <div className="bg-card border rounded-lg p-6">
        <TournamentForm
          onSubmit={handleSubmit}
          onCancel={handleCancel}
          isLoading={createMutation.isPending}
        />
      </div>
    </div>
  );
}

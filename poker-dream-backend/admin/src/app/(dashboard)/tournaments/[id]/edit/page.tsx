'use client';

import { useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { ArrowLeft } from 'lucide-react';
import Link from 'next/link';
import { tournamentsApi, Tournament } from '@/lib/api';
import { TournamentForm } from '@/components/forms/TournamentForm';
import { Button } from '@/components/ui/button';

export default function EditTournamentPage() {
  const params = useParams();
  const router = useRouter();
  const queryClient = useQueryClient();
  const id = params.id as string;

  const [error, setError] = useState<string | null>(null);

  const { data, isLoading } = useQuery({
    queryKey: ['tournament', id],
    queryFn: async () => {
      const response = await tournamentsApi.getById(id);
      return response.data.data;
    },
  });

  const updateMutation = useMutation({
    mutationFn: (data: Partial<Tournament>) =>
      tournamentsApi.update(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['tournament', id] });
      queryClient.invalidateQueries({ queryKey: ['tournaments'] });
      router.push(`/tournaments/${id}`);
    },
    onError: (error: any) => {
      setError(
        error?.response?.data?.error ||
          'Failed to update tournament. Please try again.'
      );
    },
  });

  const handleSubmit = async (data: Partial<Tournament>) => {
    setError(null);
    await updateMutation.mutateAsync(data);
  };

  const handleCancel = () => {
    router.push(`/tournaments/${id}`);
  };

  if (isLoading) {
    return (
      <div className="text-center py-12">
        <p className="text-muted-foreground">Loading tournament...</p>
      </div>
    );
  }

  if (!data) {
    return (
      <div className="text-center py-12">
        <p className="text-red-500">Tournament not found.</p>
        <Link href="/tournaments">
          <Button variant="outline" className="mt-4">
            Back to Tournaments
          </Button>
        </Link>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center gap-4">
        <Link href={`/tournaments/${id}`}>
          <Button variant="ghost" size="icon">
            <ArrowLeft className="h-4 w-4" />
          </Button>
        </Link>
        <div>
          <h1 className="text-3xl font-bold">Edit Tournament</h1>
          <p className="text-muted-foreground mt-1">{data.name}</p>
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
          tournament={data}
          onSubmit={handleSubmit}
          onCancel={handleCancel}
          isLoading={updateMutation.isPending}
        />
      </div>
    </div>
  );
}

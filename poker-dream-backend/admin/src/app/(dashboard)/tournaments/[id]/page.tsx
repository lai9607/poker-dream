'use client';

import { useQuery } from '@tanstack/react-query';
import { useParams, useRouter } from 'next/navigation';
import Link from 'next/link';
import { ArrowLeft, Pencil, Calendar, MapPin, DollarSign, Users } from 'lucide-react';
import { tournamentsApi } from '@/lib/api';
import { formatDate, formatCurrency, formatNumber } from '@/lib/utils';
import { Button } from '@/components/ui/button';

export default function TournamentDetailPage() {
  const params = useParams();
  const router = useRouter();
  const id = params.id as string;

  const { data, isLoading, error } = useQuery({
    queryKey: ['tournament', id],
    queryFn: async () => {
      const response = await tournamentsApi.getById(id);
      return response.data.data;
    },
  });

  const getStatusBadgeColor = (status: string) => {
    switch (status) {
      case 'LIVE':
        return 'bg-green-100 text-green-800 border-green-200';
      case 'UPCOMING':
        return 'bg-blue-100 text-blue-800 border-blue-200';
      case 'COMPLETED':
        return 'bg-gray-100 text-gray-800 border-gray-200';
      case 'CANCELLED':
        return 'bg-red-100 text-red-800 border-red-200';
      default:
        return 'bg-gray-100 text-gray-800 border-gray-200';
    }
  };

  if (isLoading) {
    return (
      <div className="text-center py-12">
        <p className="text-muted-foreground">Loading tournament...</p>
      </div>
    );
  }

  if (error || !data) {
    return (
      <div className="text-center py-12">
        <p className="text-red-500">Failed to load tournament. Please try again.</p>
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
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Link href="/tournaments">
            <Button variant="ghost" size="icon">
              <ArrowLeft className="h-4 w-4" />
            </Button>
          </Link>
          <div>
            <h1 className="text-3xl font-bold">{data.name}</h1>
            <div className="flex items-center gap-2 mt-2">
              <span
                className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium border ${getStatusBadgeColor(
                  data.status
                )}`}
              >
                {data.status}
              </span>
            </div>
          </div>
        </div>
        <Button onClick={() => router.push(`/tournaments/${id}/edit`)}>
          <Pencil className="mr-2 h-4 w-4" />
          Edit
        </Button>
      </div>

      {/* Banner Image */}
      {data.bannerImageUrl && (
        <div className="rounded-lg overflow-hidden border">
          <img
            src={data.bannerImageUrl}
            alt={data.name}
            className="w-full h-64 object-cover"
          />
        </div>
      )}

      {/* Key Information Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <div className="bg-card border rounded-lg p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-blue-100 rounded-lg">
              <Calendar className="h-5 w-5 text-blue-600" />
            </div>
            <div>
              <p className="text-sm text-muted-foreground">Start Date</p>
              <p className="font-semibold">{formatDate(data.startDate)}</p>
            </div>
          </div>
        </div>

        <div className="bg-card border rounded-lg p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-green-100 rounded-lg">
              <DollarSign className="h-5 w-5 text-green-600" />
            </div>
            <div>
              <p className="text-sm text-muted-foreground">Prize Pool</p>
              <p className="font-semibold">{formatCurrency(data.prizePool)}</p>
            </div>
          </div>
        </div>

        <div className="bg-card border rounded-lg p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-purple-100 rounded-lg">
              <DollarSign className="h-5 w-5 text-purple-600" />
            </div>
            <div>
              <p className="text-sm text-muted-foreground">Buy-in</p>
              <p className="font-semibold">{formatCurrency(data.buyIn)}</p>
            </div>
          </div>
        </div>

        <div className="bg-card border rounded-lg p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-orange-100 rounded-lg">
              <Users className="h-5 w-5 text-orange-600" />
            </div>
            <div>
              <p className="text-sm text-muted-foreground">Total Entries</p>
              <p className="font-semibold">{formatNumber(data.totalEntries)}</p>
            </div>
          </div>
        </div>
      </div>

      {/* Details Section */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Tournament Information */}
        <div className="bg-card border rounded-lg p-6">
          <h2 className="text-xl font-semibold mb-4">Tournament Information</h2>
          <div className="space-y-3">
            <div>
              <p className="text-sm text-muted-foreground">Description</p>
              <p className="mt-1">{data.description || 'No description provided'}</p>
            </div>
            {data.location && (
              <div>
                <p className="text-sm text-muted-foreground">Location</p>
                <div className="flex items-center gap-2 mt-1">
                  <MapPin className="h-4 w-4 text-muted-foreground" />
                  <p>{data.location}</p>
                </div>
              </div>
            )}
            {data.venue && (
              <div>
                <p className="text-sm text-muted-foreground">Venue</p>
                <p className="mt-1">{data.venue}</p>
              </div>
            )}
            {data.endDate && (
              <div>
                <p className="text-sm text-muted-foreground">End Date</p>
                <p className="mt-1">{formatDate(data.endDate)}</p>
              </div>
            )}
          </div>
        </div>

        {/* Metadata */}
        <div className="bg-card border rounded-lg p-6">
          <h2 className="text-xl font-semibold mb-4">Metadata</h2>
          <div className="space-y-3">
            <div>
              <p className="text-sm text-muted-foreground">Tournament ID</p>
              <p className="mt-1 font-mono text-sm">{data.id}</p>
            </div>
            <div>
              <p className="text-sm text-muted-foreground">Created At</p>
              <p className="mt-1">{formatDate(data.createdAt)}</p>
            </div>
            <div>
              <p className="text-sm text-muted-foreground">Last Updated</p>
              <p className="mt-1">{formatDate(data.updatedAt)}</p>
            </div>
          </div>
        </div>
      </div>

      {/* Standings Section (if available) */}
      {data.standings && data.standings.length > 0 && (
        <div className="bg-card border rounded-lg p-6">
          <h2 className="text-xl font-semibold mb-4">Current Standings</h2>
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-muted">
                <tr>
                  <th className="px-4 py-3 text-left text-sm font-medium">Rank</th>
                  <th className="px-4 py-3 text-left text-sm font-medium">Player</th>
                  <th className="px-4 py-3 text-right text-sm font-medium">Chips</th>
                  <th className="px-4 py-3 text-right text-sm font-medium">Prize</th>
                </tr>
              </thead>
              <tbody className="divide-y">
                {data.standings.slice(0, 10).map((standing: any) => (
                  <tr key={standing.id}>
                    <td className="px-4 py-3 font-medium">{standing.rank}</td>
                    <td className="px-4 py-3">{standing.player?.name || 'Unknown'}</td>
                    <td className="px-4 py-3 text-right">
                      {formatNumber(standing.chips)}
                    </td>
                    <td className="px-4 py-3 text-right">
                      {formatCurrency(standing.prize)}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}

'use client';

import { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { Plus, Pencil, Trash2, Eye, Search } from 'lucide-react';
import { tournamentsApi, Tournament } from '@/lib/api';
import { formatDate, formatCurrency, formatNumber } from '@/lib/utils';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';

export default function TournamentsPage() {
  const router = useRouter();
  const queryClient = useQueryClient();

  const [page, setPage] = useState(1);
  const [limit] = useState(10);
  const [search, setSearch] = useState('');
  const [status, setStatus] = useState<string>('');

  const { data, isLoading, error } = useQuery({
    queryKey: ['tournaments', { page, limit, search, status }],
    queryFn: async () => {
      const response = await tournamentsApi.getAll({
        page,
        limit,
        search: search || undefined,
        status: status as any,
      });
      return response.data;
    },
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => tournamentsApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['tournaments'] });
    },
  });

  const handleDelete = async (id: string, name: string) => {
    if (
      window.confirm(
        `Are you sure you want to delete "${name}"? This action cannot be undone.`
      )
    ) {
      try {
        await deleteMutation.mutateAsync(id);
        alert('Tournament deleted successfully');
      } catch (error: any) {
        alert(error?.response?.data?.error || 'Failed to delete tournament');
      }
    }
  };

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

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8">
        <div>
          <h1 className="text-3xl font-bold tracking-tight">Tournaments</h1>
          <p className="text-muted-foreground mt-2">
            Manage all poker tournaments
          </p>
        </div>
        <Link href="/tournaments/create">
          <Button size="lg" className="w-full sm:w-auto shadow-lg">
            <Plus className="mr-2 h-5 w-5" />
            New Tournament
          </Button>
        </Link>
      </div>

      {/* Filters */}
      <div className="flex flex-col sm:flex-row gap-4">
        <div className="flex-1">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
            <Input
              placeholder="Search by name, location, or venue..."
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="pl-9"
            />
          </div>
        </div>
        <Select value={status || 'ALL'} onValueChange={(value) => setStatus(value === 'ALL' ? '' : value)}>
          <SelectTrigger className="w-full sm:w-[180px]">
            <SelectValue placeholder="All Statuses" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="ALL">All Statuses</SelectItem>
            <SelectItem value="UPCOMING">Upcoming</SelectItem>
            <SelectItem value="LIVE">Live</SelectItem>
            <SelectItem value="COMPLETED">Completed</SelectItem>
            <SelectItem value="CANCELLED">Cancelled</SelectItem>
          </SelectContent>
        </Select>
      </div>

      {/* Loading State */}
      {isLoading && (
        <div className="text-center py-12">
          <p className="text-muted-foreground">Loading tournaments...</p>
        </div>
      )}

      {/* Error State */}
      {error && (
        <div className="text-center py-12">
          <p className="text-red-500">
            Failed to load tournaments. Please try again.
          </p>
        </div>
      )}

      {/* Table */}
      {!isLoading && !error && data && (
        <>
          <div className="bg-card border border-border/50 rounded-xl overflow-hidden shadow-lg">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="bg-muted/30 backdrop-blur-sm">
                  <tr className="border-b border-border">
                    <th className="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-muted-foreground">
                      Tournament
                    </th>
                    <th className="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-muted-foreground">
                      Status
                    </th>
                    <th className="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-muted-foreground">
                      Dates
                    </th>
                    <th className="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-muted-foreground">
                      Location
                    </th>
                    <th className="px-6 py-4 text-right text-xs font-semibold uppercase tracking-wider text-muted-foreground">
                      Prize Pool
                    </th>
                    <th className="px-6 py-4 text-right text-xs font-semibold uppercase tracking-wider text-muted-foreground">
                      Entries
                    </th>
                    <th className="px-6 py-4 text-center text-xs font-semibold uppercase tracking-wider text-muted-foreground">
                      Actions
                    </th>
                  </tr>
                </thead>
                <tbody className="divide-y">
                  {data.data.length === 0 ? (
                    <tr>
                      <td colSpan={7} className="px-4 py-12 text-center">
                        <p className="text-muted-foreground">
                          No tournaments found
                        </p>
                      </td>
                    </tr>
                  ) : (
                    data.data.map((tournament: Tournament) => (
                      <tr key={tournament.id} className="hover:bg-accent/10 transition-colors group">
                        <td className="px-6 py-4">
                          <div className="flex items-center gap-3">
                            <div className="flex-shrink-0 w-12 h-12 bg-gradient-to-br from-primary/20 to-primary/5 rounded-lg flex items-center justify-center">
                              <span className="text-primary font-bold text-lg">
                                {tournament.name.charAt(0)}
                              </span>
                            </div>
                            <div>
                              <p className="font-semibold text-card-foreground group-hover:text-primary transition-colors">
                                {tournament.name}
                              </p>
                              {tournament.venue && (
                                <p className="text-sm text-muted-foreground mt-0.5">
                                  {tournament.venue}
                                </p>
                              )}
                            </div>
                          </div>
                        </td>
                        <td className="px-6 py-4">
                          <span
                            className={`inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold border backdrop-blur-sm ${getStatusBadgeColor(
                              tournament.status
                            )}`}
                          >
                            {tournament.status}
                          </span>
                        </td>
                        <td className="px-6 py-4 text-sm">
                          <div className="space-y-1">
                            <p className="font-medium">{formatDate(tournament.startDate)}</p>
                            {tournament.endDate && (
                              <p className="text-muted-foreground text-xs">
                                to {formatDate(tournament.endDate)}
                              </p>
                            )}
                          </div>
                        </td>
                        <td className="px-6 py-4 text-sm">
                          <span className="font-medium">{tournament.location || '-'}</span>
                        </td>
                        <td className="px-6 py-4 text-sm text-right">
                          <span className="font-semibold text-primary">
                            {formatCurrency(tournament.prizePool)}
                          </span>
                        </td>
                        <td className="px-6 py-4 text-sm text-right">
                          <span className="font-medium">
                            {formatNumber(tournament.totalEntries)}
                          </span>
                        </td>
                        <td className="px-6 py-4">
                          <div className="flex justify-center gap-1">
                            <Button
                              variant="ghost"
                              size="icon"
                              onClick={() =>
                                router.push(`/tournaments/${tournament.id}`)
                              }
                              title="View"
                              className="hover:bg-primary/10 hover:text-primary"
                            >
                              <Eye className="h-4 w-4" />
                            </Button>
                            <Button
                              variant="ghost"
                              size="icon"
                              onClick={() =>
                                router.push(`/tournaments/${tournament.id}/edit`)
                              }
                              title="Edit"
                              className="hover:bg-secondary/10 hover:text-secondary"
                            >
                              <Pencil className="h-4 w-4" />
                            </Button>
                            <Button
                              variant="ghost"
                              size="icon"
                              onClick={() =>
                                handleDelete(tournament.id, tournament.name)
                              }
                              title="Delete"
                              className="hover:bg-destructive/10 hover:text-destructive"
                            >
                              <Trash2 className="h-4 w-4" />
                            </Button>
                          </div>
                        </td>
                      </tr>
                    ))
                  )}
                </tbody>
              </table>
            </div>
          </div>

          {/* Pagination */}
          {data.pagination.totalPages > 1 && (
            <div className="flex items-center justify-between">
              <p className="text-sm text-muted-foreground">
                Showing {(page - 1) * limit + 1} to{' '}
                {Math.min(page * limit, data.pagination.total)} of{' '}
                {data.pagination.total} tournaments
              </p>
              <div className="flex gap-2">
                <Button
                  variant="outline"
                  onClick={() => setPage(page - 1)}
                  disabled={page === 1}
                >
                  Previous
                </Button>
                <Button
                  variant="outline"
                  onClick={() => setPage(page + 1)}
                  disabled={page === data.pagination.totalPages}
                >
                  Next
                </Button>
              </div>
            </div>
          )}
        </>
      )}
    </div>
  );
}

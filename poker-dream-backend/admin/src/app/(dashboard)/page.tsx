'use client';

import { useQuery } from '@tanstack/react-query';
import { Trophy, Users, DollarSign, Calendar } from 'lucide-react';
import { tournamentsApi } from '@/lib/api';

export default function DashboardPage() {
  const { data: stats } = useQuery({
    queryKey: ['tournament-stats'],
    queryFn: async () => {
      const response = await tournamentsApi.getStats();
      return response.data.data;
    },
  });

  const statCards = [
    {
      name: 'Total Tournaments',
      value: stats?.total || 0,
      icon: Trophy,
      color: 'bg-gradient-to-br from-blue-500 to-blue-600',
    },
    {
      name: 'Upcoming',
      value: stats?.upcoming || 0,
      icon: Calendar,
      color: 'bg-gradient-to-br from-green-500 to-green-600',
    },
    {
      name: 'Live Now',
      value: stats?.live || 0,
      icon: Users,
      color: 'bg-gradient-to-br from-red-500 to-red-600',
    },
    {
      name: 'Completed',
      value: stats?.completed || 0,
      icon: DollarSign,
      color: 'bg-gradient-to-br from-purple-500 to-purple-600',
    },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight">Dashboard</h1>
        <p className="text-muted-foreground mt-2">
          Welcome to Poker Dream Admin Panel
        </p>
      </div>

      <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
        {statCards.map((stat) => (
          <div
            key={stat.name}
            className="bg-card overflow-hidden shadow-lg rounded-xl border border-border/50 hover:shadow-xl transition-shadow"
          >
            <div className="p-6">
              <div className="flex items-center">
                <div className="flex-shrink-0">
                  <div className={`${stat.color} rounded-lg p-3 shadow-md`}>
                    <stat.icon className="h-6 w-6 text-white" aria-hidden="true" />
                  </div>
                </div>
                <div className="ml-5 w-0 flex-1">
                  <dl>
                    <dt className="text-sm font-medium text-muted-foreground truncate">
                      {stat.name}
                    </dt>
                    <dd className="text-3xl font-bold text-foreground mt-1">
                      {stat.value}
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>

      <div className="bg-card shadow-lg rounded-xl border border-border/50 p-6">
        <h2 className="text-xl font-semibold mb-6">Quick Actions</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <a
            href="/tournaments/create"
            className="block p-6 border border-border rounded-xl hover:bg-accent/10 hover:border-primary/30 transition-all group"
          >
            <Trophy className="h-8 w-8 text-primary mb-3 group-hover:scale-110 transition-transform" />
            <h3 className="font-semibold text-foreground">Create Tournament</h3>
            <p className="text-sm text-muted-foreground mt-2">
              Add a new poker tournament
            </p>
          </a>
          <a
            href="/players"
            className="block p-6 border border-border rounded-xl hover:bg-accent/10 hover:border-primary/30 transition-all group"
          >
            <Users className="h-8 w-8 text-primary mb-3 group-hover:scale-110 transition-transform" />
            <h3 className="font-semibold text-foreground">Manage Players</h3>
            <p className="text-sm text-muted-foreground mt-2">
              View and edit player profiles
            </p>
          </a>
          <a
            href="/news"
            className="block p-6 border border-border rounded-xl hover:bg-accent/10 hover:border-primary/30 transition-all group"
          >
            <Calendar className="h-8 w-8 text-primary mb-3 group-hover:scale-110 transition-transform" />
            <h3 className="font-semibold text-foreground">Post News</h3>
            <p className="text-sm text-muted-foreground mt-2">
              Create new articles and updates
            </p>
          </a>
        </div>
      </div>
    </div>
  );
}

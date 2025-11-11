'use client';

import { Bell, Menu, Search, LogOut } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { useAuth } from '@/contexts/AuthContext';

export function DashboardHeader() {
  const { user, logout } = useAuth();

  return (
    <div className="sticky top-0 z-40 flex h-16 shrink-0 items-center gap-x-4 border-b border-border bg-card px-4 shadow-lg backdrop-blur-sm sm:gap-x-6 sm:px-6 lg:px-8">
      <button
        type="button"
        className="-m-2.5 p-2.5 text-muted-foreground hover:text-primary transition-colors lg:hidden"
        onClick={() => {}}
      >
        <span className="sr-only">Open sidebar</span>
        <Menu className="h-6 w-6" aria-hidden="true" />
      </button>

      {/* Separator */}
      <div className="h-6 w-px bg-border lg:hidden" aria-hidden="true" />

      <div className="flex flex-1 gap-x-4 self-stretch lg:gap-x-6">
        <form className="relative flex flex-1" action="#" method="GET">
          <label htmlFor="search-field" className="sr-only">
            Search
          </label>
          <Search
            className="pointer-events-none absolute inset-y-0 left-0 h-full w-5 text-muted-foreground"
            aria-hidden="true"
          />
          <input
            id="search-field"
            className="block h-full w-full border-0 bg-transparent py-0 pl-8 pr-0 text-foreground placeholder:text-muted-foreground focus:ring-0 sm:text-sm"
            placeholder="Search..."
            type="search"
            name="search"
          />
        </form>
        <div className="flex items-center gap-x-4 lg:gap-x-6">
          <Button
            variant="ghost"
            size="icon"
            className="-m-2.5 p-2.5 text-muted-foreground hover:text-primary hover:bg-primary/10 transition-colors"
          >
            <span className="sr-only">View notifications</span>
            <Bell className="h-6 w-6" aria-hidden="true" />
          </Button>

          {/* Separator */}
          <div
            className="hidden lg:block lg:h-6 lg:w-px lg:bg-border"
            aria-hidden="true"
          />

          {/* Profile section */}
          <div className="flex items-center gap-x-3">
            <div className="flex items-center gap-x-3">
              <span className="text-sm font-semibold leading-6 text-foreground">
                {user?.name || user?.email}
              </span>
              <div className="h-8 w-8 rounded-full bg-gradient-to-br from-primary/30 to-secondary/30 flex items-center justify-center">
                <span className="text-primary font-bold text-sm">
                  {user?.name?.[0] || user?.email?.[0] || 'A'}
                </span>
              </div>
            </div>

            <Button
              variant="ghost"
              size="sm"
              onClick={logout}
              className="text-muted-foreground hover:text-destructive hover:bg-destructive/10"
            >
              <LogOut className="h-4 w-4" />
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
}

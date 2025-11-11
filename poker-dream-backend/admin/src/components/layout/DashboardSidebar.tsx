'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import Image from 'next/image';
import { cn } from '@/lib/utils';
import {
  LayoutDashboard,
  Trophy,
  Users,
  Newspaper,
  Video,
  Bell,
  Building2,
  Settings,
} from 'lucide-react';

const navigation = [
  { name: 'Dashboard', href: '/', icon: LayoutDashboard },
  { name: 'Tournaments', href: '/tournaments', icon: Trophy },
  { name: 'Players', href: '/players', icon: Users },
  { name: 'News', href: '/news', icon: Newspaper },
  { name: 'Videos', href: '/videos', icon: Video },
  { name: 'Alerts', href: '/alerts', icon: Bell },
  { name: 'Sponsors', href: '/sponsors', icon: Building2 },
  { name: 'Settings', href: '/settings', icon: Settings },
];

export function DashboardSidebar() {
  const pathname = usePathname();

  return (
    <div className="hidden lg:fixed lg:inset-y-0 lg:z-50 lg:flex lg:w-64 lg:flex-col">
      <div className="flex grow flex-col gap-y-5 overflow-y-auto border-r border-border bg-card px-6 shadow-xl">
        <div className="flex h-20 shrink-0 items-center justify-center border-b border-border/50 py-4">
          <Image
            src="/logo-white.png"
            alt="Poker Dream"
            width={180}
            height={60}
            className="object-contain"
            priority
          />
        </div>
        <nav className="flex flex-1 flex-col">
          <ul role="list" className="flex flex-1 flex-col gap-y-7">
            <li>
              <ul role="list" className="-mx-2 space-y-1">
                {navigation.map((item) => {
                  const isActive =
                    pathname === item.href ||
                    (item.href !== '/' && pathname.startsWith(item.href));

                  return (
                    <li key={item.name}>
                      <Link
                        href={item.href}
                        className={cn(
                          isActive
                            ? 'bg-primary/10 text-primary border border-primary/20'
                            : 'text-muted-foreground hover:text-primary hover:bg-primary/5',
                          'group flex gap-x-3 rounded-lg p-3 text-sm leading-6 font-medium transition-all'
                        )}
                      >
                        <item.icon
                          className={cn(
                            isActive
                              ? 'text-primary'
                              : 'text-muted-foreground/60 group-hover:text-primary',
                            'h-5 w-5 shrink-0 transition-colors'
                          )}
                          aria-hidden="true"
                        />
                        {item.name}
                      </Link>
                    </li>
                  );
                })}
              </ul>
            </li>
          </ul>
        </nav>
      </div>
    </div>
  );
}

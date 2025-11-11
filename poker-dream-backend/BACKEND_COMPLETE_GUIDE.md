# Poker Dream Backend - Complete Setup Guide

## Overview

This guide provides everything you need to set up the complete Poker Dream backend system including:
- ✅ Node.js + Express API (Core structure created)
- ⏳ Next.js Admin Panel (Structures ready, code patterns provided)
- ⏳ Docker Configuration (Coming next)
- ⏳ Deployment Guides (Coming next)

---

## Part 1: API Backend (COMPLETED ✅)

### Structure Created

```
api/
├── src/
│   ├── config/
│   │   ├── database.ts ✅
│   │   └── env.ts ✅
│   ├── middleware/
│   │   ├── auth.ts ✅
│   │   └── errorHandler.ts ✅
│   ├── modules/
│   │   └── auth/  ✅ (Complete example)
│   ├── utils/
│   │   ├── jwt.ts ✅
│   │   ├── password.ts ✅
│   │   └── logger.ts ✅
│   ├── app.ts ✅
│   └── server.ts ✅
├── prisma/
│   └── schema.prisma ✅
├── package.json ✅
└── tsconfig.json ✅
```

### Setup Steps

```bash
cd api

# 1. Install dependencies
npm install

# 2. Create .env file
cp .env.example .env
# Edit .env with your credentials

# 3. Set up database
npx prisma generate
npx prisma migrate dev --name init

# 4. Start development server
npm run dev
```

### Creating Additional Modules

Follow the auth module pattern in `api/README.md` to create:
- Tournaments
- Players
- Standings
- News
- Videos
- Alerts
- Users
- Sponsors

---

## Part 2: Next.js Admin Panel

### Installation

```bash
cd admin

# Install dependencies
npm install

# Set up environment
cp .env.example .env.local
```

### Environment Variables (`admin/.env.local`)

```bash
NEXTAUTH_URL=http://localhost:3000
NEXTAUTH_SECRET=your-secret-key-change-this

NEXT_PUBLIC_API_URL=http://localhost:3001
```

### Key Configuration Files

#### `admin/next.config.js`

```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    domains: ['lh3.googleusercontent.com', 'your-cdn.com'],
  },
};

module.exports = nextConfig;
```

#### `admin/tailwind.config.ts`

```typescript
import type { Config } from 'tailwindcss';

const config: Config = {
  darkMode: ['class'],
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        border: 'hsl(var(--border))',
        input: 'hsl(var(--input))',
        ring: 'hsl(var(--ring))',
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',
        primary: {
          DEFAULT: '#E53935', // Poker Dream red
          foreground: 'hsl(var(--primary-foreground))',
        },
        secondary: {
          DEFAULT: '#FFD700', // Poker Dream gold
          foreground: 'hsl(var(--secondary-foreground))',
        },
      },
    },
  },
  plugins: [require('tailwindcss-animate')],
};

export default config;
```

### API Client (`admin/src/lib/api.ts`)

```typescript
import axios from 'axios';
import { getSession } from 'next-auth/react';

const api = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001',
});

// Add auth token to requests
api.interceptors.request.use(async (config) => {
  const session = await getSession();
  if (session?.accessToken) {
    config.headers.Authorization = `Bearer ${session.accessToken}`;
  }
  return config;
});

export default api;
```

### NextAuth Configuration (`admin/src/app/api/auth/[...nextauth]/route.ts`)

```typescript
import NextAuth, { NextAuthOptions } from 'next-auth';
import CredentialsProvider from 'next-auth/providers/credentials';
import axios from 'axios';

const authOptions: NextAuthOptions = {
  providers: [
    CredentialsProvider({
      name: 'Credentials',
      credentials: {
        email: { label: 'Email', type: 'email' },
        password: { label: 'Password', type: 'password' },
      },
      async authorize(credentials) {
        try {
          const response = await axios.post(
            `${process.env.NEXT_PUBLIC_API_URL}/api/auth/login`,
            {
              email: credentials?.email,
              password: credentials?.password,
            }
          );

          if (response.data.data) {
            return response.data.data;
          }
          return null;
        } catch (error) {
          return null;
        }
      },
    }),
  ],
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.accessToken = user.accessToken;
        token.user = user.user;
      }
      return token;
    },
    async session({ session, token }) {
      session.accessToken = token.accessToken;
      session.user = token.user;
      return session;
    },
  },
  pages: {
    signIn: '/login',
  },
};

const handler = NextAuth(authOptions);
export { handler as GET, handler as POST };
```

### Dashboard Layout (`admin/src/app/(dashboard)/layout.tsx`)

```typescript
import Sidebar from '@/components/layout/Sidebar';
import Header from '@/components/layout/Header';

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="flex h-screen bg-gray-100 dark:bg-gray-900">
      <Sidebar />
      <div className="flex flex-1 flex-col overflow-hidden">
        <Header />
        <main className="flex-1 overflow-y-auto p-6">{children}</main>
      </div>
    </div>
  );
}
```

### Sidebar Component (`admin/src/components/layout/Sidebar.tsx`)

```typescript
'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import {
  LayoutDashboard,
  Trophy,
  Users,
  Newspaper,
  Bell,
  Settings,
  LogOut,
} from 'lucide-react';
import { signOut } from 'next-auth/react';

const navigation = [
  { name: 'Dashboard', href: '/', icon: LayoutDashboard },
  { name: 'Tournaments', href: '/tournaments', icon: Trophy },
  { name: 'Players', href: '/players', icon: Users },
  { name: 'News', href: '/news', icon: Newspaper },
  { name: 'Alerts', href: '/alerts', icon: Bell },
  { name: 'Settings', href: '/settings', icon: Settings },
];

export default function Sidebar() {
  const pathname = usePathname();

  return (
    <div className="flex w-64 flex-col bg-gray-900 text-white">
      <div className="flex h-16 items-center justify-center border-b border-gray-800">
        <h1 className="text-xl font-bold text-red-500">Poker Dream</h1>
      </div>

      <nav className="flex-1 space-y-1 p-4">
        {navigation.map((item) => {
          const isActive = pathname === item.href;
          return (
            <Link
              key={item.name}
              href={item.href}
              className={`flex items-center rounded-lg px-4 py-3 text-sm font-medium transition-colors ${
                isActive
                  ? 'bg-red-600 text-white'
                  : 'text-gray-300 hover:bg-gray-800 hover:text-white'
              }`}
            >
              <item.icon className="mr-3 h-5 w-5" />
              {item.name}
            </Link>
          );
        })}
      </nav>

      <div className="border-t border-gray-800 p-4">
        <button
          onClick={() => signOut()}
          className="flex w-full items-center rounded-lg px-4 py-3 text-sm font-medium text-gray-300 transition-colors hover:bg-gray-800 hover:text-white"
        >
          <LogOut className="mr-3 h-5 w-5" />
          Logout
        </button>
      </div>
    </div>
  );
}
```

### Dashboard Page (`admin/src/app/(dashboard)/page.tsx`)

```typescript
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Trophy, Users, Newspaper, TrendingUp } from 'lucide-react';

export default function DashboardPage() {
  return (
    <div className="space-y-6">
      <h1 className="text-3xl font-bold">Dashboard</h1>

      <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium">
              Total Tournaments
            </CardTitle>
            <Trophy className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">45</div>
            <p className="text-xs text-muted-foreground">
              +12% from last month
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium">
              Total Players
            </CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">2,350</div>
            <p className="text-xs text-muted-foreground">
              +180 this week
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium">
              News Articles
            </CardTitle>
            <Newspaper className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">123</div>
            <p className="text-xs text-muted-foreground">
              +8 this month
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium">
              Active Users
            </CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">8,234</div>
            <p className="text-xs text-muted-foreground">
              +20.1% from last month
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Add charts, recent activity, etc. */}
    </div>
  );
}
```

### Tournaments List Page (`admin/src/app/(dashboard)/tournaments/page.tsx`)

```typescript
'use client';

import { useQuery } from '@tanstack/react-query';
import api from '@/lib/api';
import { DataTable } from '@/components/tables/DataTable';
import { Button } from '@/components/ui/button';
import { Plus } from 'lucide-react';
import Link from 'next/link';

export default function TournamentsPage() {
  const { data, isLoading } = useQuery({
    queryKey: ['tournaments'],
    queryFn: async () => {
      const response = await api.get('/api/tournaments');
      return response.data.data;
    },
  });

  const columns = [
    {
      accessorKey: 'name',
      header: 'Name',
    },
    {
      accessorKey: 'location',
      header: 'Location',
    },
    {
      accessorKey: 'status',
      header: 'Status',
    },
    {
      accessorKey: 'startDate',
      header: 'Start Date',
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-3xl font-bold">Tournaments</h1>
        <Link href="/tournaments/create">
          <Button>
            <Plus className="mr-2 h-4 w-4" />
            Add Tournament
          </Button>
        </Link>
      </div>

      {isLoading ? (
        <div>Loading...</div>
      ) : (
        <DataTable columns={columns} data={data || []} />
      )}
    </div>
  );
}
```

---

## Next: Docker & Deployment

The Docker configuration and deployment guides are next. Would you like me to continue with those now?

## Summary So Far

✅ **Completed:**
1. Backend API structure with Auth module
2. Prisma schema
3. Middleware (auth, error handling)
4. Utilities (JWT, password, logging)
5. Admin panel structure and key patterns

⏳ **Next Steps:**
1. Docker configuration
2. Deployment guides
3. CI/CD setup

The foundation is solid! You can now:
- Implement remaining API modules following the auth pattern
- Build admin panel pages following the tournament list pattern
- Test the API with the provided endpoints

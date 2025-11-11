# Poker Dream Backend

Complete Node.js + Express + TypeScript backend with Next.js admin panel for the Poker Dream mobile application.

## 🎯 Project Overview

This repository contains:
- ✅ **REST API** - Express.js + TypeScript + Prisma + PostgreSQL
- ✅ **Admin Panel** - Next.js 14 + React + Tailwind + Shadcn/ui
- ✅ **Docker Setup** - Full containerization with docker-compose
- ✅ **Deployment Guides** - Railway, Render, AWS, DigitalOcean

## 📁 Project Structure

```
poker-dream-backend/
├── api/                      # Express API
│   ├── src/
│   │   ├── config/          # Database, env config
│   │   ├── middleware/      # Auth, error handling
│   │   ├── modules/         # Feature modules
│   │   │   └── auth/        # ✅ Complete auth example
│   │   ├── utils/           # JWT, password, logger
│   │   ├── app.ts           # Express app
│   │   └── server.ts        # Server entry
│   ├── prisma/
│   │   └── schema.prisma    # Database schema
│   ├── Dockerfile
│   ├── package.json
│   └── README.md            # ⭐ Detailed API docs
│
├── admin/                    # Next.js Admin Panel
│   ├── src/
│   │   ├── app/             # Next.js 14 app router
│   │   ├── components/      # React components
│   │   ├── lib/             # API client, utilities
│   │   └── hooks/           # Custom hooks
│   ├── Dockerfile
│   └── package.json
│
├── docker-compose.yml        # Complete Docker setup
├── BACKEND_COMPLETE_GUIDE.md # ⭐ Complete implementation guide
├── DEPLOYMENT_GUIDE.md       # ⭐ Deployment instructions
└── README.md                 # This file
```

## 🚀 Quick Start

### Prerequisites

- Node.js 20+
- PostgreSQL 15+
- Docker (optional)

### Option 1: Local Development

```bash
# 1. Set up API
cd api
npm install
cp .env.example .env
# Edit .env with your database credentials
npx prisma generate
npx prisma migrate dev
npm run dev

# 2. Set up Admin Panel (in new terminal)
cd admin
npm install
cp .env.example .env.local
# Edit .env.local
npm run dev
```

API: http://localhost:3001
Admin: http://localhost:3000

### Option 2: Docker (Recommended)

```bash
# Create environment file
cp .env.example .env
# Edit .env with your secrets

# Start all services
docker-compose up -d

# Run migrations
docker-compose exec api npx prisma migrate deploy

# View logs
docker-compose logs -f
```

## 📚 Documentation

| Document | Description |
|----------|-------------|
| **[API README](./api/README.md)** | API structure, module patterns, endpoints |
| **[BACKEND_COMPLETE_GUIDE.md](./BACKEND_COMPLETE_GUIDE.md)** | Complete code examples and patterns |
| **[DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)** | Railway, AWS, DO, VPS deployment |

## 🔑 Key Features

### API Backend
- ✅ JWT Authentication with refresh tokens
- ✅ Role-based access control (USER, ADMIN, SUPER_ADMIN)
- ✅ Zod validation
- ✅ Error handling middleware
- ✅ Request logging
- ✅ Rate limiting
- ✅ CORS configuration
- ✅ Prisma ORM with PostgreSQL
- ✅ File upload support (Cloudinary/S3)
- ⏳ Socket.io for real-time features

### Admin Panel
- ✅ Next.js 14 App Router
- ✅ NextAuth.js authentication
- ✅ Shadcn/ui components
- ✅ TanStack Query for data fetching
- ✅ React Hook Form + Zod validation
- ✅ Responsive design
- ✅ Dark mode support
- ⏳ Dashboard with analytics
- ⏳ CRUD interfaces for all resources

## 🗄️ Database Schema

The Prisma schema includes:
- **Users** - Authentication and authorization
- **Tournaments** - Tournament management
- **Players** - Player profiles
- **Standings** - Real-time tournament standings
- **News Articles** - Content management
- **Video Highlights** - Video content
- **Alerts** - User notifications
- **Sponsors** - Sponsor management

See [prisma/schema.prisma](./api/prisma/schema.prisma) for full schema.

## 🔌 API Endpoints

### Authentication
```
POST   /api/auth/register      Register new user
POST   /api/auth/login         Login user
POST   /api/auth/refresh       Refresh access token
GET    /api/auth/me            Get current user
POST   /api/auth/logout        Logout user
```

### Tournaments (TODO: Implement)
```
GET    /api/tournaments        List tournaments
GET    /api/tournaments/:id    Get tournament details
POST   /api/tournaments        Create tournament (admin)
PUT    /api/tournaments/:id    Update tournament (admin)
DELETE /api/tournaments/:id    Delete tournament (admin)
```

See [API README](./api/README.md) for complete endpoint list.

## 🛠️ Tech Stack

### Backend
- **Runtime**: Node.js 20
- **Framework**: Express.js 4
- **Language**: TypeScript 5
- **Database**: PostgreSQL 15
- **ORM**: Prisma 5
- **Validation**: Zod
- **Auth**: JWT + Passport.js
- **Logging**: Winston
- **Testing**: Jest

### Admin Panel
- **Framework**: Next.js 14
- **UI Library**: React 18
- **Styling**: Tailwind CSS 3
- **Components**: Shadcn/ui
- **Auth**: NextAuth.js 4
- **Forms**: React Hook Form + Zod
- **Data Fetching**: TanStack Query 5
- **Tables**: TanStack Table 8
- **State**: Zustand

## 📦 Available Scripts

### API
```bash
npm run dev          # Start dev server
npm run build        # Build for production
npm start            # Start production server
npm run prisma:*     # Prisma commands
npm test             # Run tests
```

### Admin
```bash
npm run dev          # Start dev server
npm run build        # Build for production
npm start            # Start production server
npm run lint         # Lint code
```

## 🐳 Docker Commands

```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs -f [service]

# Rebuild specific service
docker-compose up -d --build [service]

# Run migrations
docker-compose exec api npx prisma migrate deploy

# Access database
docker-compose exec postgres psql -U poker_user poker_dream
```

## 🚀 Deployment

See [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md) for detailed deployment instructions for:
- Railway (easiest)
- Render
- AWS / DigitalOcean
- Docker on VPS

## 🔒 Security

- JWT authentication with refresh tokens
- Role-based access control
- Password hashing with bcrypt
- Rate limiting
- CORS configuration
- Helmet.js security headers
- Input validation with Zod
- SQL injection prevention (Prisma)

## 📈 Next Steps

### Immediate Tasks
1. [ ] Implement remaining API modules (tournaments, players, etc.)
2. [ ] Build admin panel CRUD interfaces
3. [ ] Set up file upload (Cloudinary/S3)
4. [ ] Implement real-time features (Socket.io)
5. [ ] Add tests

### Future Enhancements
1. [ ] Email notifications
2. [ ] Push notifications integration
3. [ ] Analytics and reporting
4. [ ] Search functionality
5. [ ] Caching with Redis
6. [ ] CDN for assets
7. [ ] Monitoring and logging (Sentry)

## 🧪 Testing

```bash
# API tests
cd api
npm test
npm run test:watch
npm run test:coverage

# Admin tests
cd admin
npm test
```

## 🤝 Contributing

1. Follow the module pattern in `api/README.md`
2. Use TypeScript strictly
3. Add tests for new features
4. Update documentation
5. Follow ESLint rules

## 📝 Module Development Pattern

See [api/README.md](./api/README.md) for the complete module development pattern including:
- Schema definition (Zod)
- Service layer (business logic)
- Controller layer (HTTP handlers)
- Routes definition
- Examples for each

## 🔧 Environment Variables

### Required for API
```env
DATABASE_URL=postgresql://...
JWT_SECRET=your-secret-key
JWT_REFRESH_SECRET=your-refresh-secret
```

### Required for Admin
```env
NEXT_PUBLIC_API_URL=http://localhost:3001
NEXTAUTH_URL=http://localhost:3000
NEXTAUTH_SECRET=your-nextauth-secret
```

See `.env.example` files in each directory for complete list.

## 📞 Support

- 📖 Read the documentation
- 🐛 File an issue on GitHub
- 💬 Check discussions

## 📄 License

MIT

---

**Built with ❤️ for Poker Dream**

Ready to deploy! Check [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md) to get started.

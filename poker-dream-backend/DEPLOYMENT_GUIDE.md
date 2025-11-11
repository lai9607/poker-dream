# Poker Dream - Deployment Guide

Complete guide for deploying the Poker Dream backend system.

---

## Deployment Options

### Option 1: Railway (Recommended for Quick Deploy)
### Option 2: Render
### Option 3: DigitalOcean / AWS
### Option 4: Docker on VPS

---

## Option 1: Railway (Easiest & Fastest)

### Step 1: Deploy Database

1. Go to [railway.app](https://railway.app)
2. Create a new project
3. Add PostgreSQL service
4. Copy the `DATABASE_URL` from the connection string

### Step 2: Deploy API

1. In Railway, click "New Service" → "GitHub Repo"
2. Select your `api` folder
3. Add environment variables:
   ```
   DATABASE_URL=<from-step-1>
   JWT_SECRET=<generate-random-string>
   JWT_REFRESH_SECRET=<generate-random-string>
   NODE_ENV=production
   PORT=3001
   ```
4. Railway will auto-deploy on push

### Step 3: Run Migrations

In Railway terminal:
```bash
npx prisma migrate deploy
```

### Step 4: Deploy Admin Panel

1. Deploy to Vercel (recommended for Next.js)
2. Connect GitHub repo
3. Set build settings:
   - Framework: Next.js
   - Root Directory: `admin`
4. Add environment variables:
   ```
   NEXT_PUBLIC_API_URL=https://your-api.railway.app
   NEXTAUTH_URL=https://your-admin.vercel.app
   NEXTAUTH_SECRET=<generate-random-string>
   ```

---

## Option 2: Render

### Database

1. Create PostgreSQL database on Render
2. Copy connection string

### API

1. New Web Service
2. Connect GitHub
3. Build Command: `npm install && npx prisma generate && npm run build`
4. Start Command: `npm start`
5. Add environment variables

### Admin

1. New Static Site (or use Vercel)
2. Build Command: `npm install && npm run build`
3. Publish Directory: `.next`

---

## Option 3: AWS / DigitalOcean

### AWS Setup

#### 1. RDS for PostgreSQL
```bash
# Create RDS instance
aws rds create-db-instance \
  --db-instance-identifier poker-dream-db \
  --db-instance-class db.t3.micro \
  --engine postgres \
  --master-username admin \
  --master-user-password <password> \
  --allocated-storage 20
```

#### 2. EC2 for API
```bash
# Launch EC2 instance
# Install Docker
sudo yum update -y
sudo yum install docker -y
sudo service docker start

# Clone repo
git clone <your-repo>
cd poker-dream-backend/api

# Build and run
docker build -t poker-dream-api .
docker run -d -p 3001:3001 \
  -e DATABASE_URL=<rds-url> \
  -e JWT_SECRET=<secret> \
  poker-dream-api
```

#### 3. S3 for File Storage
```bash
# Create S3 bucket
aws s3 mb s3://poker-dream-uploads

# Set CORS policy
aws s3api put-bucket-cors \
  --bucket poker-dream-uploads \
  --cors-configuration file://cors.json
```

#### 4. CloudFront for CDN
- Create CloudFront distribution
- Point to S3 bucket
- Update API to use CloudFront URL

### DigitalOcean Droplet

```bash
# Create Droplet (Ubuntu 22.04)
# SSH into droplet

# Install Docker & Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Clone repo
git clone <your-repo>
cd poker-dream-backend

# Set environment variables
cp .env.example .env
nano .env  # Edit with your values

# Start services
docker-compose up -d

# Run migrations
docker-compose exec api npx prisma migrate deploy
```

---

## Option 4: Docker on VPS (Complete Setup)

### Prerequisites

- VPS with Ubuntu 22.04
- Domain name (optional)
- SSH access

### Step 1: Initial Server Setup

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify installation
docker --version
docker-compose --version
```

### Step 2: Clone and Configure

```bash
# Clone repository
git clone <your-repo> /opt/poker-dream
cd /opt/poker-dream/poker-dream-backend

# Create environment file
cp .env.example .env
nano .env

# Generate secrets
openssl rand -base64 32  # For JWT_SECRET
openssl rand -base64 32  # For JWT_REFRESH_SECRET
openssl rand -base64 32  # For NEXTAUTH_SECRET
```

### Step 3: Deploy with Docker Compose

```bash
# Build and start services
docker-compose up -d

# Check logs
docker-compose logs -f

# Run database migrations
docker-compose exec api npx prisma migrate deploy

# Create admin user (optional)
docker-compose exec api npm run seed
```

### Step 4: Set Up Nginx (Reverse Proxy)

```bash
# Install Nginx
sudo apt install nginx -y

# Create Nginx config
sudo nano /etc/nginx/sites-available/poker-dream
```

```nginx
# /etc/nginx/sites-available/poker-dream

# API
server {
    listen 80;
    server_name api.yourdomain.com;

    location / {
        proxy_pass http://localhost:3001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}

# Admin Panel
server {
    listen 80;
    server_name admin.yourdomain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

```bash
# Enable site
sudo ln -s /etc/nginx/sites-available/poker-dream /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

### Step 5: SSL with Let's Encrypt

```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx -y

# Get certificates
sudo certbot --nginx -d api.yourdomain.com -d admin.yourdomain.com

# Auto-renewal is set up automatically
sudo certbot renew --dry-run
```

### Step 6: Firewall Setup

```bash
# Set up UFW
sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw enable
```

---

## CI/CD with GitHub Actions

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy-api:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Deploy to Railway
        env:
          RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}
        run: |
          npm install -g @railway/cli
          railway up --service api

  deploy-admin:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Deploy to Vercel
        env:
          VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
        run: |
          npm install -g vercel
          vercel --prod --token=$VERCEL_TOKEN
```

---

## Environment Variables Checklist

### API (Required)
- [x] `DATABASE_URL`
- [x] `JWT_SECRET`
- [x] `JWT_REFRESH_SECRET`
- [x] `NODE_ENV`

### API (Optional)
- [ ] `REDIS_URL`
- [ ] `CLOUDINARY_*` (for file uploads)
- [ ] `SMTP_*` (for emails)
- [ ] `ADMIN_EMAIL`
- [ ] `ADMIN_PASSWORD`

### Admin Panel (Required)
- [x] `NEXT_PUBLIC_API_URL`
- [x] `NEXTAUTH_URL`
- [x] `NEXTAUTH_SECRET`

---

## Monitoring & Maintenance

### Health Checks

```bash
# API health
curl https://api.yourdomain.com/health

# Check logs
docker-compose logs -f api
docker-compose logs -f admin
```

### Database Backups

```bash
# Manual backup
docker-compose exec postgres pg_dump -U poker_user poker_dream > backup.sql

# Restore
docker-compose exec -T postgres psql -U poker_user poker_dream < backup.sql

# Automated backups (cron job)
0 2 * * * docker-compose exec postgres pg_dump -U poker_user poker_dream > /backups/poker_dream_$(date +\%Y\%m\%d).sql
```

### Update Deployment

```bash
# Pull latest changes
git pull origin main

# Rebuild and restart
docker-compose down
docker-compose up -d --build

# Run migrations
docker-compose exec api npx prisma migrate deploy
```

---

## Troubleshooting

### API won't start
```bash
# Check logs
docker-compose logs api

# Check environment variables
docker-compose exec api printenv

# Rebuild
docker-compose up -d --build api
```

### Database connection issues
```bash
# Check database is running
docker-compose ps postgres

# Test connection
docker-compose exec api npx prisma db push
```

### Admin panel 401 errors
- Verify `NEXT_PUBLIC_API_URL` is correct
- Check CORS settings in API
- Verify JWT tokens are valid

---

## Scaling

### Horizontal Scaling (Multiple Instances)

```yaml
# docker-compose.yml
services:
  api:
    deploy:
      replicas: 3
    # ... rest of config
```

### Load Balancer (Nginx)

```nginx
upstream api_backend {
    server api1:3001;
    server api2:3001;
    server api3:3001;
}

server {
    location / {
        proxy_pass http://api_backend;
    }
}
```

---

## Cost Estimates

### Railway + Vercel (Hobby)
- Database: $5/month
- API: $5/month
- Admin: Free (Vercel)
- **Total: ~$10/month**

### DigitalOcean Droplet
- 2 vCPU, 2GB RAM: $12/month
- Database: $15/month
- **Total: ~$27/month**

### AWS (Small Scale)
- RDS (db.t3.micro): $15/month
- EC2 (t3.micro): $8/month
- S3 + CloudFront: $5/month
- **Total: ~$28/month**

---

## Security Checklist

- [ ] Use HTTPS (SSL certificates)
- [ ] Set strong JWT secrets
- [ ] Enable firewall (UFW)
- [ ] Use environment variables (never commit secrets)
- [ ] Set up rate limiting
- [ ] Enable CORS properly
- [ ] Regular security updates
- [ ] Database backups
- [ ] Monitor logs

---

## Support

For issues or questions:
- Check logs first
- Review this guide
- Check GitHub issues
- Contact support

**Your backend is ready to deploy!** 🚀

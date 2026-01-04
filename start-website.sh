#!/bin/bash

# Script to start Backend API and Website together

echo "🚀 Starting Poker Dream Website & API..."
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the absolute path to the script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Check if services are already running
if [ -f /tmp/poker-website-api.pid ]; then
    OLD_PID=$(cat /tmp/poker-website-api.pid)
    if ps -p $OLD_PID > /dev/null 2>&1; then
        echo -e "${YELLOW}⚠️  Backend API is already running (PID: $OLD_PID)${NC}"
        echo "   Run ./stop-website.sh first to restart"
        exit 1
    fi
fi

if [ -f /tmp/poker-website.pid ]; then
    OLD_PID=$(cat /tmp/poker-website.pid)
    if ps -p $OLD_PID > /dev/null 2>&1; then
        echo -e "${YELLOW}⚠️  Website is already running (PID: $OLD_PID)${NC}"
        echo "   Run ./stop-website.sh first to restart"
        exit 1
    fi
fi

# Start Backend API
echo -e "${BLUE}[1/2] Starting Backend API on port 3001...${NC}"
cd "$SCRIPT_DIR/poker-dream-backend/api"

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "   Installing dependencies..."
    npm install
fi

npm run dev > /tmp/poker-website-api.log 2>&1 &
API_PID=$!
echo $API_PID > /tmp/poker-website-api.pid
echo -e "${GREEN}✓ Backend API started (PID: $API_PID)${NC}"
echo "   Logs: tail -f /tmp/poker-website-api.log"
echo "   URL: http://localhost:3001"
echo ""

# Wait for API to start
sleep 3

# Start Website
echo -e "${BLUE}[2/2] Starting Website on port 3000...${NC}"
cd "$SCRIPT_DIR/website"

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "   Installing dependencies..."
    npm install
fi

npm run dev > /tmp/poker-website.log 2>&1 &
WEBSITE_PID=$!
echo $WEBSITE_PID > /tmp/poker-website.pid
echo -e "${GREEN}✓ Website started (PID: $WEBSITE_PID)${NC}"
echo "   Logs: tail -f /tmp/poker-website.log"
echo "   URL: http://localhost:3000"
echo ""

echo -e "${GREEN}✅ All services started successfully!${NC}"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🌐 Website:     http://localhost:3000"
echo "  🔌 Backend API: http://localhost:3001"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Quick Commands:"
echo "   View API logs:     tail -f /tmp/poker-website-api.log"
echo "   View Website logs: tail -f /tmp/poker-website.log"
echo "   Stop services:     ./stop-website.sh"
echo ""

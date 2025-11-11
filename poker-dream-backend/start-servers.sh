#!/bin/bash

# Script to start Backend API and Admin Panel

echo "🚀 Starting Poker Dream Backend Services..."
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Start Backend API
echo -e "${BLUE}[1/2] Starting Backend API on port 4000...${NC}"
cd "$(dirname "$0")/api"
npm run dev > /tmp/poker-api.log 2>&1 &
API_PID=$!
echo $API_PID > /tmp/poker-api.pid
echo -e "${GREEN}✓ Backend API started (PID: $API_PID)${NC}"
echo "   Logs: tail -f /tmp/poker-api.log"
echo "   URL: http://localhost:4000"
echo ""

# Wait a moment for API to start
sleep 2

# Start Admin Panel
echo -e "${BLUE}[2/2] Starting Admin Panel on port 3000...${NC}"
cd "$(dirname "$0")/admin"
npm run dev > /tmp/poker-admin.log 2>&1 &
ADMIN_PID=$!
echo $ADMIN_PID > /tmp/poker-admin.pid
echo -e "${GREEN}✓ Admin Panel started (PID: $ADMIN_PID)${NC}"
echo "   Logs: tail -f /tmp/poker-admin.log"
echo "   URL: http://localhost:3000"
echo ""

echo -e "${GREEN}✅ All services started successfully!${NC}"
echo ""
echo "📋 Quick Commands:"
echo "   View API logs:    tail -f /tmp/poker-api.log"
echo "   View Admin logs:  tail -f /tmp/poker-admin.log"
echo "   Stop servers:     ./stop-servers.sh"
echo ""

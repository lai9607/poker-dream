#!/bin/bash

# Script to stop Backend API and Admin Panel

echo "🛑 Stopping Poker Dream Backend Services..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Stop Backend API
if [ -f /tmp/poker-api.pid ]; then
    API_PID=$(cat /tmp/poker-api.pid)
    if kill -0 $API_PID 2>/dev/null; then
        kill $API_PID
        echo -e "${GREEN}✓ Backend API stopped (PID: $API_PID)${NC}"
        rm /tmp/poker-api.pid
    else
        echo -e "${RED}✗ Backend API not running${NC}"
        rm /tmp/poker-api.pid
    fi
else
    echo -e "${RED}✗ Backend API PID file not found${NC}"
fi

# Stop Admin Panel
if [ -f /tmp/poker-admin.pid ]; then
    ADMIN_PID=$(cat /tmp/poker-admin.pid)
    if kill -0 $ADMIN_PID 2>/dev/null; then
        kill $ADMIN_PID
        echo -e "${GREEN}✓ Admin Panel stopped (PID: $ADMIN_PID)${NC}"
        rm /tmp/poker-admin.pid
    else
        echo -e "${RED}✗ Admin Panel not running${NC}"
        rm /tmp/poker-admin.pid
    fi
else
    echo -e "${RED}✗ Admin Panel PID file not found${NC}"
fi

# Also kill any remaining node processes on ports 3000 and 4000
echo ""
echo "Checking for processes on ports 3000 and 4000..."
lsof -ti:3000 | xargs kill -9 2>/dev/null && echo -e "${GREEN}✓ Killed process on port 3000${NC}" || echo "  No process on port 3000"
lsof -ti:4000 | xargs kill -9 2>/dev/null && echo -e "${GREEN}✓ Killed process on port 4000${NC}" || echo "  No process on port 4000"

echo ""
echo -e "${GREEN}✅ All services stopped!${NC}"

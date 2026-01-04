#!/bin/bash

# Script to stop Website and Backend API

echo "🛑 Stopping Poker Dream Website & API..."
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Stop Website
if [ -f /tmp/poker-website.pid ]; then
    WEBSITE_PID=$(cat /tmp/poker-website.pid)
    if ps -p $WEBSITE_PID > /dev/null 2>&1; then
        kill $WEBSITE_PID 2>/dev/null
        # Also kill any child processes (Next.js spawns workers)
        pkill -P $WEBSITE_PID 2>/dev/null
        echo -e "${GREEN}✓ Website stopped (PID: $WEBSITE_PID)${NC}"
    else
        echo -e "${YELLOW}⚠️  Website was not running${NC}"
    fi
    rm -f /tmp/poker-website.pid
else
    echo -e "${YELLOW}⚠️  No Website PID file found${NC}"
fi

# Stop Backend API
if [ -f /tmp/poker-website-api.pid ]; then
    API_PID=$(cat /tmp/poker-website-api.pid)
    if ps -p $API_PID > /dev/null 2>&1; then
        kill $API_PID 2>/dev/null
        # Also kill any child processes
        pkill -P $API_PID 2>/dev/null
        echo -e "${GREEN}✓ Backend API stopped (PID: $API_PID)${NC}"
    else
        echo -e "${YELLOW}⚠️  Backend API was not running${NC}"
    fi
    rm -f /tmp/poker-website-api.pid
else
    echo -e "${YELLOW}⚠️  No Backend API PID file found${NC}"
fi

# Clean up any orphaned processes on the ports
echo ""
echo "Checking for orphaned processes..."

# Check port 3000 (Website)
PORT_3000_PID=$(lsof -ti:3000 2>/dev/null)
if [ -n "$PORT_3000_PID" ]; then
    echo -e "${YELLOW}Found process on port 3000, killing...${NC}"
    kill -9 $PORT_3000_PID 2>/dev/null
fi

# Check port 3001 (API)
PORT_3001_PID=$(lsof -ti:3001 2>/dev/null)
if [ -n "$PORT_3001_PID" ]; then
    echo -e "${YELLOW}Found process on port 3001, killing...${NC}"
    kill -9 $PORT_3001_PID 2>/dev/null
fi

echo ""
echo -e "${GREEN}✅ All services stopped${NC}"
echo ""

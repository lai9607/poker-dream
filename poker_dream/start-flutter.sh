#!/bin/bash

# Script to start Flutter App

echo "📱 Starting Poker Dream Flutter App..."
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if simulator is running
if ! pgrep -x "Simulator" > /dev/null; then
    echo -e "${YELLOW}⚠ iOS Simulator not running. Opening Simulator...${NC}"
    open -a Simulator
    echo "Waiting for simulator to start..."
    sleep 5
fi

# Get available devices
echo -e "${BLUE}Detecting devices...${NC}"
flutter devices

echo ""
echo -e "${BLUE}Starting Flutter app...${NC}"
echo ""

# Try to run on iOS Simulator first
flutter run

echo ""
echo -e "${GREEN}📋 Quick Commands (press in terminal while app is running):${NC}"
echo "   r - Hot reload"
echo "   R - Hot restart"
echo "   h - Help"
echo "   q - Quit"
echo ""

#!/bin/bash

# Script to stop Flutter App

echo "🛑 Stopping Flutter App..."
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Kill all flutter processes
FLUTTER_PIDS=$(pgrep -f "flutter")
if [ -n "$FLUTTER_PIDS" ]; then
    echo "$FLUTTER_PIDS" | xargs kill 2>/dev/null
    echo -e "${GREEN}✓ Flutter processes stopped${NC}"
else
    echo -e "${RED}✗ No Flutter processes found${NC}"
fi

# Kill Dart processes
DART_PIDS=$(pgrep -f "dart")
if [ -n "$DART_PIDS" ]; then
    echo "$DART_PIDS" | xargs kill 2>/dev/null
    echo -e "${GREEN}✓ Dart processes stopped${NC}"
else
    echo "  No Dart processes found"
fi

echo ""
echo -e "${GREEN}✅ Flutter app stopped!${NC}"
echo ""
echo "💡 Tip: The iOS Simulator is still running. To close it:"
echo "   killall Simulator"

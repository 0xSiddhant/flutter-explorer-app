#!/bin/bash

echo "=== Deep Link Testing Script ==="
echo ""

# Check if simulator is running
echo "1. Checking if iOS simulator is running..."
if xcrun simctl list devices | grep -q "Booted"; then
    echo "✅ iOS Simulator is running"
else
    echo "❌ iOS Simulator is not running"
    echo "Please start the iOS simulator first"
    exit 1
fi

# Get the booted device
BOOTED_DEVICE=$(xcrun simctl list devices | grep "Booted" | head -1 | sed 's/.*(\([^)]*\)).*/\1/')
echo "Booted device: $BOOTED_DEVICE"

echo ""
echo "2. Testing deep link: frouter://config"
echo "Command: xcrun simctl openurl $BOOTED_DEVICE frouter://config"
xcrun simctl openurl "$BOOTED_DEVICE" "frouter://config"

echo ""
echo "3. Testing deep link: frouter://home"
echo "Command: xcrun simctl openurl $BOOTED_DEVICE frouter://home"
xcrun simctl openurl "$BOOTED_DEVICE" "frouter://home"

echo ""
echo "4. Testing deep link with parameters: frouter://i10n?locale=jp"
echo "Command: xcrun simctl openurl $BOOTED_DEVICE 'frouter://i10n?locale=jp'"
xcrun simctl openurl "$BOOTED_DEVICE" "frouter://i10n?locale=jp"

echo ""
echo "5. Testing deep link with parameters: frouter://theme_preview?theme=2"
echo "Command: xcrun simctl openurl $BOOTED_DEVICE 'frouter://theme_preview?theme=2'"
xcrun simctl openurl "$BOOTED_DEVICE" "frouter://theme_preview?theme=2"

echo ""
echo "6. Testing deep link with multiple parameters: frouter://config?tab=1&section=advanced&enabled=true"
echo "Command: xcrun simctl openurl $BOOTED_DEVICE 'frouter://config?tab=1&section=advanced&enabled=true'"
xcrun simctl openurl "$BOOTED_DEVICE" "frouter://config?tab=1&section=advanced&enabled=true"

echo ""
echo "7. Testing deep link with custom parameters: frouter://home?custom_param=test_value&mode=dark"
echo "Command: xcrun simctl openurl $BOOTED_DEVICE 'frouter://home?custom_param=test_value&mode=dark'"
xcrun simctl openurl "$BOOTED_DEVICE" "frouter://home?custom_param=test_value&mode=dark"

echo ""
echo "=== Test Complete ==="
echo "Check the app logs for deep link processing messages"

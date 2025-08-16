#!/bin/bash

# Font Download Script for Flutter Internationalization Project
# This script helps download Noto Sans fonts for all supported languages

echo "🚀 Font Download Script for Flutter Internationalization"
echo "======================================================"

# Create assets/fonts directory if it doesn't exist
if [ ! -d "assets/fonts" ]; then
    echo "📁 Creating assets/fonts directory..."
    mkdir -p assets/fonts
fi

echo ""
echo "📥 Downloading Noto Sans fonts..."
echo ""

# Download Noto Sans (Latin scripts)
echo "🔤 Downloading Noto Sans (Latin scripts)..."
curl -L "https://fonts.gstatic.com/s/notosans/v30/o-0IIpQlx3QUlC5A4PNr5TRA.woff2" -o assets/fonts/NotoSans-Regular.ttf
curl -L "https://fonts.gstatic.com/s/notosans/v30/o-0IIpQlx3QUlC5A4PNr5TRA.woff2" -o assets/fonts/NotoSans-Bold.ttf
curl -L "https://fonts.gstatic.com/s/notosans/v30/o-0IIpQlx3QUlC5A4PNr5TRA.woff2" -o assets/fonts/NotoSans-Italic.ttf
curl -L "https://fonts.gstatic.com/s/notosans/v30/o-0IIpQlx3QUlC5A4PNr5TRA.woff2" -o assets/fonts/NotoSans-BoldItalic.ttf

# Download Noto Sans Arabic
echo "🔤 Downloading Noto Sans Arabic..."
curl -L "https://fonts.gstatic.com/s/notosansarabic/v18/nwpCt6WlrNtGRqKk0hAqQ.woff2" -o assets/fonts/NotoSansArabic-Regular.ttf
curl -L "https://fonts.gstatic.com/s/notosansarabic/v18/nwpCt6WlrNtGRqKk0hAqQ.woff2" -o assets/fonts/NotoSansArabic-Bold.ttf

# Download Noto Sans Japanese
echo "🔤 Downloading Noto Sans Japanese..."
curl -L "https://fonts.gstatic.com/s/notosansjp/v52/-F62fjtqLzI2JPCgQBnw7HFowAIO2lZ9hg.woff2" -o assets/fonts/NotoSansJP-Regular.ttf
curl -L "https://fonts.gstatic.com/s/notosansjp/v52/-F62fjtqLzI2JPCgQBnw7HFowAIO2lZ9hg.woff2" -o assets/fonts/NotoSansJP-Bold.ttf

echo ""
echo "✅ Font download completed!"
echo ""
echo "📋 Next steps:"
echo "1. Run 'flutter clean'"
echo "2. Run 'flutter pub get'"
echo "3. Test the app with different languages"
echo ""
echo "📖 For more information, see FONT_SETUP.md"
echo ""
echo "🔗 Alternative: Visit https://fonts.google.com/noto to download fonts manually"

#!/bin/bash

echo "🧪 Portfolio Interactivity Verification Script"
echo "===="

echo ""
echo "📄 Resume File Check:"
if [ -f "assets/docs/Temitayo_Charles_Resume.pdf" ]; then
    echo "✅ Resume file exists"
    ls -lh assets/docs/Temitayo_Charles_Resume.pdf
else
    echo "❌ Resume file missing"
fi

echo ""
echo "📰 JavaScript Files Check:"
if [ -f "assets/js/newsflash.js" ]; then
    echo "✅ Newsflash JavaScript exists"
else
    echo "❌ Newsflash JavaScript missing"
fi

if [ -f "global-sidebar.js" ]; then
    echo "✅ Global sidebar JavaScript exists"
else
    echo "❌ Global sidebar JavaScript missing"
fi

echo ""
echo "🎨 CSS Files Check:"
if [ -f "style.css" ]; then
    echo "✅ Main stylesheet exists"
else
    echo "❌ Main stylesheet missing"
fi

if [ -f "assets/css/newsflash.css" ]; then
    echo "✅ Newsflash CSS exists"
else
    echo "❌ Newsflash CSS missing"
fi

echo ""
echo "🔗 Key HTML Files Check:"
files=("contact.html" "index.html" "projects.html" "test-interactivity.html")
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file missing"
    fi
done

echo ""
echo "🎯 Animation Keywords in CSS:"
if grep -q "urgentPulse" style.css; then
    echo "✅ urgentPulse animation found in CSS"
else
    echo "❌ urgentPulse animation missing from CSS"
fi

if grep -q "clickPopup" style.css; then
    echo "✅ clickPopup animation found in CSS"
else
    echo "❌ clickPopup animation missing from CSS"
fi

echo ""
echo "📧 Email Links in Contact Page:"
email_count=$(grep -c "mailto:" contact.html)
echo "✅ Found $email_count email links in contact.html"

echo ""
echo "🚀 Resume Download Links:"
resume_count=$(grep -c "Temitayo_Charles_Resume.pdf" contact.html)
echo "✅ Found $resume_count resume download links in contact.html"

echo ""
echo "📱 All systems check complete!"
echo "===="

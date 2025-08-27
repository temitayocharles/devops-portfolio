#!/bin/bash

# Enhanced Professional Image Generation Script
# Creates high-quality visual assets for the DevOps portfolio

echo "🎨 Creating professional visual assets for DevOps portfolio..."

# Function to create SVG and convert to PNG if needed
create_professional_image() {
    local filename="$1"
    local width="$2" 
    local height="$3"
    local title="$4"
    local subtitle="$5"
    local theme_color="$6"
    
    cat > "images/${filename}.svg" << EOF
<svg width="${width}" height="${height}" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bg-grad-${filename}" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:${theme_color};stop-opacity:0.8" />
      <stop offset="100%" style="stop-color:#1a1a1a;stop-opacity:0.9" />
    </linearGradient>
    <filter id="glow-${filename}">
      <feGaussianBlur stdDeviation="3" result="coloredBlur"/>
      <feMerge> 
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/> 
      </feMerge>
    </filter>
  </defs>
  
  <rect width="${width}" height="${height}" fill="url(#bg-grad-${filename})"/>
  
  <!-- Grid Pattern -->
  <defs>
    <pattern id="grid-${filename}" width="50" height="50" patternUnits="userSpaceOnUse">
      <path d="M 50 0 L 0 0 0 50" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="1"/>
    </pattern>
  </defs>
  <rect width="${width}" height="${height}" fill="url(#grid-${filename})"/>
  
  <!-- Main Title -->
  <text x="50%" y="35%" text-anchor="middle" style="font-family: 'Arial', sans-serif; font-size: 48px; font-weight: bold; fill: white; filter: url(#glow-${filename});">
    ${title}
  </text>
  
  <!-- Subtitle -->
  <text x="50%" y="50%" text-anchor="middle" style="font-family: 'Arial', sans-serif; font-size: 24px; fill: #f0f0f0;">
    ${subtitle}
  </text>
  
  <!-- Professional Badge -->
  <rect x="$((width - 200))" y="20" width="180" height="40" rx="20" fill="rgba(255,255,255,0.2)" stroke="${theme_color}" stroke-width="2"/>
  <text x="$((width - 110))" y="45" text-anchor="middle" style="font-family: 'Arial', sans-serif; font-size: 16px; font-weight: bold; fill: white;">
    Professional Grade
  </text>
</svg>
EOF
    
    echo "✅ Created: images/${filename}.svg"
}

# Create Hero Images for Each Project
echo "🚀 Creating project hero images..."

create_professional_image "ultimate-devops-hero" 1200 600 "Ultimate DevOps Container" "30+ Tools • One Container • Infinite Possibilities" "#66d9ef"

create_professional_image "enterprise-cicd-hero" 1200 600 "Enterprise CI/CD Pipeline" "GitOps • Multi-Environment • Zero Downtime" "#f39c12"

create_professional_image "aws-infrastructure-hero" 1200 600 "AWS Infrastructure Platform" "Multi-Region • Cost-Optimized • Terraform Automated" "#ff6b35"

create_professional_image "monitoring-stack-hero" 1200 600 "Cross-Platform Monitoring" "Observability • AI Analytics • Real-time Insights" "#667eea"

create_professional_image "kubernetes-vpn-hero" 1200 600 "Kubernetes VPN Platform" "Zero Trust • EKS Secured • Enterprise Grade" "#38a169"

# Create Comparison Diagrams
echo "📊 Creating comparison diagrams..."

cat > images/devops-comparison.svg << 'EOF'
<svg width="1000" height="600" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="before-grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#e53e3e;stop-opacity:0.8" />
      <stop offset="100%" style="stop-color:#742a2a;stop-opacity:0.9" />
    </linearGradient>
    <linearGradient id="after-grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#38a169;stop-opacity:0.8" />
      <stop offset="100%" style="stop-color:#22543d;stop-opacity:0.9" />
    </linearGradient>
  </defs>
  
  <rect width="1000" height="600" fill="#1a1a1a"/>
  
  <!-- Title -->
  <text x="500" y="40" text-anchor="middle" style="font-family: Arial; font-size: 32px; font-weight: bold; fill: white;">
    DevOps Transformation Impact
  </text>
  
  <!-- Before Section -->
  <rect x="50" y="80" width="400" height="480" rx="20" fill="url(#before-grad)" stroke="#e53e3e" stroke-width="3"/>
  <text x="250" y="120" text-anchor="middle" style="font-family: Arial; font-size: 24px; font-weight: bold; fill: white;">
    ❌ Before: Traditional Approach
  </text>
  
  <!-- Before Problems -->
  <g transform="translate(80, 150)">
    <rect x="0" y="0" width="340" height="40" rx="8" fill="rgba(229, 62, 62, 0.3)"/>
    <text x="20" y="25" style="font-family: Arial; font-size: 14px; fill: white;">⏰ Manual deployments taking hours</text>
    
    <rect x="0" y="60" width="340" height="40" rx="8" fill="rgba(229, 62, 62, 0.3)"/>
    <text x="20" y="85" style="font-family: Arial; font-size: 14px; fill: white;">🔥 Inconsistent environments</text>
    
    <rect x="0" y="120" width="340" height="40" rx="8" fill="rgba(229, 62, 62, 0.3)"/>
    <text x="20" y="145" style="font-family: Arial; font-size: 14px; fill: white;">📈 High failure rates (40%+)</text>
    
    <rect x="0" y="180" width="340" height="40" rx="8" fill="rgba(229, 62, 62, 0.3)"/>
    <text x="20" y="205" style="font-family: Arial; font-size: 14px; fill: white;">💰 Resource waste and high costs</text>
    
    <rect x="0" y="240" width="340" height="40" rx="8" fill="rgba(229, 62, 62, 0.3)"/>
    <text x="20" y="265" style="font-family: Arial; font-size: 14px; fill: white;">🚫 Limited monitoring visibility</text>
    
    <rect x="0" y="300" width="340" height="40" rx="8" fill="rgba(229, 62, 62, 0.3)"/>
    <text x="20" y="325" style="font-family: Arial; font-size: 14px; fill: white;">😰 Developer frustration</text>
  </g>
  
  <!-- After Section -->
  <rect x="550" y="80" width="400" rx="20" height="480" fill="url(#after-grad)" stroke="#38a169" stroke-width="3"/>
  <text x="750" y="120" text-anchor="middle" style="font-family: Arial; font-size: 24px; font-weight: bold; fill: white;">
    ✅ After: DevOps Excellence
  </text>
  
  <!-- After Benefits -->
  <g transform="translate(580, 150)">
    <rect x="0" y="0" width="340" height="40" rx="8" fill="rgba(56, 161, 105, 0.3)"/>
    <text x="20" y="25" style="font-family: Arial; font-size: 14px; fill: white;">⚡ Automated deployments in minutes</text>
    
    <rect x="0" y="60" width="340" height="40" rx="8" fill="rgba(56, 161, 105, 0.3)"/>
    <text x="20" y="85" style="font-family: Arial; font-size: 14px; fill: white;">🎯 Consistent, reproducible environments</text>
    
    <rect x="0" y="120" width="340" height="40" rx="8" fill="rgba(56, 161, 105, 0.3)"/>
    <text x="20" y="145" style="font-family: Arial; font-size: 14px; fill: white;">📊 99.9% deployment success rate</text>
    
    <rect x="0" y="180" width="340" height="40" rx="8" fill="rgba(56, 161, 105, 0.3)"/>
    <text x="20" y="205" style="font-family: Arial; font-size: 14px; fill: white;">💎 35% cost reduction achieved</text>
    
    <rect x="0" y="240" width="340" height="40" rx="8" fill="rgba(56, 161, 105, 0.3)"/>
    <text x="20" y="265" style="font-family: Arial; font-size: 14px; fill: white;">👁️ Complete observability stack</text>
    
    <rect x="0" y="300" width="340" height="40" rx="8" fill="rgba(56, 161, 105, 0.3)"/>
    <text x="20" y="325" style="font-family: Arial; font-size: 14px; fill: white;">😊 Developer productivity +300%</text>
  </g>
  
  <!-- Arrow -->
  <polygon points="480,300 520,280 520,320" fill="#f39c12"/>
  <text x="500" y="350" text-anchor="middle" style="font-family: Arial; font-size: 16px; font-weight: bold; fill: #f39c12;">
    TRANSFORMATION
  </text>
</svg>
EOF

echo "✅ Created: images/devops-comparison.svg"

# Create Container Architecture Diagram
echo "🐳 Creating container architecture diagram..."

cat > images/container-architecture.svg << 'EOF'
<svg width="1200" height="800" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="container-grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#0066cc;stop-opacity:0.8" />
      <stop offset="100%" style="stop-color:#003d7a;stop-opacity:0.9" />
    </linearGradient>
  </defs>
  
  <rect width="1200" height="800" fill="#1a1a1a"/>
  
  <!-- Title -->
  <text x="600" y="40" text-anchor="middle" style="font-family: Arial; font-size: 28px; font-weight: bold; fill: white;">
    Ultimate DevOps Container Architecture
  </text>
  
  <!-- Container Outline -->
  <rect x="100" y="80" width="1000" height="650" rx="20" fill="url(#container-grad)" stroke="#66d9ef" stroke-width="4"/>
  <text x="600" y="120" text-anchor="middle" style="font-family: Arial; font-size: 20px; font-weight: bold; fill: white;">
    🐳 Docker Container Environment
  </text>
  
  <!-- Tool Categories -->
  <g transform="translate(150, 150)">
    <!-- Development Tools -->
    <rect x="0" y="0" width="300" height="200" rx="10" fill="rgba(102, 217, 239, 0.2)" stroke="#66d9ef" stroke-width="2"/>
    <text x="150" y="25" text-anchor="middle" style="font-family: Arial; font-size: 16px; font-weight: bold; fill: white;">
      🛠️ Development Tools
    </text>
    <text x="20" y="50" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• VS Code Server</text>
    <text x="20" y="70" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Git & GitHub CLI</text>
    <text x="20" y="90" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Node.js & Python</text>
    <text x="20" y="110" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Package Managers</text>
    <text x="20" y="130" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Code Formatters</text>
    
    <!-- Infrastructure Tools -->
    <rect x="350" y="0" width="300" height="200" rx="10" fill="rgba(243, 156, 18, 0.2)" stroke="#f39c12" stroke-width="2"/>
    <text x="500" y="25" text-anchor="middle" style="font-family: Arial; font-size: 16px; font-weight: bold; fill: white;">
      🏗️ Infrastructure Tools
    </text>
    <text x="370" y="50" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Terraform</text>
    <text x="370" y="70" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• AWS CLI</text>
    <text x="370" y="90" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• kubectl</text>
    <text x="370" y="110" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Helm</text>
    <text x="370" y="130" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Ansible</text>
    
    <!-- Monitoring Tools -->
    <rect x="700" y="0" width="250" height="200" rx="10" fill="rgba(102, 126, 234, 0.2)" stroke="#667eea" stroke-width="2"/>
    <text x="825" y="25" text-anchor="middle" style="font-family: Arial; font-size: 16px; font-weight: bold; fill: white;">
      📊 Monitoring
    </text>
    <text x="720" y="50" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Prometheus</text>
    <text x="720" y="70" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Grafana</text>
    <text x="720" y="90" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Jaeger</text>
    <text x="720" y="110" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Fluentd</text>
    
    <!-- Security Tools -->
    <rect x="0" y="250" width="300" height="200" rx="10" fill="rgba(229, 62, 62, 0.2)" stroke="#e53e3e" stroke-width="2"/>
    <text x="150" y="275" text-anchor="middle" style="font-family: Arial; font-size: 16px; font-weight: bold; fill: white;">
      🔐 Security Tools
    </text>
    <text x="20" y="300" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Vault</text>
    <text x="20" y="320" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• SOPS</text>
    <text x="20" y="340" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Trivy Scanner</text>
    <text x="20" y="360" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• OPA Gatekeeper</text>
    
    <!-- CI/CD Tools -->
    <rect x="350" y="250" width="300" height="200" rx="10" fill="rgba(56, 161, 105, 0.2)" stroke="#38a169" stroke-width="2"/>
    <text x="500" y="275" text-anchor="middle" style="font-family: Arial; font-size: 16px; font-weight: bold; fill: white;">
      🔄 CI/CD Tools
    </text>
    <text x="370" y="300" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• GitHub Actions</text>
    <text x="370" y="320" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• ArgoCD</text>
    <text x="370" y="340" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Jenkins</text>
    <text x="370" y="360" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Tekton</text>
    
    <!-- Productivity -->
    <rect x="700" y="250" width="250" height="200" rx="10" fill="rgba(128, 90, 213, 0.2)" stroke="#805ad5" stroke-width="2"/>
    <text x="825" y="275" text-anchor="middle" style="font-family: Arial; font-size: 16px; font-weight: bold; fill: white;">
      ⚡ Productivity
    </text>
    <text x="720" y="300" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Oh My Zsh</text>
    <text x="720" y="320" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Tmux</text>
    <text x="720" y="340" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Vim/Nano</text>
    <text x="720" y="360" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">• Aliases</text>
  </g>
  
  <!-- Bottom Stats -->
  <rect x="200" y="650" width="800" height="60" rx="15" fill="rgba(255, 255, 255, 0.1)"/>
  <text x="600" y="675" text-anchor="middle" style="font-family: Arial; font-size: 16px; font-weight: bold; fill: white;">
    30+ Tools • 1 Container • Zero Configuration • Ready in 30 Seconds
  </text>
  <text x="600" y="695" text-anchor="middle" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">
    Everything you need for modern DevOps development in a single, portable environment
  </text>
</svg>
EOF

echo "✅ Created: images/container-architecture.svg"

echo ""
echo "🎨 Professional visual assets created successfully!"
echo "📁 Files created in images/ directory:"
ls -la images/*.svg

#!/bin/bash

# Create Thumbnails for Each Project
echo "🖼️ Creating project thumbnails..."

# Ultimate DevOps Container Thumbnail
cat > images/thumbnails/ultimate-devops-container.svg << 'EOF'
<svg width="400" height="250" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="container-grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#1e40af;stop-opacity:0.9" />
      <stop offset="100%" style="stop-color:#3730a3;stop-opacity:0.9" />
    </linearGradient>
  </defs>
  
  <rect width="400" height="250" fill="url(#container-grad)" rx="10"/>
  
  <!-- Docker Container -->
  <g transform="translate(200, 125)">
    <rect x="-80" y="-40" width="160" height="80" rx="10" fill="#2496ed" stroke="#0db7ed" stroke-width="3"/>
    <text x="0" y="-15" text-anchor="middle" style="font-family: Arial; font-size: 16px; font-weight: bold; fill: white;">🐳 DevOps</text>
    <text x="0" y="5" text-anchor="middle" style="font-family: Arial; font-size: 14px; fill: white;">Container</text>
    <text x="0" y="25" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: #bfdbfe;">50+ Tools Integrated</text>
  </g>
  
  <!-- Tools around container -->
  <circle cx="80" cy="80" r="20" fill="#ff6b35"/>
  <text x="80" y="85" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold; fill: white;">K8s</text>
  
  <circle cx="320" cy="80" r="20" fill="#623ce4"/>
  <text x="320" y="85" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold; fill: white;">TF</text>
  
  <circle cx="80" cy="170" r="20" fill="#e6522c"/>
  <text x="80" y="175" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold; fill: white;">📊</text>
  
  <circle cx="320" cy="170" r="20" fill="#2088ff"/>
  <text x="320" y="175" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold; fill: white;">CI</text>
  
  <!-- Title -->
  <text x="200" y="30" text-anchor="middle" style="font-family: Arial; font-size: 18px; font-weight: bold; fill: white;">
    Ultimate DevOps Container
  </text>
  
  <!-- Status -->
  <rect x="150" y="200" width="100" height="25" rx="12" fill="rgba(34, 197, 94, 0.3)" stroke="#22c55e" stroke-width="2"/>
  <text x="200" y="218" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold; fill: #22c55e;">
    Production Ready
  </text>
</svg>
EOF

# Enterprise CI/CD Thumbnail
cat > images/thumbnails/enterprise-cicd.svg << 'EOF'
<svg width="400" height="250" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="cicd-grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#0f766e;stop-opacity:0.9" />
      <stop offset="100%" style="stop-color:#065f46;stop-opacity:0.9" />
    </linearGradient>
  </defs>
  
  <rect width="400" height="250" fill="url(#cicd-grad)" rx="10"/>
  
  <!-- Pipeline Flow -->
  <g transform="translate(50, 125)">
    <!-- Code -->
    <circle cx="0" cy="0" r="25" fill="#4ade80"/>
    <text x="0" y="5" text-anchor="middle" style="font-family: Arial; font-size: 14px; font-weight: bold;">📝</text>
    
    <!-- Arrow -->
    <polygon points="30,0 50,-5 50,5" fill="#f59e0b"/>
    
    <!-- Build -->
    <circle cx="75" cy="0" r="25" fill="#3b82f6"/>
    <text x="75" y="5" text-anchor="middle" style="font-family: Arial; font-size: 14px; font-weight: bold;">🔨</text>
    
    <!-- Arrow -->
    <polygon points="105,0 125,-5 125,5" fill="#f59e0b"/>
    
    <!-- Test -->
    <circle cx="150" cy="0" r="25" fill="#f59e0b"/>
    <text x="150" y="5" text-anchor="middle" style="font-family: Arial; font-size: 14px; font-weight: bold;">🧪</text>
    
    <!-- Arrow -->
    <polygon points="180,0 200,-5 200,5" fill="#f59e0b"/>
    
    <!-- Deploy -->
    <circle cx="225" cy="0" r="25" fill="#8b5cf6"/>
    <text x="225" y="5" text-anchor="middle" style="font-family: Arial; font-size: 14px; font-weight: bold;">🚀</text>
    
    <!-- Arrow -->
    <polygon points="255,0 275,-5 275,5" fill="#f59e0b"/>
    
    <!-- Monitor -->
    <circle cx="300" cy="0" r="25" fill="#ef4444"/>
    <text x="300" y="5" text-anchor="middle" style="font-family: Arial; font-size: 14px; font-weight: bold;">📊</text>
  </g>
  
  <!-- Title -->
  <text x="200" y="40" text-anchor="middle" style="font-family: Arial; font-size: 18px; font-weight: bold; fill: white;">
    Enterprise CI/CD Pipeline
  </text>
  
  <!-- Subtitle -->
  <text x="200" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; fill: #a7f3d0;">
    GitOps • Security • Compliance
  </text>
  
  <!-- Metrics -->
  <rect x="100" y="180" width="200" height="40" rx="20" fill="rgba(34, 197, 94, 0.2)" stroke="#22c55e" stroke-width="2"/>
  <text x="200" y="200" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">
    8min Build • 99.2% Success
  </text>
  <text x="200" y="215" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: #a7f3d0;">
    Zero Downtime Deployments
  </text>
</svg>
EOF

# AWS Infrastructure Thumbnail
cat > images/thumbnails/aws-infrastructure.svg << 'EOF'
<svg width="400" height="250" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="aws-grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#ff9900;stop-opacity:0.9" />
      <stop offset="100%" style="stop-color:#cc7700;stop-opacity:0.9" />
    </linearGradient>
  </defs>
  
  <rect width="400" height="250" fill="url(#aws-grad)" rx="10"/>
  
  <!-- AWS Logo Area -->
  <rect x="150" y="50" width="100" height="60" rx="10" fill="#232f3e"/>
  <text x="200" y="75" text-anchor="middle" style="font-family: Arial; font-size: 16px; font-weight: bold; fill: #ff9900;">AWS</text>
  <text x="200" y="95" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Infrastructure</text>
  
  <!-- Terraform -->
  <circle cx="80" cy="150" r="30" fill="#623ce4"/>
  <text x="80" y="155" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">🏗️ TF</text>
  
  <!-- Kubernetes -->
  <circle cx="320" cy="150" r="30" fill="#326ce5"/>
  <text x="320" y="155" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">☸️ K8s</text>
  
  <!-- Connections -->
  <line x1="110" y1="150" x2="150" y2="110" stroke="white" stroke-width="3"/>
  <line x1="290" y1="150" x2="250" y2="110" stroke="white" stroke-width="3"/>
  
  <!-- Title -->
  <text x="200" y="25" text-anchor="middle" style="font-family: Arial; font-size: 18px; font-weight: bold; fill: white;">
    AWS Infrastructure Automation
  </text>
  
  <!-- Status -->
  <rect x="120" y="200" width="160" height="25" rx="12" fill="rgba(34, 197, 94, 0.3)" stroke="#22c55e" stroke-width="2"/>
  <text x="200" y="218" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold; fill: #22c55e;">
    Terraform + EKS + RDS
  </text>
</svg>
EOF

# Monitoring Stack Thumbnail
cat > images/thumbnails/monitoring-stack.svg << 'EOF'
<svg width="400" height="250" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="monitor-grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#7c3aed;stop-opacity:0.9" />
      <stop offset="100%" style="stop-color:#5b21b6;stop-opacity:0.9" />
    </linearGradient>
  </defs>
  
  <rect width="400" height="250" fill="url(#monitor-grad)" rx="10"/>
  
  <!-- Dashboard Screen -->
  <rect x="100" y="60" width="200" height="120" rx="10" fill="#1f2937" stroke="#4f46e5" stroke-width="3"/>
  
  <!-- Charts inside dashboard -->
  <rect x="120" y="80" width="60" height="40" fill="#22c55e" opacity="0.7"/>
  <rect x="220" y="80" width="60" height="40" fill="#f59e0b" opacity="0.7"/>
  <rect x="120" y="140" width="60" height="20" fill="#ef4444" opacity="0.7"/>
  <rect x="220" y="140" width="60" height="20" fill="#3b82f6" opacity="0.7"/>
  
  <!-- Grafana -->
  <circle cx="80" cy="200" r="25" fill="#ff8c00"/>
  <text x="80" y="205" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold; fill: white;">📊</text>
  
  <!-- Prometheus -->
  <circle cx="320" cy="200" r="25" fill="#e6522c"/>
  <text x="320" y="205" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold; fill: white;">🔥</text>
  
  <!-- Title -->
  <text x="200" y="30" text-anchor="middle" style="font-family: Arial; font-size: 18px; font-weight: bold; fill: white;">
    Cross-Platform Monitoring
  </text>
  
  <!-- Subtitle -->
  <text x="200" y="50" text-anchor="middle" style="font-family: Arial; font-size: 12px; fill: #c4b5fd;">
    Prometheus • Grafana • Jaeger
  </text>
  
  <!-- Metrics -->
  <text x="200" y="190" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">
    📈 Real-time Observability
  </text>
</svg>
EOF

# Kubernetes VPN Thumbnail
cat > images/thumbnails/kubernetes-vpn.svg << 'EOF'
<svg width="400" height="250" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="vpn-grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#dc2626;stop-opacity:0.9" />
      <stop offset="100%" style="stop-color:#991b1b;stop-opacity:0.9" />
    </linearGradient>
  </defs>
  
  <rect width="400" height="250" fill="url(#vpn-grad)" rx="10"/>
  
  <!-- VPN Shield -->
  <g transform="translate(200, 125)">
    <path d="M 0,-50 L 30,-30 L 30,30 L 0,50 L -30,30 L -30,-30 Z" fill="#22c55e" stroke="#16a34a" stroke-width="3"/>
    <text x="0" y="-10" text-anchor="middle" style="font-family: Arial; font-size: 20px; font-weight: bold; fill: white;">🔐</text>
    <text x="0" y="10" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">VPN</text>
    <text x="0" y="25" text-anchor="middle" style="font-family: Arial; font-size: 8px; fill: white;">Secure</text>
  </g>
  
  <!-- Kubernetes Pods -->
  <circle cx="100" cy="100" r="20" fill="#326ce5"/>
  <text x="100" y="105" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold; fill: white;">Pod</text>
  
  <circle cx="300" cy="150" r="20" fill="#326ce5"/>
  <text x="300" y="155" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold; fill: white;">Pod</text>
  
  <!-- Secure connections -->
  <line x1="120" y1="100" x2="170" y2="115" stroke="#22c55e" stroke-width="4" stroke-dasharray="5,5"/>
  <line x1="230" y1="135" x2="280" y2="150" stroke="#22c55e" stroke-width="4" stroke-dasharray="5,5"/>
  
  <!-- Title -->
  <text x="200" y="30" text-anchor="middle" style="font-family: Arial; font-size: 18px; font-weight: bold; fill: white;">
    Kubernetes VPN Solution
  </text>
  
  <!-- Subtitle -->
  <text x="200" y="50" text-anchor="middle" style="font-family: Arial; font-size: 12px; fill: #fecaca;">
    WireGuard • Network Policies • Security
  </text>
  
  <!-- Status -->
  <rect x="120" y="200" width="160" height="25" rx="12" fill="rgba(34, 197, 94, 0.3)" stroke="#22c55e" stroke-width="2"/>
  <text x="200" y="218" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold; fill: #22c55e;">
    Zero-Trust Architecture
  </text>
</svg>
EOF

echo "✅ Created: images/thumbnails/ultimate-devops-container.svg"
echo "✅ Created: images/thumbnails/enterprise-cicd.svg"
echo "✅ Created: images/thumbnails/aws-infrastructure.svg"
echo "✅ Created: images/thumbnails/monitoring-stack.svg"
echo "✅ Created: images/thumbnails/kubernetes-vpn.svg"

echo ""
echo "🖼️ Project thumbnails created successfully!"
echo "📁 Thumbnail images:"
ls -la images/thumbnails/

#!/bin/bash

# Create Project Thumbnails and Technology Showcase Images
echo "🎨 Creating project thumbnails and technology showcase images..."

# CI Pipeline Visualization
cat > images/ci-pipeline-example.svg << 'EOF'
<svg width="1000" height="400" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="pipeline-bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#1e3a8a;stop-opacity:0.8" />
      <stop offset="100%" style="stop-color:#3730a3;stop-opacity:0.9" />
    </linearGradient>
    <filter id="glow">
      <feGaussianBlur stdDeviation="3" result="coloredBlur"/>
      <feMerge><feMergeNode in="coloredBlur"/><feMergeNode in="SourceGraphic"/></feMerge>
    </filter>
  </defs>
  
  <rect width="1000" height="400" fill="url(#pipeline-bg)"/>
  
  <!-- Title -->
  <text x="500" y="30" text-anchor="middle" style="font-family: Arial; font-size: 24px; font-weight: bold; fill: white;">
    Enterprise CI/CD Pipeline Flow
  </text>
  
  <!-- Pipeline Stages -->
  <g transform="translate(50, 80)">
    <!-- Stage 1: Code -->
    <rect x="0" y="0" width="120" height="80" rx="10" fill="#4ade80" stroke="#22c55e" stroke-width="2"/>
    <text x="60" y="30" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold;">📝 Code</text>
    <text x="60" y="50" text-anchor="middle" style="font-family: Arial; font-size: 10px;">Git Push</text>
    <text x="60" y="65" text-anchor="middle" style="font-family: Arial; font-size: 10px;">Branch Protection</text>
    
    <!-- Arrow 1 -->
    <polygon points="130,40 160,35 160,45" fill="#f39c12"/>
    
    <!-- Stage 2: Build -->
    <rect x="170" y="0" width="120" height="80" rx="10" fill="#3b82f6" stroke="#2563eb" stroke-width="2"/>
    <text x="230" y="30" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold;">🔨 Build</text>
    <text x="230" y="50" text-anchor="middle" style="font-family: Arial; font-size: 10px;">Docker Build</text>
    <text x="230" y="65" text-anchor="middle" style="font-family: Arial; font-size: 10px;">Vulnerability Scan</text>
    
    <!-- Arrow 2 -->
    <polygon points="300,40 330,35 330,45" fill="#f39c12"/>
    
    <!-- Stage 3: Test -->
    <rect x="340" y="0" width="120" height="80" rx="10" fill="#f59e0b" stroke="#d97706" stroke-width="2"/>
    <text x="400" y="30" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold;">🧪 Test</text>
    <text x="400" y="50" text-anchor="middle" style="font-family: Arial; font-size: 10px;">Unit Tests</text>
    <text x="400" y="65" text-anchor="middle" style="font-family: Arial; font-size: 10px;">Integration Tests</text>
    
    <!-- Arrow 3 -->
    <polygon points="470,40 500,35 500,45" fill="#f39c12"/>
    
    <!-- Stage 4: Security -->
    <rect x="510" y="0" width="120" height="80" rx="10" fill="#ef4444" stroke="#dc2626" stroke-width="2"/>
    <text x="570" y="30" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold;">🔐 Security</text>
    <text x="570" y="50" text-anchor="middle" style="font-family: Arial; font-size: 10px;">SAST/DAST</text>
    <text x="570" y="65" text-anchor="middle" style="font-family: Arial; font-size: 10px;">Policy Check</text>
    
    <!-- Arrow 4 -->
    <polygon points="640,40 670,35 670,45" fill="#f39c12"/>
    
    <!-- Stage 5: Deploy -->
    <rect x="680" y="0" width="120" height="80" rx="10" fill="#8b5cf6" stroke="#7c3aed" stroke-width="2"/>
    <text x="740" y="30" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold;">🚀 Deploy</text>
    <text x="740" y="50" text-anchor="middle" style="font-family: Arial; font-size: 10px;">GitOps</text>
    <text x="740" y="65" text-anchor="middle" style="font-family: Arial; font-size: 10px;">Multi-Environment</text>
  </g>
  
  <!-- Environment Flow -->
  <g transform="translate(50, 200)">
    <text x="400" y="20" text-anchor="middle" style="font-family: Arial; font-size: 16px; font-weight: bold; fill: white;">
      Environment Promotion Flow
    </text>
    
    <!-- Dev Environment -->
    <rect x="0" y="40" width="150" height="60" rx="8" fill="rgba(74, 222, 128, 0.3)" stroke="#4ade80" stroke-width="2"/>
    <text x="75" y="60" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">🔬 Development</text>
    <text x="75" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: #f0f0f0;">Auto Deploy</text>
    
    <!-- Arrow -->
    <polygon points="160,70 190,65 190,75" fill="#22c55e"/>
    
    <!-- Staging Environment -->
    <rect x="200" y="40" width="150" height="60" rx="8" fill="rgba(245, 158, 11, 0.3)" stroke="#f59e0b" stroke-width="2"/>
    <text x="275" y="60" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">🎭 Staging</text>
    <text x="275" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: #f0f0f0;">Manual Approval</text>
    
    <!-- Arrow -->
    <polygon points="360,70 390,65 390,75" fill="#f59e0b"/>
    
    <!-- Production Environment -->
    <rect x="400" y="40" width="150" height="60" rx="8" fill="rgba(239, 68, 68, 0.3)" stroke="#ef4444" stroke-width="2"/>
    <text x="475" y="60" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">🏭 Production</text>
    <text x="475" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: #f0f0f0;">Blue/Green Deploy</text>
  </g>
  
  <!-- Metrics -->
  <rect x="50" y="320" width="800" height="50" rx="10" fill="rgba(255, 255, 255, 0.1)"/>
  <text x="450" y="340" text-anchor="middle" style="font-family: Arial; font-size: 14px; font-weight: bold; fill: white;">
    📊 Pipeline Metrics: 99.2% Success Rate • 8min Average Build Time • Zero Downtime Deployments
  </text>
  <text x="450" y="355" text-anchor="middle" style="font-family: Arial; font-size: 12px; fill: #f0f0f0;">
    Automated rollbacks • Real-time monitoring • Compliance reporting
  </text>
</svg>
EOF

# DevOps Frustration vs Solution
cat > images/devops-frustration-vs-solution.svg << 'EOF'
<svg width="1200" height="600" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="frustration-grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#dc2626;stop-opacity:0.8" />
      <stop offset="100%" style="stop-color:#7f1d1d;stop-opacity:0.9" />
    </linearGradient>
    <linearGradient id="solution-grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#059669;stop-opacity:0.8" />
      <stop offset="100%" style="stop-color:#064e3b;stop-opacity:0.9" />
    </linearGradient>
  </defs>
  
  <rect width="1200" height="600" fill="#0f1419"/>
  
  <!-- Main Title -->
  <text x="600" y="40" text-anchor="middle" style="font-family: Arial; font-size: 28px; font-weight: bold; fill: white;">
    The DevOps Transformation Journey
  </text>
  
  <!-- Before (Frustration) -->
  <rect x="50" y="80" width="500" height="450" rx="20" fill="url(#frustration-grad)" stroke="#dc2626" stroke-width="3"/>
  <text x="300" y="120" text-anchor="middle" style="font-family: Arial; font-size: 22px; font-weight: bold; fill: white;">
    😤 BEFORE: The Pain Points
  </text>
  
  <!-- Frustration Items -->
  <g transform="translate(80, 150)">
    <g>
      <circle cx="15" cy="15" r="8" fill="#fee2e2"/>
      <text x="15" y="20" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: #dc2626;">1</text>
      <text x="40" y="20" style="font-family: Arial; font-size: 14px; fill: white; font-weight: bold;">Manual Deployment Hell</text>
      <text x="40" y="35" style="font-family: Arial; font-size: 12px; fill: #fecaca;">• 6-hour deployment windows</text>
      <text x="40" y="50" style="font-family: Arial; font-size: 12px; fill: #fecaca;">• Weekend work required</text>
      <text x="40" y="65" style="font-family: Arial; font-size: 12px; fill: #fecaca;">• High failure rates (40%+)</text>
    </g>
    
    <g transform="translate(0, 90)">
      <circle cx="15" cy="15" r="8" fill="#fee2e2"/>
      <text x="15" y="20" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: #dc2626;">2</text>
      <text x="40" y="20" style="font-family: Arial; font-size: 14px; fill: white; font-weight: bold;">Environment Inconsistencies</text>
      <text x="40" y="35" style="font-family: Arial; font-size: 12px; fill: #fecaca;">• "Works on my machine" syndrome</text>
      <text x="40" y="50" style="font-family: Arial; font-size: 12px; fill: #fecaca;">• Different configs everywhere</text>
    </g>
    
    <g transform="translate(0, 150)">
      <circle cx="15" cy="15" r="8" fill="#fee2e2"/>
      <text x="15" y="20" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: #dc2626;">3</text>
      <text x="40" y="20" style="font-family: Arial; font-size: 14px; fill: white; font-weight: bold;">Monitoring Blindness</text>
      <text x="40" y="35" style="font-family: Arial; font-size: 12px; fill: #fecaca;">• Finding issues after customers</text>
      <text x="40" y="50" style="font-family: Arial; font-size: 12px; fill: #fecaca;">• No observability</text>
    </g>
    
    <g transform="translate(0, 210)">
      <circle cx="15" cy="15" r="8" fill="#fee2e2"/>
      <text x="15" y="20" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: #dc2626;">4</text>
      <text x="40" y="20" style="font-family: Arial; font-size: 14px; fill: white; font-weight: bold;">Security Afterthoughts</text>
      <text x="40" y="35" style="font-family: Arial; font-size: 12px; fill: #fecaca;">• Security scans at the end</text>
      <text x="40" y="50" style="font-family: Arial; font-size: 12px; fill: #fecaca;">• Compliance nightmares</text>
    </g>
    
    <g transform="translate(0, 270)">
      <circle cx="15" cy="15" r="8" fill="#fee2e2"/>
      <text x="15" y="20" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: #dc2626;">5</text>
      <text x="40" y="20" style="font-family: Arial; font-size: 14px; fill: white; font-weight: bold;">Developer Frustration</text>
      <text x="40" y="35" style="font-family: Arial; font-size: 12px; fill: #fecaca;">• Slow feedback loops</text>
      <text x="40" y="50" style="font-family: Arial; font-size: 12px; fill: #fecaca;">• Burnout from manual work</text>
    </g>
  </g>
  
  <!-- Arrow -->
  <g transform="translate(550, 280)">
    <polygon points="0,20 50,0 50,15 100,15 100,25 50,25 50,40" fill="#f59e0b"/>
    <text x="50" y="55" text-anchor="middle" style="font-family: Arial; font-size: 14px; font-weight: bold; fill: #f59e0b;">
      TRANSFORMATION
    </text>
  </g>
  
  <!-- After (Solution) -->
  <rect x="650" y="80" width="500" height="450" rx="20" fill="url(#solution-grad)" stroke="#059669" stroke-width="3"/>
  <text x="900" y="120" text-anchor="middle" style="font-family: Arial; font-size: 22px; font-weight: bold; fill: white;">
    ✨ AFTER: DevOps Excellence
  </text>
  
  <!-- Solution Items -->
  <g transform="translate(680, 150)">
    <g>
      <circle cx="15" cy="15" r="8" fill="#d1fae5"/>
      <text x="15" y="20" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: #059669;">✓</text>
      <text x="40" y="20" style="font-family: Arial; font-size: 14px; fill: white; font-weight: bold;">Automated Everything</text>
      <text x="40" y="35" style="font-family: Arial; font-size: 12px; fill: #a7f3d0;">• 5-minute deployments</text>
      <text x="40" y="50" style="font-family: Arial; font-size: 12px; fill: #a7f3d0;">• Zero-downtime releases</text>
      <text x="40" y="65" style="font-family: Arial; font-size: 12px; fill: #a7f3d0;">• 99.9% success rate</text>
    </g>
    
    <g transform="translate(0, 90)">
      <circle cx="15" cy="15" r="8" fill="#d1fae5"/>
      <text x="15" y="20" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: #059669;">✓</text>
      <text x="40" y="20" style="font-family: Arial; font-size: 14px; fill: white; font-weight: bold;">Consistent Environments</text>
      <text x="40" y="35" style="font-family: Arial; font-size: 12px; fill: #a7f3d0;">• Infrastructure as Code</text>
      <text x="40" y="50" style="font-family: Arial; font-size: 12px; fill: #a7f3d0;">• Container standardization</text>
    </g>
    
    <g transform="translate(0, 150)">
      <circle cx="15" cy="15" r="8" fill="#d1fae5"/>
      <text x="15" y="20" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: #059669;">✓</text>
      <text x="40" y="20" style="font-family: Arial; font-size: 14px; fill: white; font-weight: bold;">Complete Observability</text>
      <text x="40" y="35" style="font-family: Arial; font-size: 12px; fill: #a7f3d0;">• Real-time monitoring</text>
      <text x="40" y="50" style="font-family: Arial; font-size: 12px; fill: #a7f3d0;">• Predictive analytics</text>
    </g>
    
    <g transform="translate(0, 210)">
      <circle cx="15" cy="15" r="8" fill="#d1fae5"/>
      <text x="15" y="20" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: #059669;">✓</text>
      <text x="40" y="20" style="font-family: Arial; font-size: 14px; fill: white; font-weight: bold;">Security-First Approach</text>
      <text x="40" y="35" style="font-family: Arial; font-size: 12px; fill: #a7f3d0;">• Shift-left security</text>
      <text x="40" y="50" style="font-family: Arial; font-size: 12px; fill: #a7f3d0;">• Automated compliance</text>
    </g>
    
    <g transform="translate(0, 270)">
      <circle cx="15" cy="15" r="8" fill="#d1fae5"/>
      <text x="15" y="20" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: #059669;">✓</text>
      <text x="40" y="20" style="font-family: Arial; font-size: 14px; fill: white; font-weight: bold;">Developer Happiness</text>
      <text x="40" y="35" style="font-family: Arial; font-size: 12px; fill: #a7f3d0;">• Fast feedback loops</text>
      <text x="40" y="50" style="font-family: Arial; font-size: 12px; fill: #a7f3d0;">• Focus on innovation</text>
    </g>
  </g>
  
  <!-- Bottom Impact -->
  <rect x="200" y="550" width="800" height="40" rx="10" fill="rgba(245, 158, 11, 0.2)" stroke="#f59e0b" stroke-width="2"/>
  <text x="600" y="575" text-anchor="middle" style="font-family: Arial; font-size: 16px; font-weight: bold; fill: white;">
    🎯 Result: 300% faster delivery • 60% cost reduction • 95% fewer production issues
  </text>
</svg>
EOF

echo "✅ Created: images/ci-pipeline-example.svg"
echo "✅ Created: images/devops-frustration-vs-solution.svg"

# Create Technology Stack Showcase
cat > images/technology-stack-showcase.svg << 'EOF'
<svg width="1400" height="800" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="tech-bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#1e1b4b;stop-opacity:0.9" />
      <stop offset="100%" style="stop-color:#312e81;stop-opacity:0.9" />
    </linearGradient>
  </defs>
  
  <rect width="1400" height="800" fill="url(#tech-bg)"/>
  
  <!-- Title -->
  <text x="700" y="40" text-anchor="middle" style="font-family: Arial; font-size: 32px; font-weight: bold; fill: white;">
    🛠️ Complete DevOps Technology Stack
  </text>
  <text x="700" y="70" text-anchor="middle" style="font-family: Arial; font-size: 16px; fill: #a5b4fc;">
    Production-tested tools across the entire software delivery lifecycle
  </text>
  
  <!-- Cloud Platforms -->
  <g transform="translate(50, 100)">
    <rect x="0" y="0" width="400" height="120" rx="15" fill="rgba(255, 153, 0, 0.2)" stroke="#ff9900" stroke-width="2"/>
    <text x="200" y="25" text-anchor="middle" style="font-family: Arial; font-size: 18px; font-weight: bold; fill: white;">☁️ Cloud Platforms</text>
    
    <rect x="20" y="40" width="100" height="60" rx="8" fill="#ff9900"/>
    <text x="70" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">AWS</text>
    <text x="70" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">EKS • EC2 • RDS</text>
    
    <rect x="140" y="40" width="100" height="60" rx="8" fill="#0078d4"/>
    <text x="190" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">Azure</text>
    <text x="190" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">AKS • VMs • SQL</text>
    
    <rect x="260" y="40" width="100" height="60" rx="8" fill="#4285f4"/>
    <text x="310" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">GCP</text>
    <text x="310" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">GKE • Compute</text>
  </g>
  
  <!-- Containers & Orchestration -->
  <g transform="translate(500, 100)">
    <rect x="0" y="0" width="400" height="120" rx="15" fill="rgba(56, 161, 105, 0.2)" stroke="#38a169" stroke-width="2"/>
    <text x="200" y="25" text-anchor="middle" style="font-family: Arial; font-size: 18px; font-weight: bold; fill: white;">🐳 Container Orchestration</text>
    
    <rect x="20" y="40" width="100" height="60" rx="8" fill="#2496ed"/>
    <text x="70" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">Docker</text>
    <text x="70" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Containers</text>
    
    <rect x="140" y="40" width="100" height="60" rx="8" fill="#326ce5"/>
    <text x="190" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">Kubernetes</text>
    <text x="190" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Orchestration</text>
    
    <rect x="260" y="40" width="100" height="60" rx="8" fill="#0f4c75"/>
    <text x="310" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">Helm</text>
    <text x="310" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Package Mgr</text>
  </g>
  
  <!-- IaC & Config -->
  <g transform="translate(950, 100)">
    <rect x="0" y="0" width="400" height="120" rx="15" fill="rgba(139, 92, 246, 0.2)" stroke="#8b5cf6" stroke-width="2"/>
    <text x="200" y="25" text-anchor="middle" style="font-family: Arial; font-size: 18px; font-weight: bold; fill: white;">🏗️ Infrastructure as Code</text>
    
    <rect x="20" y="40" width="100" height="60" rx="8" fill="#623ce4"/>
    <text x="70" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">Terraform</text>
    <text x="70" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Provisioning</text>
    
    <rect x="140" y="40" width="100" height="60" rx="8" fill="#ee0000"/>
    <text x="190" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">Ansible</text>
    <text x="190" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Config Mgmt</text>
    
    <rect x="260" y="40" width="100" height="60" rx="8" fill="#f14e32"/>
    <text x="310" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">Packer</text>
    <text x="310" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Images</text>
  </g>
  
  <!-- CI/CD Pipeline -->
  <g transform="translate(50, 270)">
    <rect x="0" y="0" width="400" height="120" rx="15" fill="rgba(245, 158, 11, 0.2)" stroke="#f59e0b" stroke-width="2"/>
    <text x="200" y="25" text-anchor="middle" style="font-family: Arial; font-size: 18px; font-weight: bold; fill: white;">🔄 CI/CD Pipeline</text>
    
    <rect x="20" y="40" width="100" height="60" rx="8" fill="#2088ff"/>
    <text x="70" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">GitHub</text>
    <text x="70" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Actions</text>
    
    <rect x="140" y="40" width="100" height="60" rx="8" fill="#d33833"/>
    <text x="190" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">Jenkins</text>
    <text x="190" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Automation</text>
    
    <rect x="260" y="40" width="100" height="60" rx="8" fill="#ef7b4d"/>
    <text x="310" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">ArgoCD</text>
    <text x="310" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">GitOps</text>
  </g>
  
  <!-- Monitoring & Observability -->
  <g transform="translate(500, 270)">
    <rect x="0" y="0" width="400" height="120" rx="15" fill="rgba(34, 197, 94, 0.2)" stroke="#22c55e" stroke-width="2"/>
    <text x="200" y="25" text-anchor="middle" style="font-family: Arial; font-size: 18px; font-weight: bold; fill: white;">📊 Monitoring & Observability</text>
    
    <rect x="20" y="40" width="100" height="60" rx="8" fill="#e6522c"/>
    <text x="70" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">Prometheus</text>
    <text x="70" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Metrics</text>
    
    <rect x="140" y="40" width="100" height="60" rx="8" fill="#ff8c00"/>
    <text x="190" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">Grafana</text>
    <text x="190" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Dashboards</text>
    
    <rect x="260" y="40" width="100" height="60" rx="8" fill="#60a5fa"/>
    <text x="310" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">Jaeger</text>
    <text x="310" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Tracing</text>
  </g>
  
  <!-- Security -->
  <g transform="translate(950, 270)">
    <rect x="0" y="0" width="400" height="120" rx="15" fill="rgba(239, 68, 68, 0.2)" stroke="#ef4444" stroke-width="2"/>
    <text x="200" y="25" text-anchor="middle" style="font-family: Arial; font-size: 18px; font-weight: bold; fill: white;">🔐 Security & Compliance</text>
    
    <rect x="20" y="40" width="100" height="60" rx="8" fill="#000000"/>
    <text x="70" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">Vault</text>
    <text x="70" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Secrets</text>
    
    <rect x="140" y="40" width="100" height="60" rx="8" fill="#4f46e5"/>
    <text x="190" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">SOPS</text>
    <text x="190" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Encryption</text>
    
    <rect x="260" y="40" width="100" height="60" rx="8" fill="#059669"/>
    <text x="310" y="65" text-anchor="middle" style="font-family: Arial; font-size: 12px; font-weight: bold; fill: white;">Trivy</text>
    <text x="310" y="80" text-anchor="middle" style="font-family: Arial; font-size: 10px; fill: white;">Scanning</text>
  </g>
  
  <!-- Bottom Integration Flow -->
  <g transform="translate(200, 450)">
    <rect x="0" y="0" width="1000" height="280" rx="20" fill="rgba(15, 23, 42, 0.8)" stroke="#334155" stroke-width="2"/>
    <text x="500" y="30" text-anchor="middle" style="font-family: Arial; font-size: 20px; font-weight: bold; fill: white;">
      🔗 Integrated DevOps Workflow
    </text>
    
    <!-- Workflow Steps -->
    <g transform="translate(50, 60)">
      <!-- Developer commits -->
      <circle cx="50" cy="50" r="40" fill="#4ade80" stroke="#22c55e" stroke-width="3"/>
      <text x="50" y="45" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold;">👨‍💻</text>
      <text x="50" y="60" text-anchor="middle" style="font-family: Arial; font-size: 8px;">Developer</text>
      
      <!-- Arrow -->
      <polygon points="100,50 140,45 140,55" fill="#60a5fa"/>
      
      <!-- CI Pipeline -->
      <circle cx="180" cy="50" r="40" fill="#3b82f6" stroke="#2563eb" stroke-width="3"/>
      <text x="180" y="45" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold;">🔨</text>
      <text x="180" y="60" text-anchor="middle" style="font-family: Arial; font-size: 8px;">CI Build</text>
      
      <!-- Arrow -->
      <polygon points="230,50 270,45 270,55" fill="#60a5fa"/>
      
      <!-- Security Scan -->
      <circle cx="310" cy="50" r="40" fill="#ef4444" stroke="#dc2626" stroke-width="3"/>
      <text x="310" y="45" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold;">🔐</text>
      <text x="310" y="60" text-anchor="middle" style="font-family: Arial; font-size: 8px;">Security</text>
      
      <!-- Arrow -->
      <polygon points="360,50 400,45 400,55" fill="#60a5fa"/>
      
      <!-- Deploy -->
      <circle cx="440" cy="50" r="40" fill="#8b5cf6" stroke="#7c3aed" stroke-width="3"/>
      <text x="440" y="45" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold;">🚀</text>
      <text x="440" y="60" text-anchor="middle" style="font-family: Arial; font-size: 8px;">Deploy</text>
      
      <!-- Arrow -->
      <polygon points="490,50 530,45 530,55" fill="#60a5fa"/>
      
      <!-- Monitor -->
      <circle cx="570" cy="50" r="40" fill="#f59e0b" stroke="#d97706" stroke-width="3"/>
      <text x="570" y="45" text-anchor="middle" style="font-family: Arial; font-size: 10px; font-weight: bold;">📊</text>
      <text x="570" y="60" text-anchor="middle" style="font-family: Arial; font-size: 8px;">Monitor</text>
      
      <!-- Feedback Loop -->
      <path d="M 580 80 Q 320 120 60 80" stroke="#22c55e" stroke-width="3" fill="none" stroke-dasharray="5,5"/>
      <polygon points="60,80 80,75 80,85" fill="#22c55e"/>
      <text x="320" y="140" text-anchor="middle" style="font-family: Arial; font-size: 12px; fill: #22c55e;">Continuous Feedback Loop</text>
    </g>
    
    <!-- Metrics -->
    <rect x="50" y="200" width="900" height="60" rx="10" fill="rgba(59, 130, 246, 0.1)" stroke="#3b82f6" stroke-width="1"/>
    <text x="500" y="225" text-anchor="middle" style="font-family: Arial; font-size: 14px; font-weight: bold; fill: white;">
      🎯 Production Metrics
    </text>
    <text x="500" y="245" text-anchor="middle" style="font-family: Arial; font-size: 12px; fill: #93c5fd;">
      99.9% Uptime • 5min Deploy Time • 50+ Deployments/Week • Zero Security Incidents • 35% Cost Reduction
    </text>
  </g>
  
  <!-- Footer -->
  <text x="700" y="780" text-anchor="middle" style="font-family: Arial; font-size: 16px; font-weight: bold; fill: white;">
    Enterprise-grade DevOps stack powering modern software delivery
  </text>
</svg>
EOF

echo "✅ Created: images/technology-stack-showcase.svg"

echo ""
echo "🎨 Professional project images created successfully!"
echo "📁 New visual assets:"
ls -la images/*.svg | grep -E "(ci-pipeline|devops-frustration|technology-stack)"

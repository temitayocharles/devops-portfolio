#!/bin/bash

# Create Professional Draw.io/Lucidchart Style Architectural Diagrams
echo "🎨 Creating professional diagramming tool style architectures..."

# Ultimate DevOps Container - Draw.io Style Architecture
cat > images/ultimate-devops-architecture-professional.svg << 'EOF'
<svg width="1200" height="800" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <!-- Professional gradients like draw.io -->
    <linearGradient id="blueGrad" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#e3f2fd;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#1976d2;stop-opacity:1" />
    </linearGradient>
    <linearGradient id="greenGrad" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#e8f5e8;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#4caf50;stop-opacity:1" />
    </linearGradient>
    <linearGradient id="orangeGrad" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#fff3e0;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#ff9800;stop-opacity:1" />
    </linearGradient>
    <!-- Professional shadows -->
    <filter id="dropShadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="3" dy="3" stdDeviation="3" flood-color="#000000" flood-opacity="0.3"/>
    </filter>
    <!-- Connection arrows -->
    <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="#424242" />
    </marker>
  </defs>
  
  <!-- Background -->
  <rect width="1200" height="800" fill="#fafafa" stroke="#e0e0e0" stroke-width="1"/>
  
  <!-- Title -->
  <text x="600" y="30" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 24px; font-weight: 600; fill: #1976d2;">
    Ultimate DevOps Container Architecture
  </text>
  <text x="600" y="55" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; fill: #666;">
    Professional containerized development environment with integrated DevOps toolchain
  </text>
  
  <!-- User/Developer Layer -->
  <g id="userLayer">
    <!-- Developer -->
    <rect x="50" y="100" width="140" height="80" rx="8" fill="url(#blueGrad)" stroke="#1976d2" stroke-width="2" filter="url(#dropShadow)"/>
    <text x="120" y="130" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; font-weight: 600; fill: #ffffff;">👨‍💻 Developer</text>
    <text x="120" y="150" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #e3f2fd;">Local Machine</text>
    <text x="120" y="165" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #bbdefb;">Any OS</text>
    
    <!-- Arrow to Container -->
    <line x1="190" y1="140" x2="250" y2="140" stroke="#424242" stroke-width="2" marker-end="url(#arrowhead)"/>
    <text x="220" y="125" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">docker run</text>
  </g>
  
  <!-- Main Container Block -->
  <g id="containerBlock">
    <rect x="270" y="80" width="660" height="640" rx="12" fill="#ffffff" stroke="#2196f3" stroke-width="3" filter="url(#dropShadow)"/>
    <rect x="270" y="80" width="660" height="40" rx="12" fill="url(#blueGrad)" stroke="#1976d2" stroke-width="2"/>
    <text x="600" y="105" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #ffffff;">🐳 Ultimate DevOps Container</text>
    
    <!-- Layer 1: Base OS -->
    <rect x="290" y="140" width="620" height="60" rx="6" fill="#f5f5f5" stroke="#bdbdbd" stroke-width="1"/>
    <text x="600" y="165" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; font-weight: 600; fill: #424242;">🐧 Ubuntu 22.04 LTS Base</text>
    <text x="600" y="185" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #666;">Hardened OS • Security Updates • Performance Optimized</text>
    
    <!-- Layer 2: Development Tools -->
    <rect x="290" y="220" width="300" height="120" rx="6" fill="url(#greenGrad)" stroke="#4caf50" stroke-width="2"/>
    <text x="440" y="245" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; font-weight: 600; fill: #ffffff;">🛠️ Development Tools</text>
    
    <!-- Tool boxes inside dev tools -->
    <rect x="310" y="260" width="80" height="30" rx="4" fill="rgba(255,255,255,0.9)" stroke="#2e7d32" stroke-width="1"/>
    <text x="350" y="280" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; font-weight: 600; fill: #2e7d32;">VS Code</text>
    
    <rect x="400" y="260" width="80" height="30" rx="4" fill="rgba(255,255,255,0.9)" stroke="#2e7d32" stroke-width="1"/>
    <text x="440" y="280" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; font-weight: 600; fill: #2e7d32;">Git + CLI</text>
    
    <rect x="490" y="260" width="80" height="30" rx="4" fill="rgba(255,255,255,0.9)" stroke="#2e7d32" stroke-width="1"/>
    <text x="530" y="280" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; font-weight: 600; fill: #2e7d32;">Terminal</text>
    
    <text x="440" y="310" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; fill: #ffffff;">Node.js • Python • Go • Rust</text>
    <text x="440" y="325" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; fill: #e8f5e8;">Oh My Zsh • Powerlevel10k</text>
    
    <!-- Layer 2: DevOps Tools -->
    <rect x="610" y="220" width="300" height="120" rx="6" fill="url(#orangeGrad)" stroke="#ff9800" stroke-width="2"/>
    <text x="760" y="245" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; font-weight: 600; fill: #ffffff;">⚙️ DevOps Toolchain</text>
    
    <!-- Tool boxes inside devops tools -->
    <rect x="630" y="260" width="80" height="30" rx="4" fill="rgba(255,255,255,0.9)" stroke="#f57c00" stroke-width="1"/>
    <text x="670" y="280" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; font-weight: 600; fill: #f57c00;">Docker</text>
    
    <rect x="720" y="260" width="80" height="30" rx="4" fill="rgba(255,255,255,0.9)" stroke="#f57c00" stroke-width="1"/>
    <text x="760" y="280" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; font-weight: 600; fill: #f57c00;">Kubernetes</text>
    
    <rect x="810" y="260" width="80" height="30" rx="4" fill="rgba(255,255,255,0.9)" stroke="#f57c00" stroke-width="1"/>
    <text x="850" y="280" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; font-weight: 600; fill: #f57c00;">Terraform</text>
    
    <text x="760" y="310" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; fill: #ffffff;">AWS CLI • Azure CLI • GCP CLI</text>
    <text x="760" y="325" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; fill: #fff3e0;">Helm • Ansible • Packer</text>
  </g>
  
  <!-- Layer 3: Services -->
  <rect x="290" y="360" width="620" height="140" rx="6" fill="#f3e5f5" stroke="#9c27b0" stroke-width="2"/>
  <text x="600" y="385" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; font-weight: 600; fill: #6a1b9a;">🚀 Integrated Services</text>
  
  <!-- Service boxes -->
  <rect x="310" y="400" width="120" height="80" rx="6" fill="#ffffff" stroke="#9c27b0" stroke-width="1" filter="url(#dropShadow)"/>
  <text x="370" y="425" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #6a1b9a;">📊 Monitoring</text>
  <text x="370" y="445" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Prometheus</text>
  <text x="370" y="460" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Grafana</text>
  <text x="370" y="475" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">:3000 :9090</text>
  
  <rect x="450" y="400" width="120" height="80" rx="6" fill="#ffffff" stroke="#9c27b0" stroke-width="1" filter="url(#dropShadow)"/>
  <text x="510" y="425" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #6a1b9a;">🔒 Security</text>
  <text x="510" y="445" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">HashiCorp</text>
  <text x="510" y="460" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Vault</text>
  <text x="510" y="475" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">:8200</text>
  
  <rect x="590" y="400" width="120" height="80" rx="6" fill="#ffffff" stroke="#9c27b0" stroke-width="1" filter="url(#dropShadow)"/>
  <text x="650" y="425" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #6a1b9a;">💻 Code Server</text>
  <text x="650" y="445" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">VS Code</text>
  <text x="650" y="460" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Web IDE</text>
  <text x="650" y="475" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">:8080</text>
  
  <rect x="730" y="400" width="120" height="80" rx="6" fill="#ffffff" stroke="#9c27b0" stroke-width="1" filter="url(#dropShadow)"/>
  <text x="790" y="425" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #6a1b9a;">🌐 Web Proxy</text>
  <text x="790" y="445" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">NGINX</text>
  <text x="790" y="460" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">TLS/SSL</text>
  <text x="790" y="475" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">:80 :443</text>
  
  <!-- Layer 4: Security & Networking -->
  <rect x="290" y="520" width="620" height="80" rx="6" fill="#ffebee" stroke="#d32f2f" stroke-width="2"/>
  <text x="600" y="545" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; font-weight: 600; fill: #c62828;">🛡️ Security & Networking Layer</text>
  <text x="600" y="565" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #d32f2f;">TLS Certificates • Firewall Rules • Network Policies</text>
  <text x="600" y="580" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #d32f2f;">HTTPS Endpoints • Secure Communication • Port Management</text>
  <text x="600" y="590" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #ffcdd2;">Auto-generated certificates • Encrypted traffic • Access control</text>
  
  <!-- Layer 5: Persistence -->
  <rect x="290" y="620" width="620" height="80" rx="6" fill="#f1f8e9" stroke="#689f38" stroke-width="2"/>
  <text x="600" y="645" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; font-weight: 600; fill: #558b2f;">💾 Persistent Storage & Configuration</text>
  <text x="600" y="665" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #689f38;">Docker Volumes • Configuration Files • User Data</text>
  <text x="600" y="680" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #689f38;">Workspace Persistence • Settings Sync • Backup Integration</text>
  <text x="600" y="690" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #c8e6c9;">Data survival across container restarts</text>
  
  <!-- Output Arrows -->
  <g id="outputs">
    <!-- Web Access -->
    <line x1="930" y1="200" x2="1000" y2="200" stroke="#424242" stroke-width="2" marker-end="url(#arrowhead)"/>
    <rect x="1020" y="160" width="140" height="80" rx="8" fill="url(#greenGrad)" stroke="#4caf50" stroke-width="2" filter="url(#dropShadow)"/>
    <text x="1090" y="185" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #ffffff;">🌐 Web Access</text>
    <text x="1090" y="205" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #e8f5e8;">Grafana Dashboard</text>
    <text x="1090" y="218" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #e8f5e8;">VS Code Server</text>
    <text x="1090" y="231" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #e8f5e8;">Vault UI</text>
    
    <!-- Terminal Access -->
    <line x1="930" y1="400" x2="1000" y2="400" stroke="#424242" stroke-width="2" marker-end="url(#arrowhead)"/>
    <rect x="1020" y="360" width="140" height="80" rx="8" fill="url(#orangeGrad)" stroke="#ff9800" stroke-width="2" filter="url(#dropShadow)"/>
    <text x="1090" y="385" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #ffffff;">⌨️ Terminal Access</text>
    <text x="1090" y="405" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #fff3e0;">SSH Connection</text>
    <text x="1090" y="418" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #fff3e0;">Docker Exec</text>
    <text x="1090" y="431" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #fff3e0;">Local Terminal</text>
    
    <!-- API Access -->
    <line x1="930" y1="600" x2="1000" y2="600" stroke="#424242" stroke-width="2" marker-end="url(#arrowhead)"/>
    <rect x="1020" y="560" width="140" height="80" rx="8" fill="url(#blueGrad)" stroke="#1976d2" stroke-width="2" filter="url(#dropShadow)"/>
    <text x="1090" y="585" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #ffffff;">🔗 API Access</text>
    <text x="1090" y="605" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #e3f2fd;">REST APIs</text>
    <text x="1090" y="618" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #e3f2fd;">Metrics Endpoints</text>
    <text x="1090" y="631" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #e3f2fd;">Health Checks</text>
  </g>
  
  <!-- Benefits Box -->
  <rect x="50" y="250" width="180" height="200" rx="8" fill="#ffffff" stroke="#4caf50" stroke-width="2" filter="url(#dropShadow)"/>
  <rect x="50" y="250" width="180" height="30" rx="8" fill="url(#greenGrad)"/>
  <text x="140" y="270" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; font-weight: 600; fill: #ffffff;">✨ Key Benefits</text>
  
  <text x="60" y="295" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; font-weight: 600; fill: #2e7d32;">⚡ 30-Second Setup</text>
  <text x="60" y="315" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; font-weight: 600; fill: #2e7d32;">🔒 Security by Default</text>
  <text x="60" y="335" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; font-weight: 600; fill: #2e7d32;">📊 Built-in Monitoring</text>
  <text x="60" y="355" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; font-weight: 600; fill: #2e7d32;">🛠️ 50+ DevOps Tools</text>
  <text x="60" y="375" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; font-weight: 600; fill: #2e7d32;">🌐 Cross-Platform</text>
  <text x="60" y="395" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; font-weight: 600; fill: #2e7d32;">💾 Persistent Workspace</text>
  <text x="60" y="415" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; font-weight: 600; fill: #2e7d32;">🔄 Auto-Updates</text>
  <text x="60" y="435" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; font-weight: 600; fill: #2e7d32;">🎯 Production Ready</text>
  
  <!-- Usage Stats -->
  <rect x="50" y="480" width="180" height="120" rx="8" fill="#ffffff" stroke="#1976d2" stroke-width="2" filter="url(#dropShadow)"/>
  <rect x="50" y="480" width="180" height="30" rx="8" fill="url(#blueGrad)"/>
  <text x="140" y="500" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; font-weight: 600; fill: #ffffff;">📈 Usage Metrics</text>
  
  <text x="140" y="525" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #1976d2;">10,000+</text>
  <text x="140" y="545" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; fill: #666;">Container Pulls</text>
  
  <text x="140" y="565" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #1976d2;">99.9%</text>
  <text x="140" y="585" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; fill: #666;">Uptime</text>
  
  <!-- Footer -->
  <text x="600" y="780" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #999;">
    Enterprise-grade containerized development environment • Production tested • Open source
  </text>
</svg>
EOF

# Enterprise CI/CD Pipeline - Professional Architecture
cat > images/enterprise-cicd-architecture-professional.svg << 'EOF'
<svg width="1400" height="900" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <!-- Professional styling like Lucidchart -->
    <linearGradient id="gitGrad" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#f6f8fa;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#24292e;stop-opacity:1" />
    </linearGradient>
    <linearGradient id="ciGrad" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#e3f2fd;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#1976d2;stop-opacity:1" />
    </linearGradient>
    <linearGradient id="securityGrad" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#ffebee;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#d32f2f;stop-opacity:1" />
    </linearGradient>
    <linearGradient id="deployGrad" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#e8f5e8;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#4caf50;stop-opacity:1" />
    </linearGradient>
    <!-- Professional shadows -->
    <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="2" dy="2" stdDeviation="2" flood-color="#000000" flood-opacity="0.2"/>
    </filter>
    <!-- Professional arrows -->
    <marker id="arrow" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="#424242" />
    </marker>
  </defs>
  
  <!-- Background -->
  <rect width="1400" height="900" fill="#fafafa" stroke="#e0e0e0" stroke-width="1"/>
  
  <!-- Title -->
  <text x="700" y="30" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 26px; font-weight: 600; fill: #1976d2;">
    Enterprise CI/CD Pipeline Architecture
  </text>
  <text x="700" y="55" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; fill: #666;">
    GitOps-powered continuous integration and deployment with security scanning and multi-environment promotion
  </text>
  
  <!-- Developer Section -->
  <g id="developer">
    <rect x="50" y="100" width="200" height="100" rx="10" fill="url(#gitGrad)" stroke="#24292e" stroke-width="2" filter="url(#shadow)"/>
    <text x="150" y="130" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #ffffff;">👨‍💻 Developer</text>
    <text x="150" y="150" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #f6f8fa;">Feature Branch</text>
    <text x="150" y="170" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #f6f8fa;">Code Changes</text>
    <text x="150" y="185" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #c9d1d9;">git push origin feature-branch</text>
    
    <!-- Arrow to GitHub -->
    <line x1="250" y1="150" x2="320" y2="150" stroke="#424242" stroke-width="2" marker-end="url(#arrow)"/>
    <text x="285" y="140" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Push</text>
  </g>
  
  <!-- GitHub Section -->
  <g id="github">
    <rect x="340" y="100" width="200" height="100" rx="10" fill="url(#gitGrad)" stroke="#24292e" stroke-width="2" filter="url(#shadow)"/>
    <text x="440" y="130" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #ffffff;">📦 GitHub</text>
    <text x="440" y="150" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #f6f8fa;">Repository</text>
    <text x="440" y="170" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #f6f8fa;">Pull Request</text>
    <text x="440" y="185" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #c9d1d9;">Branch Protection Rules</text>
    
    <!-- Arrow to CI -->
    <line x1="540" y1="150" x2="610" y2="150" stroke="#424242" stroke-width="2" marker-end="url(#arrow)"/>
    <text x="575" y="140" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Trigger</text>
  </g>
  
  <!-- CI Pipeline -->
  <g id="pipeline">
    <rect x="630" y="80" width="600" height="140" rx="10" fill="#ffffff" stroke="#1976d2" stroke-width="3" filter="url(#shadow)"/>
    <rect x="630" y="80" width="600" height="30" rx="10" fill="url(#ciGrad)"/>
    <text x="930" y="100" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #ffffff;">🔄 CI/CD Pipeline (GitHub Actions)</text>
    
    <!-- Pipeline stages -->
    <rect x="650" y="130" width="100" height="70" rx="6" fill="#e3f2fd" stroke="#1976d2" stroke-width="1"/>
    <text x="700" y="150" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #1976d2;">🔨 Build</text>
    <text x="700" y="170" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Docker Build</text>
    <text x="700" y="185" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Multi-arch</text>
    
    <rect x="770" y="130" width="100" height="70" rx="6" fill="#ffebee" stroke="#d32f2f" stroke-width="1"/>
    <text x="820" y="150" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #d32f2f;">🛡️ Security</text>
    <text x="820" y="170" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Trivy Scan</text>
    <text x="820" y="185" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">SAST/DAST</text>
    
    <rect x="890" y="130" width="100" height="70" rx="6" fill="#fff3e0" stroke="#ff9800" stroke-width="1"/>
    <text x="940" y="150" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #f57c00;">🧪 Test</text>
    <text x="940" y="170" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Unit Tests</text>
    <text x="940" y="185" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Integration</text>
    
    <rect x="1010" y="130" width="100" height="70" rx="6" fill="#e8f5e8" stroke="#4caf50" stroke-width="1"/>
    <text x="1060" y="150" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #2e7d32;">📦 Package</text>
    <text x="1060" y="170" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Container</text>
    <text x="1060" y="185" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Registry Push</text>
    
    <!-- Flow arrows inside pipeline -->
    <line x1="750" y1="165" x2="770" y2="165" stroke="#424242" stroke-width="1" marker-end="url(#arrow)"/>
    <line x1="870" y1="165" x2="890" y2="165" stroke="#424242" stroke-width="1" marker-end="url(#arrow)"/>
    <line x1="990" y1="165" x2="1010" y2="165" stroke="#424242" stroke-width="1" marker-end="url(#arrow)"/>
  </g>
  
  <!-- GitOps Section -->
  <g id="gitops">
    <rect x="1270" y="100" width="120" height="100" rx="10" fill="url(#deployGrad)" stroke="#4caf50" stroke-width="2" filter="url(#shadow)"/>
    <text x="1330" y="130" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; font-weight: 600; fill: #ffffff;">🔄 GitOps</text>
    <text x="1330" y="150" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #e8f5e8;">ArgoCD</text>
    <text x="1330" y="170" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #e8f5e8;">Config Sync</text>
    <text x="1330" y="185" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #c8e6c9;">Auto Deploy</text>
    
    <!-- Arrow from pipeline to GitOps -->
    <line x1="1230" y1="150" x2="1270" y2="150" stroke="#424242" stroke-width="2" marker-end="url(#arrow)"/>
  </g>
  
  <!-- Environment Tiers -->
  <g id="environments">
    <text x="700" y="290" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 18px; font-weight: 600; fill: #424242;">🏗️ Multi-Environment Deployment</text>
    
    <!-- Development -->
    <rect x="150" y="320" width="250" height="120" rx="10" fill="url(#deployGrad)" stroke="#4caf50" stroke-width="2" filter="url(#shadow)"/>
    <text x="275" y="350" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #ffffff;">🔬 Development</text>
    <text x="275" y="375" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #e8f5e8;">Auto Deploy on PR Merge</text>
    <text x="275" y="395" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #e8f5e8;">Feature Testing</text>
    <text x="275" y="415" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #e8f5e8;">Integration Validation</text>
    <text x="275" y="430" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #c8e6c9;">dev.example.com</text>
    
    <!-- Staging -->
    <rect x="450" y="320" width="250" height="120" rx="10" fill="url(#ciGrad)" stroke="#1976d2" stroke-width="2" filter="url(#shadow)"/>
    <text x="575" y="350" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #ffffff;">🎭 Staging</text>
    <text x="575" y="375" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #e3f2fd;">Manual Approval Gate</text>
    <text x="575" y="395" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #e3f2fd;">E2E Testing</text>
    <text x="575" y="415" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #e3f2fd;">Performance Testing</text>
    <text x="575" y="430" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #bbdefb;">staging.example.com</text>
    
    <!-- Production -->
    <rect x="750" y="320" width="250" height="120" rx="10" fill="url(#securityGrad)" stroke="#d32f2f" stroke-width="2" filter="url(#shadow)"/>
    <text x="875" y="350" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #ffffff;">🏭 Production</text>
    <text x="875" y="375" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #ffebee;">Blue/Green Deployment</text>
    <text x="875" y="395" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #ffebee;">Zero Downtime</text>
    <text x="875" y="415" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #ffebee;">Automatic Rollback</text>
    <text x="875" y="430" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #ffcdd2;">example.com</text>
    
    <!-- Environment flow arrows -->
    <line x1="400" y1="380" x2="450" y2="380" stroke="#424242" stroke-width="2" marker-end="url(#arrow)"/>
    <text x="425" y="370" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Promote</text>
    
    <line x1="700" y1="380" x2="750" y2="380" stroke="#424242" stroke-width="2" marker-end="url(#arrow)"/>
    <text x="725" y="370" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Release</text>
    
    <!-- Arrow from GitOps to environments -->
    <path d="M 1330 200 Q 1330 250 700 280" stroke="#4caf50" stroke-width="2" fill="none" marker-end="url(#arrow)"/>
  </g>
  
  <!-- Monitoring & Observability -->
  <g id="monitoring">
    <rect x="1050" y="320" width="300" height="120" rx="10" fill="#f3e5f5" stroke="#9c27b0" stroke-width="2" filter="url(#shadow)"/>
    <text x="1200" y="350" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #6a1b9a;">📊 Monitoring & Observability</text>
    
    <rect x="1070" y="365" width="80" height="60" rx="4" fill="#ffffff" stroke="#9c27b0" stroke-width="1"/>
    <text x="1110" y="385" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; font-weight: 600; fill: #6a1b9a;">Prometheus</text>
    <text x="1110" y="400" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 9px; fill: #666;">Metrics</text>
    <text x="1110" y="415" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 9px; fill: #666;">Alerts</text>
    
    <rect x="1160" y="365" width="80" height="60" rx="4" fill="#ffffff" stroke="#9c27b0" stroke-width="1"/>
    <text x="1200" y="385" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; font-weight: 600; fill: #6a1b9a;">Grafana</text>
    <text x="1200" y="400" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 9px; fill: #666;">Dashboards</text>
    <text x="1200" y="415" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 9px; fill: #666;">Visualization</text>
    
    <rect x="1250" y="365" width="80" height="60" rx="4" fill="#ffffff" stroke="#9c27b0" stroke-width="1"/>
    <text x="1290" y="385" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; font-weight: 600; fill: #6a1b9a;">Jaeger</text>
    <text x="1290" y="400" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 9px; fill: #666;">Tracing</text>
    <text x="1290" y="415" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 9px; fill: #666;">APM</text>
  </g>
  
  <!-- Security Layer -->
  <g id="security">
    <rect x="50" y="500" width="1300" height="100" rx="10" fill="#ffebee" stroke="#d32f2f" stroke-width="2" filter="url(#shadow)"/>
    <text x="700" y="530" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 18px; font-weight: 600; fill: #c62828;">🔒 Security & Compliance Layer</text>
    
    <text x="200" y="555" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #d32f2f;">🛡️ SAST/DAST</text>
    <text x="200" y="575" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Static Analysis</text>
    
    <text x="400" y="555" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #d32f2f;">🔍 Trivy Scanning</text>
    <text x="400" y="575" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">Vulnerability</text>
    
    <text x="600" y="555" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #d32f2f;">📋 Policy Checks</text>
    <text x="600" y="575" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">OPA Gatekeeper</text>
    
    <text x="800" y="555" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #d32f2f;">🔐 Secrets Management</text>
    <text x="800" y="575" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">HashiCorp Vault</text>
    
    <text x="1000" y="555" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #d32f2f;">📜 Compliance</text>
    <text x="1000" y="575" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">SOC2, PCI DSS</text>
    
    <text x="1200" y="555" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; font-weight: 600; fill: #d32f2f;">📊 Audit Logging</text>
    <text x="1200" y="575" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; fill: #666;">ELK Stack</text>
  </g>
  
  <!-- Performance Metrics -->
  <rect x="50" y="650" width="1300" height="100" rx="10" fill="#e8f5e8" stroke="#4caf50" stroke-width="2" filter="url(#shadow)"/>
  <text x="700" y="680" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 18px; font-weight: 600; fill: #2e7d32;">📈 Pipeline Performance Metrics</text>
  
  <text x="200" y="705" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #2e7d32;">8 min</text>
  <text x="200" y="725" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #666;">Avg Build Time</text>
  
  <text x="400" y="705" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #2e7d32;">99.2%</text>
  <text x="400" y="725" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #666;">Success Rate</text>
  
  <text x="600" y="705" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #2e7d32;">40+</text>
  <text x="600" y="725" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #666;">Deploys/Week</text>
  
  <text x="800" y="705" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #2e7d32;">0</text>
  <text x="800" y="725" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #666;">Downtime Events</text>
  
  <text x="1000" y="705" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #2e7d32;">2 min</text>
  <text x="1000" y="725" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #666;">Deploy Time</text>
  
  <text x="1200" y="705" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 16px; font-weight: 600; fill: #2e7d32;">< 30s</text>
  <text x="1200" y="725" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #666;">Rollback Time</text>
  
  <!-- Footer -->
  <text x="700" y="830" text-anchor="middle" style="font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; fill: #999;">
    Enterprise-grade CI/CD pipeline with GitOps automation • Multi-environment deployment • Security-first approach
  </text>
</svg>
EOF

echo "✅ Created: images/ultimate-devops-architecture-professional.svg"
echo "✅ Created: images/enterprise-cicd-architecture-professional.svg"

echo ""
echo "🎨 Professional draw.io/Lucidchart style architectural diagrams created!"
echo "📐 Features:"
echo "   • Professional gradients and shadows"
echo "   • Clean geometric shapes"
echo "   • Lucidchart-style color schemes"  
echo "   • Enterprise diagram aesthetics"
echo "   • Technical accuracy with visual polish"

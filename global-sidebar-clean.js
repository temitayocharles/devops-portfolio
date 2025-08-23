// Enhanced Global Sidebar Navigation JavaScript
document.addEventListener('DOMContentLoaded', function() {
    // Create sidebar HTML
    const sidebarHTML = `
        <button class="sidebar-toggle" onclick="toggleSidebar()" title="Open Navigation Menu">☰</button>
        
        <div class="global-sidebar" id="globalSidebar">
            <div class="sidebar-header">
                <h3>🚀 DevOps Portfolio</h3>
                <p>Temitayo Charles</p>
                <div class="quick-stats">
                    <span class="stat-badge">50+ Projects</span>
                    <span class="stat-badge">$45M+ Saved</span>
                </div>
            </div>
            
            <div class="sidebar-nav-group">
                <div class="sidebar-nav-title">🏠 Navigate & Explore</div>
                <a href="index.html" class="sidebar-nav-item" data-icon="🏠" title="Home - Main Portfolio">Home</a>
                <a href="about-me.html" class="sidebar-nav-item" data-icon="👨‍💻" title="About Me - My Story">About Me</a>
                <a href="skills.html" class="sidebar-nav-item" data-icon="⚡" title="Skills - Technical Expertise">Skills & Expertise</a>
                <a href="projects.html" class="sidebar-nav-item" data-icon="🚀" title="Projects - Portfolio Showcase">All Projects</a>
                <a href="contact.html" class="sidebar-nav-item" data-icon="📧" title="Contact - Let's Connect">Contact & Hire</a>
            </div>
            
            <div class="sidebar-nav-group">
                <div class="sidebar-nav-title">☁️ Cloud Solutions</div>
                <a href="aws-solutions.html" class="sidebar-nav-item trending" data-icon="🟠" title="AWS Solutions - 12 Enterprise Projects">AWS Solutions <span class="project-count">12</span></a>
                <a href="azure-solutions.html" class="sidebar-nav-item" data-icon="🔵" title="Azure Solutions - Hybrid Cloud">Azure Solutions <span class="project-count">4</span></a>
                <a href="gcp-solutions.html" class="sidebar-nav-item" data-icon="🔴" title="GCP Solutions - AI/ML Focus">GCP Solutions <span class="project-count">2</span></a>
            </div>
            
            <div class="sidebar-nav-group">
                <div class="sidebar-nav-title">🛠️ Technical Deep Dives</div>
                <a href="architecture.html" class="sidebar-nav-item" data-icon="🏗️" title="Architecture - System Design">Architecture Mastery</a>
                <a href="ci.html" class="sidebar-nav-item hot" data-icon="🔄" title="CI/CD - Automation Pipeline">CI/CD Excellence</a>
                <a href="security.html" class="sidebar-nav-item" data-icon="🔒" title="Security - Best Practices">Security First</a>
                <a href="legacy-vs-now.html" class="sidebar-nav-item new" data-icon="⚡" title="Transformation Stories">Before vs After</a>
            </div>
            
            <div class="sidebar-nav-group hot-projects">
                <div class="sidebar-nav-title">🌟 Featured & Trending</div>
                <a href="project-virtual-vacation.html" class="sidebar-nav-item viral" data-icon="🌍" title="Virtual Vacation - AI Tourism Platform">Virtual Vacation 🔥</a>
                <a href="virtual-vacation-demo.html" class="sidebar-nav-item live" data-icon="🚀" title="Live Interactive Demo">Interactive Demo 🔴</a>
                <a href="project-ultimate-devops-container.html" class="sidebar-nav-item exclusive" data-icon="🐳" title="Ultimate DevOps Container">DevOps Container ⭐</a>
                <a href="project-enterprise-cicd.html" class="sidebar-nav-item trending" data-icon="⚙️" title="Enterprise CI/CD Pipeline">Enterprise CI/CD 📈</a>
            </div>
            
            <div class="sidebar-nav-group">
                <div class="sidebar-nav-title">📚 Resources & More</div>
                <a href="blog.html" class="sidebar-nav-item" data-icon="📝" title="Blog - Insights & Tips">DevOps Blog</a>
                <a href="docs.html" class="sidebar-nav-item" data-icon="📖" title="Documentation Hub">Documentation</a>
                <a href="gallery.html" class="sidebar-nav-item" data-icon="🖼️" title="Visual Portfolio">Visual Gallery</a>
                <a href="use-cases.html" class="sidebar-nav-item" data-icon="💼" title="Business Use Cases">Use Cases</a>
            </div>
            
            <div class="sidebar-cta-section">
                <a href="assets/docs/Temitayo_Charles_Resume.pdf" target="_blank" class="resume-download-btn" title="Download Professional Resume">
                    📄 Download Resume
                </a>
                <a href="contact.html" class="hire-me-btn" title="Let's Work Together">
                    💼 Hire Me Now
                </a>
            </div>
            
            <div class="sidebar-footer">
                <div class="social-links">
                    <a href="https://github.com/temitayocharles" target="_blank" title="GitHub Profile">🐙</a>
                    <a href="https://linkedin.com/in/temitayocharles" target="_blank" title="LinkedIn Profile">💼</a>
                    <a href="https://hub.docker.com/u/temitayocharles" target="_blank" title="DockerHub Profile">🐳</a>
                </div>
                <div class="sidebar-stats">
                    <small>Portfolio Views: <span id="view-counter">Loading...</span></small>
                </div>
            </div>
        </div>
    `;
    
    // Create a container for the sidebar
    const sidebarContainer = document.createElement('div');
    sidebarContainer.innerHTML = sidebarHTML;
    
    // Create a container for existing content
    const contentWrapper = document.createElement('div');
    contentWrapper.className = 'content-wrapper';
    
    // Move all existing body content into the wrapper
    while (document.body.firstChild) {
        if (document.body.firstChild.tagName === 'SCRIPT') {
            const script = document.body.firstChild;
            document.body.removeChild(script);
            document.body.appendChild(script);
        } else {
            contentWrapper.appendChild(document.body.firstChild);
        }
    }
    
    // Add both containers to the body
    document.body.insertBefore(sidebarContainer.firstChild, document.body.firstChild);
    document.body.appendChild(contentWrapper);
    
    // Set active page
    setActivePage();
    
    // Initialize view counter
    initializeViewCounter();
    
    // Close sidebar when clicking outside
    document.addEventListener('click', function(e) {
        const sidebar = document.getElementById('globalSidebar');
        const toggle = document.querySelector('.sidebar-toggle');
        
        if (!sidebar.contains(e.target) && !toggle.contains(e.target)) {
            closeSidebar();
        }
    });
    
    // Handle keyboard navigation
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeSidebar();
        }
    });
});

// Toggle sidebar function
function toggleSidebar() {
    const sidebar = document.getElementById('globalSidebar');
    const contentWrapper = document.querySelector('.content-wrapper');
    const isOpen = sidebar.classList.contains('open');
    
    if (isOpen) {
        closeSidebar();
    } else {
        openSidebar();
    }
}

function openSidebar() {
    const sidebar = document.getElementById('globalSidebar');
    const contentWrapper = document.querySelector('.content-wrapper');
    
    sidebar.classList.add('open');
    if (window.innerWidth > 768) {
        contentWrapper.classList.add('sidebar-open');
    }
}

function closeSidebar() {
    const sidebar = document.getElementById('globalSidebar');
    const contentWrapper = document.querySelector('.content-wrapper');
    
    sidebar.classList.remove('open');
    contentWrapper.classList.remove('sidebar-open');
}

// Set active page based on current URL
function setActivePage() {
    const currentPath = window.location.pathname;
    const currentPage = currentPath.split('/').pop() || 'index.html';
    const navItems = document.querySelectorAll('.sidebar-nav-item');
    
    navItems.forEach(item => {
        item.classList.remove('active');
        const href = item.getAttribute('href');
        
        // Check if the current page matches the href
        if (href === currentPage || 
            (currentPage === '' && href === 'index.html') ||
            (href !== 'index.html' && currentPath.includes(href))) {
            item.classList.add('active');
            
            // Expand parent group if it exists
            const parentGroup = item.closest('.sidebar-nav-group');
            if (parentGroup) {
                parentGroup.classList.add('expanded');
            }
        }
    });
}

// Initialize view counter
function initializeViewCounter() {
    const counter = document.getElementById('view-counter');
    if (counter) {
        let views = localStorage.getItem('portfolio-views') || 0;
        views = parseInt(views) + 1;
        localStorage.setItem('portfolio-views', views);
        counter.textContent = views.toLocaleString();
    }
}

// Add smooth scroll behavior for internal links
document.addEventListener('click', function(e) {
    const link = e.target.closest('a[href^="#"]');
    if (link) {
        e.preventDefault();
        const targetId = link.getAttribute('href').substring(1);
        const targetElement = document.getElementById(targetId);
        if (targetElement) {
            targetElement.scrollIntoView({ behavior: 'smooth' });
            closeSidebar();
        }
    }
});

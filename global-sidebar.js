// Global Sidebar Navigation JavaScript
document.addEventListener('DOMContentLoaded', function() {
    // Create sidebar HTML
    const sidebarHTML = `
        <button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>
        
        <div class="global-sidebar" id="globalSidebar">
            <div class="sidebar-header">
                <h3>DevOps Portfolio</h3>
                <p>Temitayo Charles</p>
            </div>
            
            <div class="sidebar-nav-group">
                <div class="sidebar-nav-title">🏠 Main Pages</div>
                <a href="index.html" class="sidebar-nav-item" data-icon="🏠">Home</a>
                <a href="about-me.html" class="sidebar-nav-item" data-icon="👨‍💻">About Me</a>
                <a href="skills.html" class="sidebar-nav-item" data-icon="⚡">Skills</a>
                <a href="projects.html" class="sidebar-nav-item" data-icon="🚀">Projects</a>
                <a href="contact.html" class="sidebar-nav-item" data-icon="📧">Contact</a>
            </div>
            
            <div class="sidebar-nav-group">
                <div class="sidebar-nav-title">☁️ Cloud Solutions</div>
                <a href="aws-solutions.html" class="sidebar-nav-item" data-icon="🟠">AWS Solutions</a>
                <a href="azure-solutions.html" class="sidebar-nav-item" data-icon="🔵">Azure Solutions</a>
                <a href="gcp-solutions.html" class="sidebar-nav-item" data-icon="🔴">GCP Solutions</a>
            </div>
            
            <div class="sidebar-nav-group">
                <div class="sidebar-nav-title">🛠️ Technical Areas</div>
                <a href="architecture.html" class="sidebar-nav-item" data-icon="🏗️">Architecture</a>
                <a href="ci.html" class="sidebar-nav-item" data-icon="🔄">CI/CD</a>
                <a href="security.html" class="sidebar-nav-item" data-icon="🔒">Security</a>
            </div>
            
            <div class="sidebar-nav-group">
                <div class="sidebar-nav-title">🌟 Featured Projects</div>
                <a href="project-virtual-vacation.html" class="sidebar-nav-item" data-icon="🌍">Virtual Vacation</a>
                <a href="virtual-vacation-demo.html" class="sidebar-nav-item" data-icon="🚀">Interactive Demo</a>
                <a href="project-ultimate-devops-container.html" class="sidebar-nav-item" data-icon="🐳">DevOps Container</a>
                <a href="project-enterprise-cicd.html" class="sidebar-nav-item" data-icon="⚙️">Enterprise CI/CD</a>
            </div>
            
            <div class="sidebar-nav-group">
                <div class="sidebar-nav-title">📚 Resources</div>
                <a href="blog.html" class="sidebar-nav-item" data-icon="📝">Blog</a>
                <a href="docs.html" class="sidebar-nav-item" data-icon="📖">Documentation</a>
                <a href="gallery.html" class="sidebar-nav-item" data-icon="🖼️">Gallery</a>
            </div>
            
            <div class="sidebar-footer">
                <a href="https://github.com/temitayocharles" target="_blank">GitHub</a> |
                <a href="https://linkedin.com/in/temitayocharles" target="_blank">LinkedIn</a>
            </div>
        </div>
    `;
    
<<<<<<< HEAD
    // Insert sidebar at beginning of body
    document.body.insertAdjacentHTML('afterbegin', sidebarHTML);
    
    // Wrap existing content
    const existingContent = document.body.innerHTML.replace(sidebarHTML, '');
    document.body.innerHTML = sidebarHTML + '<div class="content-wrapper">' + existingContent + '</div>';
=======
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
>>>>>>> e2f3a67 (Rebrand)
    
    // Set active page
    setActivePage();
    
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
<<<<<<< HEAD
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
=======
    const currentPath = window.location.pathname;
    const currentPage = currentPath.split('/').pop() || 'index.html';
>>>>>>> e2f3a67 (Rebrand)
    const navItems = document.querySelectorAll('.sidebar-nav-item');
    
    navItems.forEach(item => {
        item.classList.remove('active');
<<<<<<< HEAD
        if (item.getAttribute('href') === currentPage) {
            item.classList.add('active');
=======
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
>>>>>>> e2f3a67 (Rebrand)
        }
    });
}

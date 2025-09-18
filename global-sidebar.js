// Simplified Sidebar Navigation JavaScript
document.addEventListener('DOMContentLoaded', function() {
    // Create simplified sidebar HTML
    const sidebarHTML = `
        <div class="global-sidebar" id="globalSidebar">
            <div class="sidebar-header">
                <div class="sidebar-close" onclick="closeSidebar()">×</div>
                <h3>Navigation</h3>
            </div>

            <div class="sidebar-nav-group">
                <a href="index.html" class="sidebar-nav-item" data-icon="🏠">Home</a>
                <a href="about-me.html" class="sidebar-nav-item" data-icon="👤">About</a>
                <a href="skills.html" class="sidebar-nav-item" data-icon="⚡">Skills</a>
                <a href="projects.html" class="sidebar-nav-item" data-icon="🚀">Projects</a>
                <a href="contact.html" class="sidebar-nav-item" data-icon="📧">Contact</a>
            </div>

            <div class="sidebar-nav-group">
                <div class="sidebar-nav-title">Featured</div>
                <a href="project-virtual-vacation.html" class="sidebar-nav-item" data-icon="🌍">Virtual Vacation</a>
                <a href="project-ultimate-devops-container.html" class="sidebar-nav-item" data-icon="🐳">DevOps Container</a>
                <a href="virtual-vacation-demo.html" class="sidebar-nav-item" data-icon="🎬">Live Demo</a>
            </div>

            <div class="sidebar-nav-group">
                <div class="sidebar-nav-title">Cloud Solutions</div>
                <a href="aws-solutions.html" class="sidebar-nav-item" data-icon="☁️">AWS</a>
                <a href="azure-solutions.html" class="sidebar-nav-item" data-icon="☁️">Azure</a>
                <a href="gcp-solutions.html" class="sidebar-nav-item" data-icon="☁️">GCP</a>
            </div>

            <div class="sidebar-footer">
                <a href="https://github.com/temitayocharles" target="_blank" class="social-link">GitHub</a>
                <a href="https://linkedin.com/in/temitayocharles" target="_blank" class="social-link">LinkedIn</a>
                <a href="https://hub.docker.com/u/temitayocharles" target="_blank" class="social-link">DockerHub</a>
            </div>
        </div>

        <div class="sidebar-overlay" id="sidebarOverlay" onclick="closeSidebar()"></div>
    `;

    // Insert sidebar at beginning of body
    document.body.insertAdjacentHTML('afterbegin', sidebarHTML);

    // Set active page
    setActivePage();

    // Handle keyboard navigation
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeSidebar();
        }
    });

    // Close sidebar when clicking on a nav item
    document.querySelectorAll('.sidebar-nav-item').forEach(link => {
        link.addEventListener('click', closeSidebar);
    });
});

// Toggle sidebar function
function toggleSidebar() {
    const sidebar = document.getElementById('globalSidebar');
    const overlay = document.getElementById('sidebarOverlay');
    const toggleBtn = document.getElementById('sidebar-toggle');
    
    if (sidebar && overlay) {
        sidebar.classList.toggle('open');
        overlay.classList.toggle('active');
        
        // Update aria-expanded for accessibility
        if (toggleBtn) {
            const isOpen = sidebar.classList.contains('open');
            toggleBtn.setAttribute('aria-expanded', isOpen);
        }
    }
}

// Close sidebar function
function closeSidebar() {
    const sidebar = document.getElementById('globalSidebar');
    const overlay = document.getElementById('sidebarOverlay');
    const toggleBtn = document.getElementById('sidebar-toggle');
    
    if (sidebar && overlay) {
        sidebar.classList.remove('open');
        overlay.classList.remove('active');
        
        // Update aria-expanded for accessibility
        if (toggleBtn) {
            toggleBtn.setAttribute('aria-expanded', 'false');
        }
    }
}

// Set active page function
function setActivePage() {
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
    const sidebarLinks = document.querySelectorAll('.sidebar-nav-item');
    
    sidebarLinks.forEach(link => {
        link.classList.remove('active');
        const href = link.getAttribute('href');
        if (href && (href === currentPage || (currentPage === '' && href === 'index.html'))) {
            link.classList.add('active');
        }
    });
}

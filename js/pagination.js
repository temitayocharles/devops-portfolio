/**
 * Advanced Pagination System for DevOps Portfolio
 * Creates bite-sized content sections with smooth navigation
 */

class PortfolioPagination {
    constructor(options = {}) {
        this.config = {
            itemsPerPage: options.itemsPerPage || 6,
            container: options.container || '.projects-container',
            paginationContainer: options.paginationContainer || '.pagination-container',
            itemSelector: options.itemSelector || '.project-card',
            enableFiltering: options.enableFiltering || true,
            enableSearch: options.enableSearch || true,
            animationDuration: options.animationDuration || 300,
            showProgress: options.showProgress || true,
            enableKeyboardNav: options.enableKeyboardNav || true,
            categories: options.categories || [],
            autoScroll: options.autoScroll !== false
        };
        
        this.currentPage = 1;
        this.currentFilter = 'all';
        this.searchQuery = '';
        this.items = [];
        this.filteredItems = [];
        
        this.init();
    }
    
    init() {
        this.container = document.querySelector(this.config.container);
        if (!this.container) return;
        
        this.setupStructure();
        this.collectItems();
        this.createPaginationUI();
        this.createFilterUI();
        this.bindEvents();
        this.render();
        
        // Track pagination usage
        this.trackEvent('pagination_initialized', {
            total_items: this.items.length,
            items_per_page: this.config.itemsPerPage
        });
    }
    
    setupStructure() {
        // Create main pagination wrapper
        const wrapper = document.createElement('div');
        wrapper.className = 'pagination-wrapper';
        
        // Create controls section
        const controls = document.createElement('div');
        controls.className = 'pagination-controls';
        controls.innerHTML = `
            <div class="pagination-header">
                <div class="pagination-search">
                    <input type="text" id="pagination-search" placeholder="Search projects..." />
                    <button class="search-clear" title="Clear search">×</button>
                </div>
                <div class="pagination-filters"></div>
                <div class="pagination-info">
                    <span class="current-results">Showing <span class="start">1</span>-<span class="end">6</span> of <span class="total">0</span> projects</span>
                </div>
            </div>
            <div class="pagination-progress">
                <div class="progress-bar">
                    <div class="progress-fill"></div>
                </div>
                <div class="progress-text">Page <span class="current-page">1</span> of <span class="total-pages">1</span></div>
            </div>
        `;
        
        // Create content area
        const content = document.createElement('div');
        content.className = 'pagination-content';
        
        // Create navigation
        const navigation = document.createElement('div');
        navigation.className = 'pagination-navigation';
        
        // Wrap existing content
        this.container.parentNode.insertBefore(wrapper, this.container);
        wrapper.appendChild(controls);
        wrapper.appendChild(content);
        content.appendChild(this.container);
        wrapper.appendChild(navigation);
        
        this.wrapper = wrapper;
        this.controlsElement = controls;
        this.navigationElement = navigation;
    }
    
    collectItems() {
        this.items = Array.from(this.container.querySelectorAll(this.config.itemSelector));
        
        // Extract categories from items
        this.items.forEach((item, index) => {
            const category = this.extractCategory(item);
            const keywords = this.extractKeywords(item);
            
            item.dataset.paginationIndex = index;
            item.dataset.paginationCategory = category;
            item.dataset.paginationKeywords = keywords.join(' ');
        });
        
        this.filteredItems = [...this.items];
    }
    
    extractCategory(item) {
        // Try to extract category from data attributes, classes, or content
        if (item.dataset.category) return item.dataset.category;
        
        const classes = item.className.toLowerCase();
        const content = item.textContent.toLowerCase();
        
        // Common DevOps categories
        if (content.includes('docker') || content.includes('container')) return 'containers';
        if (content.includes('kubernetes') || content.includes('k8s')) return 'orchestration';
        if (content.includes('aws') || content.includes('azure') || content.includes('gcp')) return 'cloud';
        if (content.includes('ci/cd') || content.includes('pipeline')) return 'automation';
        if (content.includes('terraform') || content.includes('infrastructure')) return 'infrastructure';
        if (content.includes('monitoring') || content.includes('observability')) return 'monitoring';
        if (content.includes('security') || content.includes('scanning')) return 'security';
        
        return 'other';
    }
    
    extractKeywords(item) {
        const text = item.textContent.toLowerCase();
        const title = item.querySelector('h2, h3, .project-title, .title')?.textContent || '';
        const description = item.querySelector('p, .description, .project-description')?.textContent || '';
        
        return [title, description, text]
            .join(' ')
            .split(/\s+/)
            .filter(word => word.length > 2)
            .slice(0, 20); // Limit keywords
    }
    
    createFilterUI() {
        const filtersContainer = this.controlsElement.querySelector('.pagination-filters');
        
        // Get unique categories
        const categories = ['all', ...new Set(this.items.map(item => item.dataset.paginationCategory))];
        
        const filterButtons = categories.map(category => {
            const displayName = category.charAt(0).toUpperCase() + category.slice(1);
            const count = category === 'all' ? this.items.length : 
                         this.items.filter(item => item.dataset.paginationCategory === category).length;
            
            return `
                <button class="filter-btn ${category === 'all' ? 'active' : ''}" 
                        data-filter="${category}"
                        title="${displayName} (${count} projects)">
                    ${displayName} <span class="count">${count}</span>
                </button>
            `;
        }).join('');
        
        filtersContainer.innerHTML = filterButtons;
    }
    
    createPaginationUI() {
        this.updatePaginationControls();
    }
    
    updatePaginationControls() {
        const totalPages = Math.ceil(this.filteredItems.length / this.config.itemsPerPage);
        const hasMultiplePages = totalPages > 1;
        
        let navigationHTML = '';
        
        if (hasMultiplePages) {
            navigationHTML = `
                <div class="pagination-nav">
                    <button class="nav-btn prev-btn" ${this.currentPage === 1 ? 'disabled' : ''}>
                        <span class="nav-icon">‹</span>
                        <span class="nav-text">Previous</span>
                    </button>
                    
                    <div class="page-numbers">
                        ${this.generatePageNumbers(totalPages)}
                    </div>
                    
                    <button class="nav-btn next-btn" ${this.currentPage === totalPages ? 'disabled' : ''}>
                        <span class="nav-text">Next</span>
                        <span class="nav-icon">›</span>
                    </button>
                </div>
                
                <div class="pagination-shortcuts">
                    <button class="shortcut-btn first-btn" ${this.currentPage === 1 ? 'disabled' : ''}>
                        First
                    </button>
                    <button class="shortcut-btn last-btn" ${this.currentPage === totalPages ? 'disabled' : ''}>
                        Last
                    </button>
                </div>
                
                <div class="page-size-controls">
                    <label for="page-size">Items per page:</label>
                    <select id="page-size">
                        <option value="3" ${this.config.itemsPerPage === 3 ? 'selected' : ''}>3</option>
                        <option value="6" ${this.config.itemsPerPage === 6 ? 'selected' : ''}>6</option>
                        <option value="9" ${this.config.itemsPerPage === 9 ? 'selected' : ''}>9</option>
                        <option value="12" ${this.config.itemsPerPage === 12 ? 'selected' : ''}>12</option>
                    </select>
                </div>
            `;
        }
        
        this.navigationElement.innerHTML = navigationHTML;
        this.updateProgress();
        this.updateResultsInfo();
    }
    
    generatePageNumbers(totalPages) {
        const current = this.currentPage;
        const delta = 2; // Pages to show on each side of current
        const range = [];
        
        for (let i = Math.max(2, current - delta); 
             i <= Math.min(totalPages - 1, current + delta); 
             i++) {
            range.push(i);
        }
        
        if (current - delta > 2) range.unshift('...');
        if (current + delta < totalPages - 1) range.push('...');
        
        range.unshift(1);
        if (totalPages !== 1) range.push(totalPages);
        
        return range.map(page => {
            if (page === '...') {
                return '<span class="page-ellipsis">...</span>';
            }
            
            return `
                <button class="page-btn ${page === current ? 'active' : ''}" 
                        data-page="${page}">
                    ${page}
                </button>
            `;
        }).join('');
    }
    
    updateProgress() {
        const totalPages = Math.ceil(this.filteredItems.length / this.config.itemsPerPage);
        const progress = totalPages > 0 ? (this.currentPage / totalPages) * 100 : 0;
        
        const progressFill = this.controlsElement.querySelector('.progress-fill');
        const currentPageSpan = this.controlsElement.querySelector('.current-page');
        const totalPagesSpan = this.controlsElement.querySelector('.total-pages');
        
        if (progressFill) progressFill.style.width = `${progress}%`;
        if (currentPageSpan) currentPageSpan.textContent = this.currentPage;
        if (totalPagesSpan) totalPagesSpan.textContent = totalPages;
    }
    
    updateResultsInfo() {
        const start = Math.min((this.currentPage - 1) * this.config.itemsPerPage + 1, this.filteredItems.length);
        const end = Math.min(this.currentPage * this.config.itemsPerPage, this.filteredItems.length);
        const total = this.filteredItems.length;
        
        const startSpan = this.controlsElement.querySelector('.start');
        const endSpan = this.controlsElement.querySelector('.end');
        const totalSpan = this.controlsElement.querySelector('.total');
        
        if (startSpan) startSpan.textContent = start;
        if (endSpan) endSpan.textContent = end;
        if (totalSpan) totalSpan.textContent = total;
    }
    
    bindEvents() {
        // Filter buttons
        this.controlsElement.addEventListener('click', (e) => {
            if (e.target.classList.contains('filter-btn')) {
                this.handleFilterChange(e.target.dataset.filter);
            }
        });
        
        // Search input
        const searchInput = this.controlsElement.querySelector('#pagination-search');
        const searchClear = this.controlsElement.querySelector('.search-clear');
        
        if (searchInput) {
            searchInput.addEventListener('input', (e) => {
                this.handleSearch(e.target.value);
            });
        }
        
        if (searchClear) {
            searchClear.addEventListener('click', () => {
                searchInput.value = '';
                this.handleSearch('');
            });
        }
        
        // Navigation buttons
        this.navigationElement.addEventListener('click', (e) => {
            if (e.target.classList.contains('prev-btn') || e.target.closest('.prev-btn')) {
                this.goToPage(this.currentPage - 1);
            } else if (e.target.classList.contains('next-btn') || e.target.closest('.next-btn')) {
                this.goToPage(this.currentPage + 1);
            } else if (e.target.classList.contains('first-btn')) {
                this.goToPage(1);
            } else if (e.target.classList.contains('last-btn')) {
                const totalPages = Math.ceil(this.filteredItems.length / this.config.itemsPerPage);
                this.goToPage(totalPages);
            } else if (e.target.classList.contains('page-btn')) {
                this.goToPage(parseInt(e.target.dataset.page));
            }
        });
        
        // Page size change
        this.navigationElement.addEventListener('change', (e) => {
            if (e.target.id === 'page-size') {
                this.config.itemsPerPage = parseInt(e.target.value);
                this.currentPage = 1;
                this.render();
            }
        });
        
        // Keyboard navigation
        if (this.config.enableKeyboardNav) {
            document.addEventListener('keydown', (e) => {
                if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') return;
                
                const totalPages = Math.ceil(this.filteredItems.length / this.config.itemsPerPage);
                
                if (e.key === 'ArrowLeft' || e.key === 'h') {
                    e.preventDefault();
                    if (this.currentPage > 1) this.goToPage(this.currentPage - 1);
                } else if (e.key === 'ArrowRight' || e.key === 'l') {
                    e.preventDefault();
                    if (this.currentPage < totalPages) this.goToPage(this.currentPage + 1);
                } else if (e.key === 'Home') {
                    e.preventDefault();
                    this.goToPage(1);
                } else if (e.key === 'End') {
                    e.preventDefault();
                    this.goToPage(totalPages);
                }
            });
        }
    }
    
    handleFilterChange(filter) {
        this.currentFilter = filter;
        this.currentPage = 1;
        
        // Update active filter button
        this.controlsElement.querySelectorAll('.filter-btn').forEach(btn => {
            btn.classList.toggle('active', btn.dataset.filter === filter);
        });
        
        this.applyFilters();
        this.render();
        
        this.trackEvent('filter_changed', {
            filter: filter,
            results_count: this.filteredItems.length
        });
    }
    
    handleSearch(query) {
        this.searchQuery = query.toLowerCase();
        this.currentPage = 1;
        
        this.applyFilters();
        this.render();
        
        if (query.length > 2) {
            this.trackEvent('search_performed', {
                query: query,
                results_count: this.filteredItems.length
            });
        }
    }
    
    applyFilters() {
        this.filteredItems = this.items.filter(item => {
            // Filter by category
            const categoryMatch = this.currentFilter === 'all' || 
                                item.dataset.paginationCategory === this.currentFilter;
            
            // Filter by search query
            const searchMatch = !this.searchQuery || 
                              item.dataset.paginationKeywords.includes(this.searchQuery);
            
            return categoryMatch && searchMatch;
        });
    }
    
    goToPage(page) {
        const totalPages = Math.ceil(this.filteredItems.length / this.config.itemsPerPage);
        
        if (page < 1 || page > totalPages) return;
        
        this.currentPage = page;
        this.render();
        
        if (this.config.autoScroll) {
            this.scrollToTop();
        }
        
        this.trackEvent('page_changed', {
            page: page,
            total_pages: totalPages
        });
    }
    
    render() {
        this.hideAllItems();
        this.showCurrentPageItems();
        this.updatePaginationControls();
        
        // Add loading animation
        this.container.classList.add('pagination-loading');
        setTimeout(() => {
            this.container.classList.remove('pagination-loading');
        }, this.config.animationDuration);
    }
    
    hideAllItems() {
        this.items.forEach(item => {
            item.style.display = 'none';
            item.classList.remove('pagination-visible');
        });
    }
    
    showCurrentPageItems() {
        const startIndex = (this.currentPage - 1) * this.config.itemsPerPage;
        const endIndex = startIndex + this.config.itemsPerPage;
        const itemsToShow = this.filteredItems.slice(startIndex, endIndex);
        
        itemsToShow.forEach((item, index) => {
            item.style.display = '';
            setTimeout(() => {
                item.classList.add('pagination-visible');
            }, index * 50); // Staggered animation
        });
    }
    
    scrollToTop() {
        this.wrapper.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        });
    }
    
    trackEvent(eventName, data = {}) {
        if (typeof gtag !== 'undefined') {
            gtag('event', eventName, {
                event_category: 'Pagination',
                ...data
            });
        }
    }
}

// Auto-initialize pagination when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    // Initialize for projects page
    if (document.querySelector('.projects-container') || document.querySelector('.project-card')) {
        new PortfolioPagination({
            itemsPerPage: 6,
            container: '.projects-grid, .projects-container, .hero-projects',
            itemSelector: '.project-card, .hero-project-card',
            categories: ['cloud', 'containers', 'automation', 'infrastructure', 'monitoring', 'security']
        });
    }
    
    // Initialize for any other paginated content
    document.querySelectorAll('[data-pagination="true"]').forEach(container => {
        const config = {
            container: `#${container.id}`,
            itemSelector: container.dataset.itemSelector || '.pagination-item',
            itemsPerPage: parseInt(container.dataset.itemsPerPage) || 6
        };
        
        new PortfolioPagination(config);
    });
});

// Export for module usage
if (typeof module !== 'undefined' && module.exports) {
    module.exports = PortfolioPagination;
}
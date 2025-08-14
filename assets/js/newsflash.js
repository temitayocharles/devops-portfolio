// News items array
const newsItems = [
    {
        type: 'tip',
        content: 'DevOps Tip: Use multi-stage Docker builds to reduce final image size by up to 90%',
        link: null
    },
    {
        type: 'project',
        content: 'Ultimate DevOps Container: Now with enhanced Prometheus integration',
        link: '/project-ultimate-devops-container.html'
    },
    {
        type: 'fact',
        content: 'Infrastructure as Code can reduce deployment errors by up to 70%',
        link: null
    },
    {
        type: 'update',
        content: 'Latest Portfolio Update: Enhanced AI assistance and real-time DevOps insights',
        link: null
    },
    {
        type: 'news',
        content: 'Kubernetes 1.29 released with enhanced pod security features',
        link: null
    },
    {
        type: 'project',
        content: 'Virtual Vacation Platform: New destinations added with AI-powered recommendations',
        link: '/project-virtual-vacation.html'
    },
    {
        type: 'tip',
        content: 'Security Best Practice: Rotate your AWS access keys every 90 days',
        link: null
    },
    {
        type: 'fact',
        content: 'Container orchestration can improve resource utilization by up to 40%',
        link: null
    }
];

class NewsFlash {
    constructor(containerId) {
        this.container = document.getElementById(containerId);
        this.currentIndex = 0;
        this.isHovered = false;
    }

    getIcon(type) {
        const icons = {
            tip: '💡',
            project: '🚀',
            fact: '📊',
            update: '🔄',
            news: '📰'
        };
        return icons[type] || '📌';
    }

    createNewsItem(item) {
        const newsItem = document.createElement('div');
        newsItem.className = 'news-item';
        
        const content = item.link 
            ? `<a href="${item.link}" class="news-link">${this.getIcon(item.type)} ${item.content}</a>`
            : `<span>${this.getIcon(item.type)} ${item.content}</span>`;
            
        newsItem.innerHTML = content;
        return newsItem;
    }

    transition() {
        if (this.isHovered) return;

        const currentItem = this.container.querySelector('.news-item');
        if (!currentItem) return;

        currentItem.style.opacity = '0';
        currentItem.style.transform = 'translateY(-20px)';

        setTimeout(() => {
            this.currentIndex = (this.currentIndex + 1) % newsItems.length;
            const newItem = this.createNewsItem(newsItems[this.currentIndex]);
            newItem.style.opacity = '0';
            newItem.style.transform = 'translateY(20px)';
            
            this.container.innerHTML = '';
            this.container.appendChild(newItem);

            // Force reflow
            newItem.offsetHeight;

            newItem.style.opacity = '1';
            newItem.style.transform = 'translateY(0)';
        }, 500);
    }

    start() {
        // Create initial news item
        const firstItem = this.createNewsItem(newsItems[this.currentIndex]);
        this.container.appendChild(firstItem);

        // Add hover handlers
        this.container.addEventListener('mouseenter', () => this.isHovered = true);
        this.container.addEventListener('mouseleave', () => this.isHovered = false);

        // Start transition loop
        setInterval(() => this.transition(), 5000);
    }
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    const newsFlash = new NewsFlash('newsflash-container');
    newsFlash.start();
});

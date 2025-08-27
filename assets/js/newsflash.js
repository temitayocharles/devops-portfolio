// Enhanced news items array with attention-grabbing hooks
const newsItems = [
    {
        type: 'breaking',
        content: '🚨 BREAKING: Multi-million dollar infrastructure transformed in 30 seconds!',
        link: 'project-ultimate-devops-container.html',
        urgent: true
    },
    {
        type: 'viral',
        content: '🔥 VIRAL ALERT: Virtual Vacation Platform reaches 7 global destinations',
        link: 'project-virtual-vacation.html',
        trending: true
    },
    {
        type: 'achievement',
        content: '⚡ ACHIEVEMENT UNLOCKED: Zero-downtime deployments at enterprise scale',
        link: 'project-enterprise-cicd.html',
        achievement: true
    },
    {
        type: 'secret',
        content: '🔓 INSIDER SECRET: How I saved $45M with automated DevOps workflows',
        link: 'projects.html',
        exclusive: true
    },
    {
        type: 'live',
        content: '🔴 LIVE NOW: Watch real deployments happening in production environment',
        link: 'virtual-vacation-demo.html',
        live: true
    },
    {
        type: 'shocking',
        content: '😱 SHOCKING: From 3-week releases to 2-minute deployments - See how!',
        link: 'aws-solutions.html',
        shocking: true
    },
    {
        type: 'exclusive',
        content: '⭐ EXCLUSIVE: Enterprise secrets that DevOps engineers don\'t want you to know',
        link: 'architecture.html',
        exclusive: true
    },
    {
        type: 'urgent',
        content: '⏰ URGENT: Your infrastructure is vulnerable - Fix it in 30 seconds',
        link: 'security.html',
        urgent: true
    },
    {
        type: 'transformation',
        content: '✨ TRANSFORMATION: See how chaos became automated perfection',
        link: 'legacy-vs-now.html',
        transformation: true
    },
    {
        type: 'interactive',
        content: '🎮 PLAY NOW: Interactive demos of real DevOps environments',
        link: 'devops-container-demos.html',
        interactive: true
    },
    {
        type: 'mindblowing',
        content: '🤯 MIND-BLOWING: AI-powered infrastructure that scales infinitely',
        link: 'project-gcp-ml.html',
        mindblowing: true
    },
    {
        type: 'results',
        content: '📈 PROVEN RESULTS: 99.99% uptime achieved across 50+ enterprise systems',
        link: 'project-monitoring-stack.html',
        results: true
    }
];

class NewsFlash {
    constructor(containerId) {
        this.container = document.getElementById(containerId);
        this.currentIndex = 0;
        this.isHovered = false;
        this.clickCount = 0;
    }

    getIcon(type) {
        const icons = {
            breaking: '�',
            viral: '🔥',
            achievement: '⚡',
            secret: '🔓',
            live: '🔴',
            shocking: '😱',
            exclusive: '⭐',
            urgent: '⏰',
            transformation: '✨',
            interactive: '🎮',
            mindblowing: '🤯',
            results: '�'
        };
        return icons[type] || '📌';
    }

    getSpecialEffect(item) {
        let effects = '';
        
        if (item.urgent || item.breaking) {
            effects += ' pulse-urgent';
        }
        if (item.trending || item.viral) {
            effects += ' trending-glow';
        }
        if (item.exclusive || item.secret) {
            effects += ' exclusive-shimmer';
        }
        if (item.live) {
            effects += ' live-blink';
        }
        if (item.interactive) {
            effects += ' interactive-bounce';
        }
        
        return effects;
    }

    createNewsItem(item) {
        const newsItem = document.createElement('div');
        const specialEffects = this.getSpecialEffect(item);
        newsItem.className = `news-item clickable-news${specialEffects}`;
        
        // Create clickable container
        const content = `
            <div class="news-content" onclick="this.handleNewsClick('${item.link}')" style="cursor: pointer; width: 100%; display: flex; align-items: center; justify-content: center; gap: 8px;">
                <span class="news-icon pulsing-icon">${this.getIcon(item.type)}</span>
                <span class="news-text">${item.content}</span>
                <span class="click-indicator">👆 Click to explore!</span>
            </div>
        `;
            
        newsItem.innerHTML = content;
        
        // Add click event listener
        newsItem.addEventListener('click', (e) => {
            e.preventDefault();
            this.handleNewsClick(item.link);
        });
        
        // Add hover effects
        newsItem.addEventListener('mouseenter', () => {
            newsItem.style.transform = 'scale(1.02)';
            newsItem.style.boxShadow = '0 8px 25px rgba(102, 217, 239, 0.3)';
        });
        
        newsItem.addEventListener('mouseleave', () => {
            newsItem.style.transform = 'scale(1)';
            newsItem.style.boxShadow = 'none';
        });
        
        return newsItem;
    }

    handleNewsClick(link) {
        if (!link) return;
        
        this.clickCount++;
        
        // Create click effect
        const effect = document.createElement('div');
        effect.style.cssText = `
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: linear-gradient(135deg, #66d9ef, #a6e22e);
            color: #1a1a1a;
            padding: 15px 30px;
            border-radius: 25px;
            font-weight: bold;
            z-index: 10000;
            animation: clickPopup 0.8s ease forwards;
            box-shadow: 0 10px 30px rgba(102, 217, 239, 0.4);
        `;
        effect.textContent = `🚀 Navigating to amazing content... ${this.clickCount}`;
        document.body.appendChild(effect);
        
        // Navigate after effect
        setTimeout(() => {
            window.location.href = link;
        }, 800);
        
        // Remove effect element
        setTimeout(() => {
            document.body.removeChild(effect);
        }, 1000);
        
        // Track engagement
        console.log(`News flash engagement: ${link} - Click #${this.clickCount}`);
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

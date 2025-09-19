// Analytics and Performance Monitoring
// Add this script to the bottom of each HTML page before closing </body>

(function() {
  'use strict';
  
  // Google Analytics 4 Setup
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  
  // Configure GA4 with enhanced ecommerce and custom events
  gtag('config', 'G-YOUR-GA4-ID', {
    send_page_view: true,
    anonymize_ip: true,
    respect_privacy: true,
    custom_map: {
      'custom_parameter_1': 'page_type',
      'custom_parameter_2': 'user_engagement'
    }
  });
  
  // Track portfolio interactions
  function trackPortfolioEvent(action, category, label, value) {
    gtag('event', action, {
      event_category: category,
      event_label: label,
      value: value,
      custom_parameter_1: document.body.dataset.pageType || 'general',
      custom_parameter_2: 'high'
    });
  }
  
  // Performance monitoring
  function monitorPerformance() {
    // Core Web Vitals tracking
    if ('web-vital' in window) {
      getCLS(vitals => trackPortfolioEvent('CLS', 'Performance', 'Cumulative Layout Shift', vitals.value));
      getFID(vitals => trackPortfolioEvent('FID', 'Performance', 'First Input Delay', vitals.value));
      getFCP(vitals => trackPortfolioEvent('FCP', 'Performance', 'First Contentful Paint', vitals.value));
      getLCP(vitals => trackPortfolioEvent('LCP', 'Performance', 'Largest Contentful Paint', vitals.value));
      getTTFB(vitals => trackPortfolioEvent('TTFB', 'Performance', 'Time to First Byte', vitals.value));
    }
    
    // Custom performance metrics
    window.addEventListener('load', function() {
      const loadTime = performance.timing.loadEventEnd - performance.timing.navigationStart;
      trackPortfolioEvent('page_load_time', 'Performance', window.location.pathname, loadTime);
      
      // Track resource loading
      const resources = performance.getEntriesByType('resource');
      const slowResources = resources.filter(resource => resource.duration > 1000);
      
      if (slowResources.length > 0) {
        trackPortfolioEvent('slow_resources', 'Performance', 'Resources over 1s', slowResources.length);
      }
    });
  }
  
  // User engagement tracking
  function trackEngagement() {
    let startTime = Date.now();
    let isActive = true;
    let maxScroll = 0;
    
    // Track time on page
    window.addEventListener('beforeunload', function() {
      if (isActive) {
        const timeSpent = Math.round((Date.now() - startTime) / 1000);
        trackPortfolioEvent('time_on_page', 'Engagement', window.location.pathname, timeSpent);
      }
    });
    
    // Track scroll depth
    window.addEventListener('scroll', throttle(function() {
      const scrollPercent = Math.round((window.scrollY / (document.body.scrollHeight - window.innerHeight)) * 100);
      maxScroll = Math.max(maxScroll, scrollPercent);
      
      // Milestone tracking
      if (scrollPercent >= 25 && maxScroll < 25) {
        trackPortfolioEvent('scroll_depth', 'Engagement', '25%', 25);
      } else if (scrollPercent >= 50 && maxScroll < 50) {
        trackPortfolioEvent('scroll_depth', 'Engagement', '50%', 50);
      } else if (scrollPercent >= 75 && maxScroll < 75) {
        trackPortfolioEvent('scroll_depth', 'Engagement', '75%', 75);
      } else if (scrollPercent >= 90 && maxScroll < 90) {
        trackPortfolioEvent('scroll_depth', 'Engagement', '90%', 90);
      }
    }, 250));
    
    // Track inactive users
    let inactiveTimer;
    function resetInactiveTimer() {
      clearTimeout(inactiveTimer);
      isActive = true;
      inactiveTimer = setTimeout(() => {
        isActive = false;
        trackPortfolioEvent('user_inactive', 'Engagement', 'Became inactive', Date.now() - startTime);
      }, 30000); // 30 seconds
    }
    
    ['mousedown', 'mousemove', 'keypress', 'scroll', 'touchstart'].forEach(event => {
      document.addEventListener(event, resetInactiveTimer, true);
    });
  }
  
  // Portfolio-specific tracking
  function trackPortfolioInteractions() {
    // Track project views
    document.querySelectorAll('.project-card, .project-link').forEach(element => {
      element.addEventListener('click', function() {
        const projectName = this.dataset.project || this.textContent.trim();
        trackPortfolioEvent('project_click', 'Portfolio', projectName, 1);
      });
    });
    
    // Track technology interests
    document.querySelectorAll('.tech-badge, .skill-item').forEach(element => {
      element.addEventListener('click', function() {
        const techName = this.textContent.trim();
        trackPortfolioEvent('technology_interest', 'Skills', techName, 1);
      });
    });
    
    // Track contact attempts
    document.querySelectorAll('.contact-link, .social-link').forEach(element => {
      element.addEventListener('click', function() {
        const contactType = this.getAttribute('href').includes('mailto') ? 'email' : 
                           this.getAttribute('href').includes('linkedin') ? 'linkedin' :
                           this.getAttribute('href').includes('github') ? 'github' : 'other';
        trackPortfolioEvent('contact_attempt', 'Contact', contactType, 1);
      });
    });
    
    // Track form interactions
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
      contactForm.addEventListener('submit', function() {
        trackPortfolioEvent('form_submission', 'Contact', 'Contact Form', 1);
      });
      
      // Track form field focus for UX insights
      contactForm.querySelectorAll('input, textarea').forEach(field => {
        field.addEventListener('focus', function() {
          trackPortfolioEvent('form_field_focus', 'UX', this.name || this.id, 1);
        });
      });
    }
    
    // Track mobile menu usage
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    if (mobileMenuBtn) {
      mobileMenuBtn.addEventListener('click', function() {
        trackPortfolioEvent('mobile_menu_toggle', 'Navigation', 'Mobile Menu', 1);
      });
    }
  }
  
  // Error tracking
  function trackErrors() {
    window.addEventListener('error', function(e) {
      trackPortfolioEvent('javascript_error', 'Error', e.message, 1);
    });
    
    window.addEventListener('unhandledrejection', function(e) {
      trackPortfolioEvent('promise_rejection', 'Error', e.reason, 1);
    });
  }
  
  // A/B Testing framework
  function initABTesting() {
    const userId = localStorage.getItem('portfolio_user_id') || generateUserId();
    localStorage.setItem('portfolio_user_id', userId);
    
    // Simple hash-based variant assignment
    const variant = parseInt(userId.slice(-1), 16) % 2 === 0 ? 'A' : 'B';
    document.body.dataset.abVariant = variant;
    
    trackPortfolioEvent('ab_test_variant', 'Experiment', `Variant ${variant}`, 1);
  }
  
  // Utility functions
  function throttle(func, limit) {
    let inThrottle;
    return function() {
      const args = arguments;
      const context = this;
      if (!inThrottle) {
        func.apply(context, args);
        inThrottle = true;
        setTimeout(() => inThrottle = false, limit);
      }
    };
  }
  
  function generateUserId() {
    return 'user_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
  }
  
  // Privacy compliance
  function checkConsent() {
    const consent = localStorage.getItem('analytics_consent');
    if (consent === 'granted') {
      return true;
    } else if (consent === null) {
      // Show consent banner (implement your own UI)
      return showConsentBanner();
    }
    return false;
  }
  
  function showConsentBanner() {
    // Implement your consent banner UI
    // For now, assume consent for development
    localStorage.setItem('analytics_consent', 'granted');
    return true;
  }
  
  // Initialize everything
  function init() {
    if (!checkConsent()) {
      return;
    }
    
    // Load Google Analytics
    const script = document.createElement('script');
    script.async = true;
    script.src = 'https://www.googletagmanager.com/gtag/js?id=G-YOUR-GA4-ID';
    document.head.appendChild(script);
    
    // Initialize tracking
    monitorPerformance();
    trackEngagement();
    trackPortfolioInteractions();
    trackErrors();
    initABTesting();
    
    console.log('📊 Portfolio Analytics: Initialized');
  }
  
  // Start when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
  
  // Export for debugging
  window.portfolioAnalytics = {
    track: trackPortfolioEvent,
    performance: monitorPerformance,
    engagement: trackEngagement
  };
})();
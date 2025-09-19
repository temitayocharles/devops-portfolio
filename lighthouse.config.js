module.exports = {
  ci: {
    collect: {
      url: [
        'http://localhost/index.html',
        'http://localhost/about-me.html',
        'http://localhost/skills.html',
        'http://localhost/projects.html',
        'http://localhost/contact.html',
        'http://localhost/project-ecommerce-platform.html',
        'http://localhost/project-ultimate-devops-container.html'
      ],
      startServerCommand: 'python -m http.server 80',
      startServerReadyPattern: 'Serving HTTP',
      startServerReadyTimeout: 20000
    },
    assert: {
      assertions: {
        'categories:performance': ['warn', {minScore: 0.8}],
        'categories:accessibility': ['error', {minScore: 0.9}],
        'categories:best-practices': ['warn', {minScore: 0.85}],
        'categories:seo': ['error', {minScore: 0.9}],
        'categories:pwa': ['warn', {minScore: 0.6}]
      }
    },
    upload: {
      target: 'temporary-public-storage',
    },
  },
};
module.exports = {
  ci: {
    collect: {
      url: [
        'http://localhost:4173/index.html',
        'http://localhost:4173/about-me.html',
        'http://localhost:4173/skills.html',
        'http://localhost:4173/projects.html',
        'http://localhost:4173/contact.html',
        'http://localhost:4173/project-ecommerce-platform.html',
        'http://localhost:4173/project-ultimate-devops-container.html'
      ],
      startServerCommand: 'python3 -u -m http.server 4173',
      startServerReadyPattern: 'Serving HTTP on',
      startServerReadyTimeout: 30000
    },
    assert: {
      assertions: {
        'categories:performance': ['warn', {minScore: 0.8}],
        'categories:accessibility': ['error', {minScore: 0.9}],
        'categories:best-practices': ['warn', {minScore: 0.85}],
        'categories:seo': ['error', {minScore: 0.9}]
      }
    },
    upload: {
      target: 'temporary-public-storage',
    },
  },
};

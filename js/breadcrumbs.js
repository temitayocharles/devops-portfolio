/**
 * Breadcrumb Navigation System
 * Automatically generates and injects breadcrumb navigation
 */

const BreadcrumbSystem = {
  // Project metadata for categorization
  projects: {
    'aws': {
      label: 'AWS',
      color: '#FF9900',
      projects: [
        'project-aws-infrastructure',
        'project-aws-monitoring',
        'project-aws-solutions'
      ]
    },
    'azure': {
      label: 'Azure',
      color: '#0078D4',
      projects: [
        'project-azure-aks',
        'project-azure-hybrid',
        'project-azure-serverless'
      ]
    },
    'gcp': {
      label: 'GCP',
      color: '#4285F4',
      projects: [
        'project-gcp-ml',
        'project-gcp-serverless'
      ]
    },
    'kubernetes': {
      label: 'Kubernetes',
      color: '#326CE5',
      projects: [
        'project-eks-platform',
        'project-azure-aks',
        'project-kubernetes-vpn'
      ]
    },
    'docker': {
      label: 'Docker',
      color: '#2496ED',
      projects: [
        'project-docker-ansible-role',
        'project-dockernet-project',
        'project-ultimate-devops-container'
      ]
    },
    'cicd': {
      label: 'CI/CD',
      color: '#139B42',
      projects: [
        'project-enterprise-cicd',
        'project-devops-mission-control'
      ]
    },
    'monitoring': {
      label: 'Monitoring',
      color: '#47B881',
      projects: [
        'project-monitoring-stack',
        'project-aws-monitoring'
      ]
    }
  },

  /**
   * Generate breadcrumb HTML
   * @param {string} currentPage - Current page filename
   * @param {string} currentPageTitle - Display title for current page
   * @returns {string} HTML for breadcrumbs
   */
  generateBreadcrumb(currentPage, currentPageTitle) {
    let breadcrumbHTML = '<nav class="breadcrumb" aria-label="Breadcrumb">';
    breadcrumbHTML += '<ol class="breadcrumb-list">';
    
    // Home link
    breadcrumbHTML += `<li class="breadcrumb-item"><a href="index.html">Home</a></li>`;
    
    // Determine category
    let category = this.getProjectCategory(currentPage);
    
    if (currentPage.startsWith('project-')) {
      // Project page breadcrumb: Home > Projects > [Category] > ProjectName
      breadcrumbHTML += `<li class="breadcrumb-item"><a href="projects.html">Projects</a></li>`;
      
      if (category) {
        breadcrumbHTML += `<li class="breadcrumb-item"><a href="projects.html#${category}">${this.projects[category].label}</a></li>`;
      }
      
      breadcrumbHTML += `<li class="breadcrumb-item active">${currentPageTitle}</li>`;
    } else if (currentPage.startsWith('article-')) {
      // Article page breadcrumb: Home > Blog > Article
      breadcrumbHTML += `<li class="breadcrumb-item"><a href="blog-articles.html">Blog</a></li>`;
      breadcrumbHTML += `<li class="breadcrumb-item active">${currentPageTitle}</li>`;
    } else {
      // Other pages
      breadcrumbHTML += `<li class="breadcrumb-item active">${currentPageTitle}</li>`;
    }
    
    breadcrumbHTML += '</ol></nav>';
    return breadcrumbHTML;
  },

  /**
   * Get category for a project
   * @param {string} projectFile - Project filename
   * @returns {string|null} Category name or null
   */
  getProjectCategory(projectFile) {
    for (const [category, data] of Object.entries(this.projects)) {
      if (data.projects.some(p => projectFile.includes(p))) {
        return category;
      }
    }
    return null;
  },

  /**
   * Inject breadcrumb into page
   * @param {string} containerId - ID of element to inject into
   * @param {string} currentPage - Current page filename
   * @param {string} currentPageTitle - Display title
   */
  injectBreadcrumb(containerId, currentPage, currentPageTitle) {
    const container = document.getElementById(containerId);
    if (container) {
      const breadcrumbHTML = this.generateBreadcrumb(currentPage, currentPageTitle);
      container.insertAdjacentHTML('beforeend', breadcrumbHTML);
      this.injectStyles();
    }
  },

  /**
   * Inject breadcrumb styles
   */
  injectStyles() {
    // Check if styles already injected
    if (document.getElementById('breadcrumb-styles')) return;
    
    const styles = `
      <style id="breadcrumb-styles">
        .breadcrumb {
          padding: 1rem 0;
          margin-bottom: 1.5rem;
          border-bottom: 1px solid rgba(102, 217, 239, 0.2);
        }

        .breadcrumb-list {
          list-style: none;
          padding: 0;
          margin: 0;
          display: flex;
          flex-wrap: wrap;
          gap: 0.5rem;
          align-items: center;
        }

        .breadcrumb-item {
          display: flex;
          align-items: center;
          font-size: 0.95rem;
        }

        .breadcrumb-item:not(:last-child)::after {
          content: '›';
          margin-left: 0.5rem;
          color: #66d9ef;
          font-weight: bold;
        }

        .breadcrumb-item a {
          color: #66d9ef;
          text-decoration: none;
          transition: all 0.3s ease;
          padding: 0.25rem 0.5rem;
          border-radius: 4px;
        }

        .breadcrumb-item a:hover {
          color: #a6e22e;
          background: rgba(166, 226, 46, 0.1);
        }

        .breadcrumb-item.active {
          color: #a6e22e;
          font-weight: 600;
        }

        @media (max-width: 768px) {
          .breadcrumb {
            padding: 0.75rem 0;
            margin-bottom: 1rem;
          }

          .breadcrumb-list {
            gap: 0.3rem;
            font-size: 0.85rem;
          }

          .breadcrumb-item:not(:last-child)::after {
            margin-left: 0.3rem;
          }

          .breadcrumb-item a {
            padding: 0.2rem 0.3rem;
          }
        }

        @media (max-width: 480px) {
          .breadcrumb {
            padding: 0.5rem 0;
            margin-bottom: 0.75rem;
          }

          .breadcrumb-list {
            gap: 0.2rem;
            font-size: 0.75rem;
          }

          .breadcrumb-item:not(:last-child)::after {
            margin-left: 0.2rem;
          }

          .breadcrumb-item a {
            padding: 0.15rem 0.2rem;
          }
        }

        @media (max-width: 360px) {
          .breadcrumb {
            padding: 0.4rem 0;
            margin-bottom: 0.5rem;
          }

          .breadcrumb-list {
            gap: 0.1rem;
            font-size: 0.65rem;
          }

          .breadcrumb-item:not(:last-child)::after {
            margin-left: 0.1rem;
            font-size: 0.8rem;
          }

          .breadcrumb-item a {
            padding: 0.1rem;
          }
        }
      </style>
    `;
    
    document.head.insertAdjacentHTML('beforeend', styles);
  }
};

// Auto-initialize if DOM is ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => {
    BreadcrumbSystem.injectStyles();
  });
} else {
  BreadcrumbSystem.injectStyles();
}

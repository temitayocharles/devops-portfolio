/**
 * Dark Mode Toggle Implementation
 * Handles theme switching with localStorage persistence
 */

(function() {
  'use strict';

  const THEME_KEY = 'portfolio-theme';
  const THEME_DARK = 'dark';
  const THEME_LIGHT = 'light';

  // Get saved theme or default to user's preference
  function getSavedTheme() {
    const saved = localStorage.getItem(THEME_KEY);
    if (saved) return saved;
    
    // Check system preference
    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      return THEME_DARK;
    }
    
    return THEME_DARK; // Default to dark since current design is dark
  }

  // Apply theme to document
  function applyTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem(THEME_KEY, theme);
    
    // Update toggle button state if it exists
    const toggle = document.getElementById('theme-toggle');
    if (toggle) {
      toggle.setAttribute('aria-label', `Switch to ${theme === THEME_DARK ? 'light' : 'dark'} mode`);
      toggle.textContent = theme === THEME_DARK ? '☀️' : '🌙';
    }
  }

  // Toggle between themes
  function toggleTheme() {
    const current = document.documentElement.getAttribute('data-theme') || THEME_DARK;
    const next = current === THEME_DARK ? THEME_LIGHT : THEME_DARK;
    applyTheme(next);
  }

  // Initialize theme on page load
  function initializeTheme() {
    const theme = getSavedTheme();
    applyTheme(theme);
  }

  // Listen for system theme changes
  if (window.matchMedia) {
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
      // Only auto-switch if user hasn't manually set a preference
      if (!localStorage.getItem(THEME_KEY)) {
        applyTheme(e.matches ? THEME_DARK : THEME_LIGHT);
      }
    });
  }

  // Initialize immediately (before DOM loads) to prevent flash
  initializeTheme();

  // Expose toggle function globally
  window.toggleTheme = toggleTheme;

  // Initialize after DOM loads
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeTheme);
  }
})();

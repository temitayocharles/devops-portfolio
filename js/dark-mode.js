/**
 * Dark mode is now enforced globally across the portfolio.
 * Theme toggle UI is removed to keep visual consistency.
 */

(function() {
  'use strict';

  const THEME_KEY = 'portfolio-theme';
  const THEME_DARK = 'dark';

  function enforceDarkTheme() {
    document.documentElement.setAttribute('data-theme', THEME_DARK);
    localStorage.setItem(THEME_KEY, THEME_DARK);
  }

  function removeThemeToggles() {
    document.querySelectorAll('#theme-toggle, .theme-toggle').forEach((el) => el.remove());
  }

  // Keep compatibility with existing inline onclick handlers.
  window.toggleTheme = function() {
    enforceDarkTheme();
    removeThemeToggles();
  };

  enforceDarkTheme();

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
      enforceDarkTheme();
      removeThemeToggles();
    });
  } else {
    removeThemeToggles();
  }
})();

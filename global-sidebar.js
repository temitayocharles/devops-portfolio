/* Accessible global sidebar controls (replaces previous implementation)
   - Ensures a visible toggle is present
   - Manages aria-expanded / aria-hidden
   - Locks body scroll while open
   - Traps focus inside the sidebar
   - Closes on Escape, overlay click, or nav selection
   - Announces open/close via aria-live
*/
(function () {
  'use strict';

  var DEFAULTS = {
    sidebarSelector: '.global-sidebar',
    toggleSelector: '.sidebar-toggle',
    overlaySelector: '.sidebar-overlay',
    closeSelector: '.sidebar-close',
    focusableSelector: 'a[href], button:not([disabled]), textarea, input, select, [tabindex]:not([tabindex="-1"])'
  };

  function $(sel, ctx) { return (ctx || document).querySelector(sel); }
  function $all(sel, ctx) { return Array.prototype.slice.call((ctx || document).querySelectorAll(sel)); }

  function createToggleIfMissing(toggleSelector) {
    var toggle = $(toggleSelector);
    if (toggle) return toggle;

    toggle = document.createElement('button');
    toggle.className = toggleSelector.replace('.', '');
    toggle.setAttribute('aria-controls', DEFAULTS.sidebarSelector.replace('.', ''));
    toggle.setAttribute('aria-expanded', 'false');
    toggle.setAttribute('type', 'button');
    toggle.innerHTML = '☰ Menu';
    // Ensure visible for small screens; style overrides live in CSS
    document.body.appendChild(toggle);
    return toggle;
  }

  function ensureAriaLive() {
    var live = document.getElementById('sidebar-aria-live');
    if (live) return live;
    live = document.createElement('div');
    live.id = 'sidebar-aria-live';
    live.className = 'sr-only';
    live.setAttribute('aria-live', 'polite');
    live.setAttribute('aria-atomic', 'true');
    document.body.appendChild(live);
    return live;
  }

  function getFocusableElements(container) {
    return $all(DEFAULTS.focusableSelector, container).filter(function (el) {
      return el.offsetWidth > 0 || el.offsetHeight > 0 || el.getAttribute('tabindex') !== '-1';
    });
  }

  function trapFocus(root, e) {
    var focusables = getFocusableElements(root);
    if (!focusables.length) return;
    var first = focusables[0];
    var last = focusables[focusables.length - 1];

    if (e.key === 'Tab') {
      if (e.shiftKey) {
        if (document.activeElement === first) {
          e.preventDefault();
          last.focus();
        }
      } else {
        if (document.activeElement === last) {
          e.preventDefault();
          first.focus();
        }
      }
    }
  }

  function openSidebar(opts) {
    var sidebar = opts.sidebar;
    var overlay = opts.overlay;
    var toggle = opts.toggle;
    if (sidebar.classList.contains('open')) return;

    opts.previouslyFocused = document.activeElement;

    sidebar.classList.add('open');
    overlay.classList.add('active');
    toggle.setAttribute('aria-expanded', 'true');
    sidebar.setAttribute('aria-hidden', 'false');
    document.body.classList.add('no-scroll');

    // move focus to first focusable element inside sidebar
    var focusables = getFocusableElements(sidebar);
    if (focusables.length) {
      focusables[0].focus();
    } else {
      // otherwise focus the sidebar itself
      sidebar.setAttribute('tabindex', '-1');
      sidebar.focus();
    }

    ensureAriaLive().textContent = 'Navigation menu opened';

    // bind escape and tab handler
    opts._keydownHandler = function (e) {
      if (e.key === 'Escape') {
        e.preventDefault();
        closeSidebar(opts);
        return;
      }
      trapFocus(sidebar, e);
    };

    document.addEventListener('keydown', opts._keydownHandler);
  }

  function closeSidebar(opts) {
    var sidebar = opts.sidebar;
    var overlay = opts.overlay;
    var toggle = opts.toggle;
    if (!sidebar.classList.contains('open')) return;

    sidebar.classList.remove('open');
    overlay.classList.remove('active');
    toggle.setAttribute('aria-expanded', 'false');
    sidebar.setAttribute('aria-hidden', 'true');
    document.body.classList.remove('no-scroll');

    ensureAriaLive().textContent = 'Navigation menu closed';

    // restore focus
    if (opts.previouslyFocused && typeof opts.previouslyFocused.focus === 'function') {
      opts.previouslyFocused.focus();
    }

    if (opts._keydownHandler) {
      document.removeEventListener('keydown', opts._keydownHandler);
      opts._keydownHandler = null;
    }
  }

  function init() {
    var sidebar = $(DEFAULTS.sidebarSelector);
    if (!sidebar) return; // nothing to do

    // ensure the sidebar is accessible by default
    sidebar.setAttribute('role', sidebar.getAttribute('role') || 'navigation');
    sidebar.setAttribute('aria-hidden', 'true');

    var overlay = $(DEFAULTS.overlaySelector);
    if (!overlay) {
      overlay = document.createElement('div');
      overlay.className = DEFAULTS.overlaySelector.replace('.', '');
      document.body.appendChild(overlay);
    }

    var toggle = createToggleIfMissing(DEFAULTS.toggleSelector);

    var closeBtn = $(DEFAULTS.closeSelector, sidebar);
    if (!closeBtn) {
      // add a small close button in the header if missing
      closeBtn = document.createElement('button');
      closeBtn.className = DEFAULTS.closeSelector.replace('.', '');
      closeBtn.setAttribute('type', 'button');
      closeBtn.setAttribute('aria-label', 'Close navigation');
      closeBtn.innerHTML = '✕';
      // place at start of sidebar
      sidebar.insertBefore(closeBtn, sidebar.firstChild);
    }

    // Prepare opts object to hold handlers/state
    var opts = { sidebar: sidebar, overlay: overlay, toggle: toggle, closeBtn: closeBtn };

    // Click handlers
    toggle.addEventListener('click', function () {
      if (sidebar.classList.contains('open')) {
        closeSidebar(opts);
      } else {
        openSidebar(opts);
      }
    });

    overlay.addEventListener('click', function () { closeSidebar(opts); });
    closeBtn.addEventListener('click', function () { closeSidebar(opts); });

    // Close sidebar when a nav link inside it is activated (good for single-page nav)
    var navLinks = $all('a', sidebar);
    navLinks.forEach(function (link) {
      link.addEventListener('click', function () {
        // if link has hash or href, we still close to improve UX on mobile
        // small timeout to allow native navigation focus change
        setTimeout(function () { closeSidebar(opts); }, 50);
      });
    });

    // ensure all interactive elements inside sidebar are reachable
    sidebar.addEventListener('keydown', function (e) {
      // Prevent focus leaving the sidebar when it's open
      if (!sidebar.classList.contains('open')) return;
      trapFocus(sidebar, e);
    });

    // Make sure toggle and sidebar have correct initial attributes
    toggle.setAttribute('aria-expanded', 'false');
    toggle.setAttribute('aria-controls', sidebar.id || DEFAULTS.sidebarSelector.replace('.', ''));

    // If sidebar has no id, give it one so aria-controls points to it
    if (!sidebar.id) sidebar.id = 'global-sidebar';
    sidebar.setAttribute('aria-hidden', 'true');

    // Prevent accidentally focusing content behind the sidebar by setting inert on main content when open
    // Use a best-effort approach: mark siblings of sidebar as inert where supported
    function setInertOnSiblings(enable) {
      var bodyChildren = Array.prototype.slice.call(document.body.children);
      bodyChildren.forEach(function (child) {
        if (child === sidebar || child === overlay || child === toggle || child.id === 'sidebar-aria-live') return;
        try { child.inert = enable; } catch (e) { /* inert may not be supported */ }
      });
    }

    // Enhance open/close behavior to toggle inert where supported
    var originalOpen = openSidebar;
    openSidebar = function (opts) {
      setInertOnSiblings(true);
      originalOpen(opts);
    };
    var originalClose = closeSidebar;
    closeSidebar = function (opts) {
      setInertOnSiblings(false);
      originalClose(opts);
    };

    // Mark that init ran
    document.documentElement.classList.add('sidebar-init');
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

})();
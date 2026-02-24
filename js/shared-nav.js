(function () {
  const NAV_ITEMS = [
    { key: "home", label: "Home", href: "index.html", icon: "🏠" },
    { key: "about", label: "About", href: "about-me.html", icon: "👤" },
    { key: "skills", label: "Skills", href: "skills.html", icon: "⚡" },
    { key: "projects", label: "Projects", href: "projects.html", icon: "🚀" },
    { key: "blog", label: "Blog", href: "blog-articles.html", icon: "✍️" },
    { key: "contact", label: "Contact", href: "contact.html", icon: "📧" }
  ];

  window.SHARED_PRIMARY_NAV = NAV_ITEMS;

  function fileFromHref(href) {
    if (!href) return "";
    return href.split("/").pop().split("#")[0];
  }

  function activeKeyFromLocation() {
    const file = fileFromHref(window.location.pathname) || "index.html";
    const map = {
      "index.html": "home",
      "about-me.html": "about",
      "skills.html": "skills",
      "projects.html": "projects",
      "blog-articles.html": "blog",
      "contact.html": "contact"
    };
    return map[file] || "";
  }

  function applySharedNav(container, isSidebar) {
    const activeKey = activeKeyFromLocation();
    const linkClass = isSidebar
      ? "sidebar-nav-item"
      : (container.classList.contains("nav-links") || container.classList.contains("nav-menu") ? "nav-link" : "");

    const existingAnchors = [...container.querySelectorAll(":scope > a")];
    const anchorsByHref = new Map(existingAnchors.map((a) => [fileFromHref(a.getAttribute("href")), a]));
    const extras = [...container.children].filter((el) => el.tagName !== "A");

    const fragment = document.createDocumentFragment();
    NAV_ITEMS.forEach((item) => {
      const anchor = anchorsByHref.get(item.href) || document.createElement("a");
      anchor.href = item.href;
      anchor.textContent = item.label;

      if (linkClass) {
        anchor.className = linkClass;
      }
      if (item.key === activeKey) {
        anchor.classList.add("active");
      } else {
        anchor.classList.remove("active");
      }

      fragment.appendChild(anchor);
    });

    extras.forEach((el) => fragment.appendChild(el));

    while (container.firstChild) {
      container.removeChild(container.firstChild);
    }
    container.appendChild(fragment);
  }

  function syncNavigation() {
    const primarySelectors = [".nav-links", ".nav-menu", "nav[data-shared-nav='primary']"];
    primarySelectors.forEach((selector) => {
      document.querySelectorAll(selector).forEach((container) => applySharedNav(container, false));
    });

    document.querySelectorAll(".sidebar-nav").forEach((container) => applySharedNav(container, true));
  }

  document.addEventListener("DOMContentLoaded", syncNavigation);
})();

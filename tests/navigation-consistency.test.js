const fs = require("fs");
const path = require("path");

const ROOT = path.resolve(__dirname, "..");
const CORE_PAGES = [
  "index.html",
  "about-me.html",
  "skills.html",
  "projects.html",
  "contact.html",
  "blog-articles.html"
];

describe("shared navigation wiring", () => {
  test("core pages load shared nav script", () => {
    for (const page of CORE_PAGES) {
      const html = fs.readFileSync(path.join(ROOT, page), "utf8");
      expect(html).toMatch(/js\/shared-nav\.js/);
    }
  });

  test("shared nav defines canonical primary order", () => {
    const source = fs.readFileSync(path.join(ROOT, "js", "shared-nav.js"), "utf8");
    const expected = [
      "index.html",
      "about-me.html",
      "skills.html",
      "projects.html",
      "blog-articles.html",
      "contact.html"
    ];

    let cursor = 0;
    for (const href of expected) {
      const idx = source.indexOf(`href: "${href}"`);
      expect(idx).toBeGreaterThan(cursor);
      cursor = idx;
    }
  });
});

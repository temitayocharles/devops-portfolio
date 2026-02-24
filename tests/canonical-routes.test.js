const fs = require("fs");
const path = require("path");

const ROOT = path.resolve(__dirname, "..");

describe("canonical routing and discovery", () => {
  test("netlify redirects legacy routes to canonical pages", () => {
    const netlifyToml = fs.readFileSync(path.join(ROOT, "netlify.toml"), "utf8");

    const requiredPairs = [
      ["/about.html", "/about-me.html"],
      ["/blog.html", "/blog-articles.html"],
      ["/projects-new.html", "/projects.html"],
      ["/resume-ats", "/resume-ats.html"],
      ["/resume-visual", "/resume-visual.html"]
    ];

    for (const [from, to] of requiredPairs) {
      expect(netlifyToml).toContain(`from = "${from}"`);
      expect(netlifyToml).toContain(`to = "${to}"`);
    }
  });

  test("sitemap uses canonical blog listing page", () => {
    const sitemap = fs.readFileSync(path.join(ROOT, "sitemap.xml"), "utf8");
    expect(sitemap).toContain("blog-articles.html");
    expect(sitemap).not.toContain("blog.html</loc>");
  });
});

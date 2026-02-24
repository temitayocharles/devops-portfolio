const fs = require("fs");
const path = require("path");

const ROOT = path.resolve(__dirname, "..");
const HTML_FILES = fs.readdirSync(ROOT).filter((f) => f.endsWith(".html"));

function read(file) {
  return fs.readFileSync(path.join(ROOT, file), "utf8");
}

function extractAttrs(html, attr) {
  const regex = new RegExp(`${attr}="([^"]+)"`, "g");
  const values = [];
  let match;
  while ((match = regex.exec(html)) !== null) {
    values.push(match[1]);
  }
  return values;
}

function isLocalRef(value) {
  if (!value) return false;
  if (value.startsWith("#")) return true;
  if (value.startsWith("http://") || value.startsWith("https://")) return false;
  if (value.startsWith("mailto:") || value.startsWith("tel:")) return false;
  if (value.startsWith("javascript:") || value.startsWith("data:")) return false;
  if (value.startsWith("/")) return false;
  return true;
}

function filePart(ref) {
  return ref.split("#")[0].split("?")[0];
}

function anchorPart(ref) {
  const parts = ref.split("#");
  return parts.length > 1 ? parts[1] : "";
}

function idsInHtml(html) {
  return new Set((html.match(/id="[^"]+"/g) || []).map((m) => m.slice(4, -1)));
}

describe("html integrity", () => {
  test("local href/src targets exist and in-page anchors resolve", () => {
    const htmlCache = new Map(HTML_FILES.map((f) => [f, read(f)]));
    const missing = [];

    for (const file of HTML_FILES) {
      const html = htmlCache.get(file);
      const refs = [...extractAttrs(html, "href"), ...extractAttrs(html, "src")].filter(isLocalRef);
      const currentIds = idsInHtml(html);

      for (const ref of refs) {
        if (ref.startsWith("#")) {
          const anchor = anchorPart(ref);
          if (anchor && !currentIds.has(anchor)) {
            missing.push(`${file}: missing in-page anchor #${anchor}`);
          }
          continue;
        }

        const targetFile = filePart(ref);
        if (!targetFile) continue;
        if (!fs.existsSync(path.join(ROOT, targetFile))) {
          missing.push(`${file}: missing target ${ref}`);
          continue;
        }

        const targetAnchor = anchorPart(ref);
        if (targetAnchor && targetFile.endsWith(".html")) {
          const targetHtml = htmlCache.get(targetFile) || read(targetFile);
          if (!idsInHtml(targetHtml).has(targetAnchor)) {
            missing.push(`${file}: missing target anchor ${ref}`);
          }
        }
      }
    }

    expect(missing).toEqual([]);
  });
});

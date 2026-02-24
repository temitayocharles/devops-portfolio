const { test, expect } = require("@playwright/test");

test("projects page defaults to flagship tier", async ({ page }) => {
  await page.goto("/projects.html");

  const activeTab = page.locator(".tier-tab.active");
  await expect(activeTab).toContainText("Flagship First");

  const visibleCards = page.locator(".project-card:visible");
  await expect(visibleCards.first()).toBeVisible();

  const count = await visibleCards.count();
  expect(count).toBeGreaterThan(0);
});

test("projects tier filter switches card sets", async ({ page }) => {
  await page.goto("/projects.html");

  await page.getByRole("button", { name: /Strategic Cases/i }).click();
  const strategicCards = page.locator('.project-card[data-tier="tier-b"]:visible');
  await expect(strategicCards.first()).toBeVisible();

  await page.getByRole("button", { name: /All Projects/i }).click();
  const allVisible = page.locator(".project-card:visible");
  const totalAll = await allVisible.count();
  expect(totalAll).toBeGreaterThan(8);
});

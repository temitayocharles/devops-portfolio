const { test, expect } = require('@playwright/test');

test('portfolio homepage renders', async ({ page }) => {
  await page.goto('/');
  await expect(page.locator('body')).toContainText('DevOps');
});

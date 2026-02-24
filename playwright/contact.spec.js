const { test, expect } = require("@playwright/test");

test("contact form shows validation errors for empty submit", async ({ page }) => {
  await page.goto("/contact.html");

  await page.locator("#contactForm .submit-btn").click();

  const formIsValid = await page.$eval("#contactForm", (form) => form.checkValidity());
  expect(formIsValid).toBe(false);
  await expect(page.locator("#contactForm :invalid")).toHaveCount(4);

  const nameValidationMessage = await page.$eval("#name", (field) => field.validationMessage);
  expect(nameValidationMessage.length).toBeGreaterThan(0);
});

test("contact form validates email format", async ({ page }) => {
  await page.goto("/contact.html");

  await page.fill("#name", "Test User");
  await page.fill("#email", "invalid-email");
  await page.fill("#subject", "Test Subject");
  await page.fill("#message", "This is a test message with enough length.");

  await page.locator("#contactForm .submit-btn").click();

  const formIsValid = await page.$eval("#contactForm", (form) => form.checkValidity());
  expect(formIsValid).toBe(false);
  await expect(page.locator("#email:invalid")).toHaveCount(1);

  const emailValidationMessage = await page.$eval("#email", (field) => field.validationMessage);
  expect(emailValidationMessage.length).toBeGreaterThan(0);
});

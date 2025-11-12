# 🧪 Testing Setup Guide

**Prerequisites:** Node.js must be installed first

## Quick Setup

```bash
# 1. Install Node.js (if not already installed)
brew install node

# 2. Verify installation
node --version
npm --version

# 3. Navigate to project directory
cd /Users/charlie/Desktop/my-portfolio/devops-portfolio

# 4. Initialize npm project (if package.json doesn't have all deps)
npm install

# 5. Install testing dependencies
npm install --save-dev jest @testing-library/jest-dom @testing-library/dom
npm install --save-dev @playwright/test
npm install --save-dev @axe-core/playwright
npm install --save-dev eslint prettier
npm install --save-dev terser cssnano postcss
```

## Jest Configuration

Create `jest.config.js`:

```javascript
module.exports = {
  testEnvironment: 'jsdom',
  roots: ['<rootDir>/tests'],
  testMatch: ['**/__tests__/**/*.js', '**/?(*.)+(spec|test).js'],
  collectCoverageFrom: [
    'js/**/*.js',
    'netlify/**/*.js',
    '!js/dark-mode.js', // Exclude if needed
    '!**/node_modules/**',
  ],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80,
    },
  },
  setupFilesAfterEnv: ['<rootDir>/tests/setup.js'],
};
```

## Playwright Configuration

Create `playwright.config.js`:

```javascript
const { devices } = require('@playwright/test');

module.exports = {
  testDir: './tests/e2e',
  timeout: 30000,
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  use: {
    baseURL: 'http://localhost:8080',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    },
    {
      name: 'Mobile Chrome',
      use: { ...devices['Pixel 5'] },
    },
    {
      name: 'Mobile Safari',
      use: { ...devices['iPhone 12'] },
    },
  ],
  webServer: {
    command: 'python3 -m http.server 8080',
    port: 8080,
    reuseExistingServer: !process.env.CI,
  },
};
```

## Test Files to Create

### Unit Tests

**`tests/unit/contact-form.test.js`**
```javascript
describe('Contact Form Validation', () => {
  test('validates email format', () => {
    const validEmail = 'test@example.com';
    const invalidEmail = 'invalid-email';
    // Test email regex
  });

  test('requires all mandatory fields', () => {
    // Test required field validation
  });

  test('handles form submission', () => {
    // Test form submission logic
  });
});
```

**`tests/unit/dark-mode.test.js`**
```javascript
describe('Dark Mode Toggle', () => {
  test('saves theme preference to localStorage', () => {
    // Test localStorage persistence
  });

  test('respects system preference', () => {
    // Test prefers-color-scheme
  });

  test('toggles between light and dark', () => {
    // Test theme switching
  });
});
```

### E2E Tests

**`tests/e2e/navigation.spec.js`**
```javascript
const { test, expect } = require('@playwright/test');

test.describe('Navigation', () => {
  test('homepage loads correctly', async ({ page }) => {
    await page.goto('/');
    await expect(page).toHaveTitle(/Temitayo Charles/);
  });

  test('navigates to projects page', async ({ page }) => {
    await page.goto('/');
    await page.click('text=Projects');
    await expect(page).toHaveURL(/projects.html/);
  });

  test('mobile menu works', async ({ page }) => {
    await page.setViewportSize({ width: 375, height: 667 });
    await page.goto('/');
    await page.click('[aria-label="Toggle navigation menu"]');
    // Assert mobile menu is visible
  });
});
```

**`tests/e2e/dark-mode.spec.js`**
```javascript
const { test, expect } = require('@playwright/test');

test.describe('Dark Mode', () => {
  test('toggles theme on button click', async ({ page }) => {
    await page.goto('/');
    const toggle = await page.locator('#theme-toggle');
    
    // Check initial state
    const initialTheme = await page.getAttribute('html', 'data-theme');
    
    // Click toggle
    await toggle.click();
    
    // Verify theme changed
    const newTheme = await page.getAttribute('html', 'data-theme');
    expect(newTheme).not.toBe(initialTheme);
  });

  test('persists theme across page loads', async ({ page }) => {
    await page.goto('/');
    await page.click('#theme-toggle');
    await page.reload();
    
    // Theme should persist
    const theme = await page.getAttribute('html', 'data-theme');
    expect(theme).toBeTruthy();
  });
});
```

### Accessibility Tests

**`tests/a11y/accessibility.spec.js`**
```javascript
const { test, expect } = require('@playwright/test');
const AxeBuilder = require('@axe-core/playwright').default;

test.describe('Accessibility', () => {
  test('homepage has no accessibility violations', async ({ page }) => {
    await page.goto('/');
    const accessibilityScanResults = await new AxeBuilder({ page }).analyze();
    expect(accessibilityScanResults.violations).toEqual([]);
  });

  test('skip navigation works', async ({ page }) => {
    await page.goto('/');
    await page.keyboard.press('Tab');
    const skipLink = await page.locator('.skip-nav');
    await expect(skipLink).toBeFocused();
  });

  test('all images have alt text', async ({ page }) => {
    await page.goto('/');
    const images = await page.locator('img').all();
    for (const img of images) {
      const alt = await img.getAttribute('alt');
      expect(alt).toBeTruthy();
    }
  });
});
```

## Running Tests

```bash
# Run all Jest tests
npm test

# Run tests in watch mode
npm test -- --watch

# Run with coverage
npm test -- --coverage

# Run specific test file
npm test -- tests/unit/dark-mode.test.js

# Run Playwright tests
npx playwright test

# Run in headed mode (see browser)
npx playwright test --headed

# Run specific browser
npx playwright test --project=chromium

# Debug mode
npx playwright test --debug

# Show test report
npx playwright show-report
```

## ESLint & Prettier Setup

**`.eslintrc.js`**
```javascript
module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true,
    jest: true,
  },
  extends: ['eslint:recommended'],
  parserOptions: {
    ecmaVersion: 12,
    sourceType: 'module',
  },
  rules: {
    'no-console': ['warn', { allow: ['warn', 'error'] }],
    'no-unused-vars': 'error',
  },
};
```

**`.prettierrc`**
```json
{
  "singleQuote": true,
  "trailingComma": "es5",
  "tabWidth": 2,
  "semi": true,
  "printWidth": 100
}
```

## NPM Scripts to Add

Add to `package.json`:

```json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:e2e": "playwright test",
    "test:e2e:headed": "playwright test --headed",
    "test:a11y": "playwright test tests/a11y",
    "lint": "eslint js/ netlify/functions/ tests/",
    "lint:fix": "eslint js/ netlify/functions/ tests/ --fix",
    "format": "prettier --write \"**/*.{js,json,md}\"",
    "build": "node build.js",
    "serve": "python3 -m http.server 8080"
  }
}
```

## CI/CD Integration

**`.github/workflows/test.yml`**
```yaml
name: Tests

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run linter
        run: npm run lint
      
      - name: Run unit tests
        run: npm test -- --coverage
      
      - name: Install Playwright browsers
        run: npx playwright install --with-deps
      
      - name: Run E2E tests
        run: npm run test:e2e
      
      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: playwright-report
          path: playwright-report/
```

## Coverage Goals

Target coverage thresholds:
- **Statements:** 80%
- **Branches:** 80%
- **Functions:** 80%
- **Lines:** 80%

## Troubleshooting

### Common Issues

**1. Port 8080 already in use**
```bash
# Kill existing process
lsof -ti:8080 | xargs kill -9

# Or use different port
python3 -m http.server 3000
```

**2. Playwright browser install fails**
```bash
# Install with sudo
sudo npx playwright install --with-deps
```

**3. Jest can't find modules**
```bash
# Clear Jest cache
npm test -- --clearCache
```

**4. ESLint errors everywhere**
```bash
# Auto-fix what's possible
npm run lint:fix
```

## Next Steps After Setup

1. ✅ Run `npm test` to verify setup
2. ✅ Run `npx playwright test` for E2E tests
3. ✅ Check coverage report in `coverage/lcov-report/index.html`
4. ✅ Add pre-commit hooks with Husky
5. ✅ Set up CI/CD pipeline

---

**Ready to implement after Node.js installation!** 🚀

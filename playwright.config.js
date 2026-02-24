const { defineConfig, devices } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './playwright',
  timeout: 30 * 1000,
  use: {
    baseURL: 'http://localhost:8081',
    headless: true
  },
  webServer: {
    command: 'PORT=8081 node server.js',
    port: 8081,
    reuseExistingServer: true,
    timeout: 120 * 1000
  },
  projects: [
    {
      name: 'desktop',
      use: { ...devices['Desktop Chrome'] }
    },
    {
      name: 'mobile',
      use: { ...devices['Pixel 5'] }
    }
  ]
});

import nextEnv from '@next/env';
nextEnv.loadEnvConfig(process.cwd());
import {defineConfig,devices} from '@playwright/test';
export default defineConfig({testDir:'./tests',fullyParallel:false,workers:1,use:{baseURL:'http://localhost:3100',trace:'retain-on-failure'},webServer:{command:'npm run dev -- --port 3100',url:'http://localhost:3100',reuseExistingServer:!process.env.CI,timeout:120000},projects:[{name:'api',testMatch:'api.spec.ts'},{name:'desktop',testMatch:'ui.spec.ts',use:{...devices['Desktop Chrome']}},{name:'mobile',testMatch:'ui.spec.ts',use:{...devices['Pixel 7']}}]});

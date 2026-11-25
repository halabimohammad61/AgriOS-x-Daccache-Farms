# Verification and release limits

Release: Daccache Farms portable-stack update, 23 November 2026.

## Automated verification

- Hosted TypeScript check passed.
- Domain tests: 7 passed (decimal-safe money, quantities, dates, scoped profitability, inventory, alerts and the separate venture case).
- Hosted server workflow tests: 6 passed against actual transpiled action logic with a SQLite-backed D1 adapter.
- Relational SQLite tests: 5 passed (scoped foreign keys, rollback, guarded consumption, uniqueness and payment bounds).
- Portable TypeScript check passed.
- Portable geometry validation unit tests: 3 passed (closed rings, bounds, finite coordinates and geometry types).
- Actual Next.js production build passed. A clean extracted package installed with `npm ci` and passed TypeScript and production build without parent-project dependencies.
- PostgreSQL migration executed successfully and a second execution preserved the existing schema.
- Playwright API integration suite: 7 passed using the actual node-postgres adapter and PostgreSQL/PostGIS SQL. It covers anonymous write rejection, receipt/consumption/cost reconciliation, idempotency, concurrent guarded consumption, harvest/sale/payment bounds, one-time task labor costing, spatial geometry/area/index checks and cross-owner foreign keys.

The PostgreSQL integration environment used PGlite’s PostgreSQL WebAssembly engine plus its experimental PostGIS extension through a local pg-wire socket. This verifies real PostgreSQL SQL and PostGIS operations, but is not a substitute for native multi-session PostgreSQL 17 concurrency/load testing. The distributable uses node-postgres and the postgis/postgis Docker image, not PGlite. Docker is not installed in this execution environment; its Compose startup was not exercised here. Native Windows PowerShell, macOS, ARM hardware and Docker image availability require platform acceptance tests.

## Browser verification

The previous release had all 16 sections checked in the anonymous demonstration. In this update, corrected branding, company-location text and the Living farm panel were inspected in the managed browser. Apache ECharts rendered its accessible financial series in the managed browser. MapLibre initialization reached the map canvas, but the managed browser reports WebGL disabled. A readable address/coordinate card and external map link are implemented as the fallback; interactive GPU map rendering is not independently verified here.

Desktop/mobile Playwright browser acceptance specifications are included in the portable package for local execution. They have not been run through the CLI here. Browser automation in this environment uses the managed browser tool.

## Honest limits

Sample fields, crop plans, staff, costs, harvests, invoices and sensor values remain fictional. The real map pin identifies Daccache Agriculture’s head office/factory in Bazioun, not surveyed growing plots. Field GeoJSON is supplied by the user, validated in PostGIS and kept separate from schematic coordinates and operational hectares. Weather uses the office reference and labels fallback values explicitly.

The Figma URL was a private recent-files dashboard; a specific accessible design-file link remains pending. No claim of an exact Figma match is made. There is one owner account locally; staff invitations, delegated permissions, live sensors, actuators, complete Arabic localization, automatic hosted/local data synchronization, validated yield models and statutory accounting are not implemented. No independent security, accessibility, performance or agronomic certification is claimed.

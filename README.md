# AgriOS — Daccache Farms

A local Next.js application for Daccache Agriculture, with PostgreSQL/PostGIS, MapLibre, Apache ECharts, shadcn/ui components, Open-Meteo and Playwright tests.

## Start from Windows PowerShell, macOS or Linux

Install Node.js 22.13+ (Node 24 LTS recommended) and Docker Desktop with Docker Compose. On Windows, start Docker Desktop with Linux containers enabled. On Linux, Docker Engine plus its Compose plugin is sufficient. Extract the ZIP to a normal writable folder. Open your terminal in that folder:

```powershell
npm install
npm run setup
npm run db:up
npm run db:migrate
npm run dev
```

Alternatively, after installing Node.js and starting Docker Desktop, run `node start-daccache.mjs` to perform the same steps automatically. Use `node start-daccache.mjs --external-db` only after configuring your own PostgreSQL connection.

Save the owner password shown by `setup` in your password manager. Open **http://localhost:3000**, then sign in. The server binds to loopback by default. The public page is a read-only demonstration; saved records require owner login. Initial owner records are fictional sample data, not Daccache accounts or surveyed parcels.

If PowerShell blocks `npm.ps1`, use `npm.cmd` in place of `npm` for these commands. No execution-policy change is needed. Node, Docker and internet access for dependency installation are prerequisites; the application does not run inside a bare terminal without them.

If database startup is still in progress, wait until `docker compose ps` reports healthy and repeat `npm run db:migrate`. Migrations are transactional, checksum-checked and safe to repeat.

For a production build on your own computer:

```powershell
npm run build
npm start
```

For a different local port: `npm run dev -- --port 3100` or `npm start -- --port 3100`. Stop the app with Ctrl+C. Stop the database using `docker compose stop db`. Start it again with `npm run db:up`. **Do not use `docker compose down -v` unless you intend to permanently remove the local database.**

## Your own PostgreSQL installation

Docker is optional if you already run PostgreSQL 17+ with a compatible PostGIS extension. Run `npm run setup`, edit `.env.local` so `DATABASE_URL` points to your database, then run `npm run db:migrate`. The database role needs permission to create the PostGIS extension (or ask your database administrator to enable it first). Skip `db:up`. Secrets stay server-side.

## Included functionality

Field/crop register, task assignment/completion, input receipts and consumption, irrigation and expense allocation, equipment servicing, harvest batches, delivered sales, invoices and partial payments, inventory protection, finance and scenarios, evidence desk, reports, audit, offline task/water drafts, themes and Arabic navigation. Monetary amounts remain integer cents. Transactions run with PostgreSQL SERIALIZABLE isolation and bounded serialization retries.

The Living farm page uses MapLibre for the real company reference point. Signed-in users can upload authorized GeoJSON Polygon geometry to PostGIS, validate it, display boundaries and calculate geodesic area. This does not rewrite sample field areas. No farm boundaries are invented. The separate schematic is explicitly illustrative.

Apache ECharts displays actual workspace financial and irrigation calculations with an accessible data table. shadcn/ui Button is used for boundary registration and custom farm styling is retained. Weather requests Open-Meteo for the company office reference using Asia/Beirut; fallback is explicitly labelled. Provider usage terms, basemap attribution and commercial weather licensing need review for your intended deployment.

## Location and Figma

Daccache Agriculture’s official contact page identifies **Bazioun, Jbeil, Lebanon** as its **head office and factory**. Its embedded map reference is 34.0929847, 35.7496416. Exact growing plots have not been confirmed. See `docs/LOCATION.md`.

The supplied Figma link points to a recent-files dashboard, not a specific design. No private Figma design was accessed or copied. `docs/DESIGN.md` contains the current visual tokens and handoff guide. A specific accessible Figma file is needed to match it exactly.

## Verification commands

```powershell
npm run typecheck
npm test
npm run test:api
```

`test:api` uses Playwright's HTTP test runner against the local app, without a browser. Start the database and run migrations first. It starts Next.js on port 3100. Tests use a uniquely named test workspace and clean its own records; they do not modify the owner’s operational workspace.

For desktop/mobile browser acceptance tests on your computer:

```powershell
npx playwright install chromium
npm run test:e2e
```

Browser tests cover public navigation, the map reference, finance/scenarios and mobile layout. Read the release-specific verification status in `docs/QUALITY.md`; included tests are not automatically proof that they ran on Windows or every browser.

## Data and security

There is one local owner account. The local password is scrypt-hashed, session cookies are HTTP-only, same-site and signed, and sign-in attempts are rate-limited in PostgreSQL. Never expose this localhost setup directly on the internet. For self-hosted HTTPS, use an authenticated reverse proxy, set `AGRIOS_SECURE_COOKIE=true`, rotate setup secrets, arrange database backups, and review deployment security. This package does not implement staff invitations or delegated permissions.

Keep `.env`, `.env.local`, database volumes and passwords private. To change the owner password, replace `AGRIOS_PASSWORD_HASH` using a securely generated salt and scrypt hash; changing `AGRIOS_SESSION_SECRET` invalidates existing sessions. `setup` never overwrites existing configuration.

The hosted ChatGPT Site remains a separate D1-backed edition; it does not automatically synchronize with your local PostgreSQL database. JSON/CSV exports are available, but automatic hosted-to-local restore is not implemented.

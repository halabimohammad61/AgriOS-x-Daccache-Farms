# AgriOS Daccache Farms

AgriOS connects a proposed agricultural operating system to the five ITM303 transformation stages already developed for DACCACHE/AgriOS. The newer supplied specification calls the brand Daccache Farms. This is a product label, not evidence that Daccache Farms and DACCACHE are legally identical. All seeded farms, people, locations, harvests, customer transactions and sensor observations are fictional.

## Source reconciliation

The three attached specifications are the working source: the main product brief, the creative identity mandate and the resource-efficiency addendum. The referenced shared-chat URL could not be fetched. Earlier available blueprints, financial formulas and transformation models supply the prototype constraints and hypothetical venture case. No inaccessible transcript or unperformed interview is represented as reviewed evidence.

## Requirements and acceptance

| ID | Requirement | Priority | Implementation and verification |
|---|---|---|---|
| R01 | Persistent private farm workspace | Must | ChatGPT identity scopes every D1 query; authenticated API actions reject missing identity |
| R02 | Field and crop records | Must | Field form, planting and harvest plans, soil, budget, detail drill-down |
| R03 | Inventory traceability | Must | Integer-milli quantity ledger, receipts and guarded consumption |
| R04 | Connected input costing | Must | Atomic stock consumption plus one field expense; negative stock prevented |
| R05 | Workforce and tasks | Must | Employee register, assignment, actual hours and one-time labor allocation |
| R06 | Water records | Must | Irrigation event plus field cost; advisory only |
| R07 | Equipment maintenance | Must | Equipment register, maintenance cost and next service update |
| R08 | Harvest traceability | Must | Field-linked batches, available quantity and connected sales |
| R09 | Delivered sales and payment | Must | Guarded batch quantity, invoice, partial payments, overpayment prevention |
| R10 | Financial clarity | Must | All KPI values recomputed from the same delivered sales and expense rows |
| R11 | Distinctive responsive UI | Must | Forest/ivory identity, editorial typography, field schematic and distinct operational layouts |
| R12 | Search and exports | Must | Authorized global record search, contextual actions, CSV, JSON and print/PDF |
| R13 | Transparent weather | Should | Open-Meteo server fetch with timestamp and region; labelled demo fallback |
| R14 | Explainable assistance | Should | Deterministic evidence desk, linked records, no invented AI responses or API charges |
| R15 | Offline field entry | Should | Local task/irrigation drafts, explicit sync, tenant-keyed cache; financial posting requires connection |
| R16 | Notifications | Should | Low stock, overdue tasks, maintenance and sample moisture rules; acknowledgments and audit |
| R17 | Scenario analysis | Should | Explicit mathematical revenue/input-cost changes with baseline |
| R18 | Transformation continuity | Should | Five-stage roadmap and separate 2027–2031 venture assumptions |
| R19 | Arabic experience | Could | Arabic navigation and common actions; full localization remains incomplete |
| R20 | Advanced forecasting and digital twin | Future | Schematic interactive field map implemented; live sensors, geodetic/3D model and validated crop forecasts not claimed |

## Core journeys

Owner: review overview, inspect a field, inspect financial contribution and export underlying expenses.
Manager: create an assigned field task and complete it with actual labor hours.
Inventory operator: receive purchased inputs, consume a measured quantity in a field, inspect resulting stock and cost rows.
Harvest operator: create a harvest batch, sell an available quantity, inspect the connected invoice and record payment.
Field user: save a task or irrigation draft offline, reconnect, review and explicitly sync it.

The current private prototype has one authenticated workspace owner and an anonymous read-only demo. Personnel job titles are not authentication roles. Delegated multi-user role policies and invitations are future work, not implemented security claims.

## Design system

Deep forest #14362a, botanical green #254f3a, warm ivory #f6f6f0, sage #e9eee2 and harvest gold #d5b776. Source brief expressly requests this palette. Local AgriSans body font, Georgia editorial headings and tabular financial figures. Working text and controls use a 14px floor; small brand and secondary metadata are not used for critical operational values. Reduced-motion preferences, keyboard focus states, modal focus containment and responsive tables are included.

## Daccache correction and portable delivery

The user confirmed Daccache Agriculture. Product branding is **Daccache Farms**, and the verified company address is Bazioun, Jbeil, Lebanon (head office and factory). Weather and the geographic reference map use the published office marker; farm parcels remain unverified. The local package implements the requested Next.js + PostgreSQL/PostGIS stack, MapLibre, Apache ECharts, a shadcn/ui boundary action and Playwright API/browser test specifications. A specific Figma design-file link is pending, so no private design match is claimed.

# Daccache Farms design handoff

The user supplied a private Figma recent-files dashboard. A particular design-file/node link has not yet been supplied. This release does not claim fidelity to an unseen Figma file.

Current direction: an agricultural editorial workspace with a forest sidebar, ivory canvas, large serif headings, restrained sans-serif controls, sage and harvest-gold accents, thin boundaries and generous line spacing. Exact CSS values and type declarations are maintained in `app/globals.css`.

Suggested Figma components: sidebar item (default/current), farm field card, metric strip, ledger table, exception card, map panel, modal form, scenario controls, notification drawer. Use the existing desktop and mobile breakpoints as implementation references. Keep body text at least 16px and ordinary controls/data at least 14px; metadata is secondary. Never shrink text to force a crowded layout.

shadcn/ui source components are locally owned and styled; the boundary action uses its Button. Interactive maps use MapLibre, financial/irrigation plots use ECharts, and public browser acceptance specifications use Playwright. Design-system integration does not require copying a generic dashboard template.

External services: basemap requests go to OpenStreetMap, weather requests to Open-Meteo. No operational ledger records are sent to those services.

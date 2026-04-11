@-moz-document url-prefix("about:"),
url-prefix("chrome://browser/content/") {
  :root {
    --ts-bg: __BACKGROUND_CSS__ !important;
    --ts-bg-alt: __BACKGROUND_ALT_CSS__ !important;
    --ts-fg: __FOREGROUND_CSS__ !important;
    --ts-accent: __ACCENT_CSS__ !important;
    --ts-accent-alt: __ACCENT_ALT_CSS__ !important;
    --ts-muted: __MUTED_CSS__ !important;
    color-scheme: dark !important;
  }

  html,
  body {
    background: var(--ts-bg) !important;
    color: var(--ts-fg) !important;
  }

  .outer-wrapper,
  .activity-stream,
  .top-site-outer .tile,
  .card-outer .card,
  .ds-card-grid.ds-card-grid-border .ds-card:not(.placeholder),
  .search-wrapper .search-handoff-button,
  .search-wrapper input,
  .personalize-button,
  .sidebar,
  .main-content,
  .pane-container,
  .sticky-container,
  .category,
  .navigation {
    background: var(--ts-bg-alt) !important;
    color: var(--ts-fg) !important;
    border-color: var(--ts-accent) !important;
  }

  a,
  button,
  .click-target-container *,
  .top-site-outer .title span,
  .section-title span {
    color: var(--ts-fg) !important;
  }

  button.primary,
  button[type="submit"],
  input[type="button"],
  input[type="submit"] {
    background: var(--ts-accent) !important;
    color: var(--ts-bg-alt) !important;
    border-color: var(--ts-accent-alt) !important;
  }

  input,
  textarea,
  select {
    background: color-mix(in srgb, var(--ts-bg) 86%, black) !important;
    color: var(--ts-fg) !important;
    border-color: var(--ts-accent) !important;
  }
}

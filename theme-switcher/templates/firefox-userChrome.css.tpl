:root {
  --ts-bg: __BACKGROUND_CSS__;
  --ts-bg-alt: __BACKGROUND_ALT_CSS__;
  --ts-fg: __FOREGROUND_CSS__;
  --ts-accent: __ACCENT_CSS__;
  --ts-accent-alt: __ACCENT_ALT_CSS__;
  --ts-warning: __WARNING_CSS__;
  --ts-danger: __DANGER_CSS__;
  --ts-muted: __MUTED_CSS__;
  --toolbar-bgimage: none !important;
  --lwt-header-image: none !important;
  --toolbar-bgcolor: var(--ts-bg-alt) !important;
  --toolbar-color: var(--ts-fg) !important;
  --lwt-accent-color: var(--ts-bg-alt) !important;
  --lwt-text-color: var(--ts-fg) !important;
  --tab-selected-bgcolor: var(--ts-accent) !important;
  --tab-selected-textcolor: var(--ts-bg-alt) !important;
  --tab-hover-background-color: color-mix(in srgb, var(--ts-accent) 18%, transparent) !important;
  --chrome-content-separator-color: var(--ts-accent) !important;
  --tabs-navbar-separator-color: transparent !important;
  --toolbar-field-background-color: color-mix(in srgb, var(--ts-bg) 78%, black) !important;
  --toolbar-field-color: var(--ts-fg) !important;
  --toolbar-field-border-color: var(--ts-accent) !important;
  --toolbar-field-focus-background-color: var(--ts-bg) !important;
  --toolbar-field-focus-color: var(--ts-fg) !important;
  --toolbar-field-focus-border-color: var(--ts-accent-alt) !important;
  --toolbarbutton-icon-fill: var(--ts-fg) !important;
  --toolbarbutton-hover-background: color-mix(in srgb, var(--ts-accent) 24%, transparent) !important;
  --toolbarbutton-active-background: color-mix(in srgb, var(--ts-accent) 36%, transparent) !important;
  color-scheme: dark !important;
}

#main-window,
#main-window[lwtheme] {
  background: var(--ts-bg-alt) !important;
  color: var(--ts-fg) !important;
}

#navigator-toolbox,
#titlebar,
#TabsToolbar,
#nav-bar,
#PersonalToolbar,
#sidebar-box,
#sidebar-header,
#toolbar-menubar {
  background: var(--ts-bg-alt) !important;
  background-image: none !important;
  color: var(--ts-fg) !important;
  border-color: var(--ts-bg) !important;
}

#navigator-toolbox {
  border-bottom: 1px solid var(--ts-accent) !important;
}

#tabbrowser-tabs {
  --tab-min-height: 34px !important;
}

.tabbrowser-tab {
  padding-inline: 2px !important;
}

.tabbrowser-tab .tab-stack {
  border-radius: 10px !important;
}

.tabbrowser-tab:hover:not([selected="true"]) .tab-background {
  background: color-mix(in srgb, var(--ts-accent) 18%, var(--ts-bg)) !important;
}

.tab-background {
  margin-block: 4px !important;
  border-radius: 10px !important;
  background: color-mix(in srgb, var(--ts-bg) 88%, black) !important;
  border: 1px solid transparent !important;
  box-shadow: none !important;
}

.tabbrowser-tab[selected="true"] .tab-background {
  background: var(--ts-accent) !important;
  border-color: var(--ts-accent-alt) !important;
}

.tabbrowser-tab[selected="true"] .tab-label,
.tabbrowser-tab[selected="true"] .tab-icon-stack {
  color: var(--ts-bg-alt) !important;
  fill: var(--ts-bg-alt) !important;
}

.tabbrowser-tab[selected="true"] .tab-close-button {
  color: var(--ts-bg-alt) !important;
}

.tabbrowser-tab[selected="true"] .tab-close-button:hover {
  background: color-mix(in srgb, var(--ts-bg) 16%, transparent) !important;
}

.tabbrowser-tab:not([selected="true"]) .tab-label {
  color: var(--ts-fg) !important;
}

#urlbar-background,
#searchbar,
.searchbar-textbox {
  background: color-mix(in srgb, var(--ts-bg) 82%, black) !important;
  border: 1px solid var(--ts-accent) !important;
  border-radius: 10px !important;
}

#urlbar[open] > #urlbar-background,
#urlbar[focused] > #urlbar-background,
#searchbar:focus-within {
  border-color: var(--ts-accent-alt) !important;
}

#nav-bar {
  box-shadow: none !important;
  border-top: 0 !important;
}

#PersonalToolbar {
  border-top: 1px solid color-mix(in srgb, var(--ts-accent) 42%, transparent) !important;
}

#urlbar-results,
.urlbarView,
menupopup,
panelview,
.panel-subview-body,
#widget-overflow-mainView,
#appMenu-popup,
#downloadsPanel-mainView,
#customizationui-widget-panel,
#sidebarMenu-popup {
  background: var(--ts-bg-alt) !important;
  color: var(--ts-fg) !important;
  border-color: var(--ts-accent) !important;
}

.toolbarbutton-1:hover,
.subviewbutton:hover,
menu[_moz-menuactive="true"],
menuitem[_moz-menuactive="true"] {
  background: color-mix(in srgb, var(--ts-accent) 22%, transparent) !important;
  color: var(--ts-fg) !important;
}

#TabsToolbar .toolbarbutton-1,
#nav-bar .toolbarbutton-1,
#PersonalToolbar .toolbarbutton-1 {
  border-radius: 10px !important;
}

#statuspanel-label,
findbar {
  background: var(--ts-bg-alt) !important;
  color: var(--ts-fg) !important;
  border-color: var(--ts-accent) !important;
}

#sidebar-box {
  border-right: 1px solid var(--ts-accent) !important;
}

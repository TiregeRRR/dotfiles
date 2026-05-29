* {
    bg: __BACKGROUND_CSS__;
    bg-alt: __BACKGROUND_ALT_CSS__;
    fg: __FOREGROUND_CSS__;
    accent: __ACCENT_CSS__;
    accent-alt: __ACCENT_ALT_CSS__;
    warning: __WARNING_CSS__;
    muted: __MUTED_CSS__;
    transparent: rgba(17,19,31,0.18);
    border: 0px;
    font: "__FONT_MONO__ __FONT_ROFI_SIZE__";
    background-color: transparent;
    text-color: @fg;
}

window {
    width: 760;
    location: center;
    anchor: center;
    transparency: "screenshot";
    border: 0px;
    border-radius: 18px;
    border-color: @transparent;
    background-color: @transparent;
    children: [ mainbox ];
}

mainbox {
    spacing: 0;
    children: [ inputbar, listview ];
}

inputbar {
    padding: 14px;
    background-color: @bg;
    text-color: @fg;
    border: 2px;
    border-color: @accent;
    border-radius: 18px 18px 0px 0px;
}

prompt, entry, case-indicator {
    text-color: inherit;
}

prompt {
    margin: 0px 10px 0px 0px;
    text-color: @accent;
}

entry {
    cursor: text;
}

listview {
    padding: 10px;
    lines: 12;
    columns: 1;
    dynamic: false;
    scrollbar: true;
    background-color: @bg;
    border: 0px 2px 2px 2px;
    border-color: @accent;
    border-radius: 0px 0px 18px 18px;
}

element {
    padding: 8px 10px;
    border-radius: 10px;
    background-color: transparent;
    text-color: @fg;
}

element normal.normal,
element alternate.normal {
    background-color: transparent;
    text-color: @fg;
}

element normal.active,
element alternate.active {
    background-color: transparent;
    text-color: @accent-alt;
}

element normal.urgent,
element alternate.urgent {
    background-color: transparent;
    text-color: @warning;
}

element selected.normal {
    background-color: @accent;
    text-color: @bg-alt;
}

element selected.active {
    background-color: @accent-alt;
    text-color: @bg-alt;
}

element selected.urgent {
    background-color: @warning;
    text-color: @bg-alt;
}

element-text, element-icon {
    background-color: inherit;
    text-color: inherit;
}

scrollbar {
    handle-width: 6px;
    background-color: transparent;
    handle-color: @muted;
}

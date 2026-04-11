$font_ui = __FONT_UI__
$font_mono = __FONT_MONO__
$wallpaper = __WALLPAPER__

general {
    hide_cursor = true
    ignore_empty_input = true
    immediate_render = true
    text_trim = true
}

animations {
    enabled = true
    bezier = easeOut, 0.16, 1, 0.3, 1
    bezier = easeInOut, 0.65, 0, 0.35, 1
    animation = fadeIn, 1, 6, easeOut
    animation = fadeOut, 1, 4, easeInOut
    animation = inputFieldColors, 1, 4, easeOut
    animation = inputFieldDots, 1, 3, easeOut
}

background {
    monitor =
    path = $wallpaper
    color = __BACKGROUND_FULL_RGBA__
    blur_passes = 4
    blur_size = 8
    noise = 0.018
    contrast = 0.92
    brightness = 0.72
    vibrancy = 0.18
    vibrancy_darkness = 0.22
}

shape {
    monitor =
    size = 100%, 100%
    color = __OVERLAY_RGBA__
    rounding = 0
    position = 0, 0
    halign = center
    valign = center
    zindex = 0
}

shape {
    monitor =
    size = 480, 380
    color = __PANEL_RGBA__
    rounding = 28
    border_size = 2
    border_color = __PANEL_BORDER_START_RGBA__ __PANEL_BORDER_END_RGBA__ 45deg
    shadow_passes = 4
    shadow_size = 10
    shadow_color = __SHADOW_RGBA__
    shadow_boost = 1.35
    position = 0, 0
    halign = center
    valign = center
    zindex = 1
}

shape {
    monitor =
    size = 220, 6
    color = __ACCENT_CSS__
    rounding = 8
    position = 0, -142
    halign = center
    valign = center
    zindex = 2
}

label {
    monitor =
    text = LOCKED
    color = __ACCENT_CSS__
    font_size = 16
    font_family = $font_ui
    position = 0, -118
    halign = center
    valign = center
    zindex = 3
}

label {
    monitor =
    text = $TIME
    color = __CLOCK_RGBA__
    font_size = 92
    font_family = $font_mono
    shadow_passes = 3
    shadow_size = 6
    shadow_color = __SHADOW_RGBA__
    shadow_boost = 1.2
    position = 0, -42
    halign = center
    valign = center
    zindex = 3
}

label {
    monitor =
    text = cmd[update:60000] date +"%A, %d %B %Y"
    color = __TEXT_SOFT_RGBA__
    font_size = 22
    font_family = $font_ui
    position = 0, 22
    halign = center
    valign = center
    zindex = 3
}

label {
    monitor =
    text = __THEME_NAME__
    color = __MUTED_RGBA__
    font_size = 15
    font_family = $font_ui
    position = 0, 66
    halign = center
    valign = center
    zindex = 3
}

input-field {
    monitor =
    size = 420, 64
    outline_thickness = 2
    inner_color = __INPUT_INNER_RGBA__
    outer_color = __PANEL_BORDER_START_RGBA__ __ACCENT_ALT_CSS__ 45deg
    check_color = __WARNING_CSS__ __PANEL_BORDER_START_RGBA__ 45deg
    fail_color = __DANGER_CSS__ __PANEL_BORDER_START_RGBA__ 45deg
    capslock_color = __WARNING_CSS__
    bothlock_color = __WARNING_CSS__
    font_color = __CLOCK_RGBA__
    font_family = $font_ui
    fade_on_empty = false
    placeholder_text = password
    fail_text = $FAIL ($ATTEMPTS)
    dots_center = true
    dots_size = 0.28
    dots_spacing = 0.22
    dots_rounding = -1
    rounding = 20
    shadow_passes = 3
    shadow_size = 5
    shadow_color = __SHADOW_RGBA__
    shadow_boost = 1.2
    position = 0, 118
    halign = center
    valign = center
    zindex = 3
}

label {
    monitor =
    text = $LAYOUT[EN,RU]
    color = __TEXT_SOFT_RGBA__
    font_size = 15
    font_family = $font_mono
    onclick = hyprctl switchxkblayout all next
    position = 0, 176
    halign = center
    valign = center
    zindex = 3
}

label {
    monitor =
    text = Enter to unlock | Esc clears input
    color = __MUTED_RGBA__
    font_size = 13
    font_family = $font_ui
    position = 0, 222
    halign = center
    valign = center
    zindex = 3
}

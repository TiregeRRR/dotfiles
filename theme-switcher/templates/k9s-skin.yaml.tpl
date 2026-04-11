foreground: &foreground "__FOREGROUND_CSS__"
background: &background "__BACKGROUND_CSS__"
current_line: &current_line "__WARNING_CSS__"
selection: &selection "__ACCENT_ALT_CSS__"
comment: &comment "__MUTED_CSS__"
cyan: &cyan "__ALACRITTY_NORMAL_CYAN__"
green: &green "__ALACRITTY_NORMAL_GREEN__"
yellow: &yellow "__ALACRITTY_NORMAL_YELLOW__"
orange: &orange "__WARNING_CSS__"
magenta: &magenta "__ALACRITTY_NORMAL_MAGENTA__"
blue: &blue "__ALACRITTY_NORMAL_BLUE__"
red: &red "__ALACRITTY_NORMAL_RED__"
purple: &purple "__ACCENT_CSS__"
pink: &pink "__ALACRITTY_BRIGHT_MAGENTA__"
white: &white "__ALACRITTY_BRIGHT_WHITE__"
black: &black "__ALACRITTY_NORMAL_BLACK__"

k9s:
  body:
    fgColor: *foreground
    bgColor: default
    logoColor: *blue
  prompt:
    fgColor: *foreground
    bgColor: *background
    suggestColor: *orange
  info:
    fgColor: *magenta
    sectionColor: *foreground
  dialog:
    fgColor: *foreground
    bgColor: default
    buttonFgColor: *foreground
    buttonBgColor: *purple
    buttonFocusFgColor: *background
    buttonFocusBgColor: *foreground
    labelFgColor: *comment
    fieldFgColor: *foreground
  frame:
    border:
      fgColor: *selection
      focusColor: *foreground
    menu:
      fgColor: *foreground
      keyColor: *purple
      numKeyColor: *purple
    crumbs:
      fgColor: *black
      bgColor: *cyan
      activeColor: *yellow
    status:
      newColor: *magenta
      modifyColor: *blue
      addColor: *green
      errorColor: *red
      highlightcolor: *orange
      killColor: *comment
      completedColor: *comment
    title:
      fgColor: *foreground
      bgColor: default
      highlightColor: *blue
      counterColor: *magenta
      filterColor: *purple
  views:
    charts:
      bgColor: default
      defaultDialColors:
        - *blue
        - *red
      defaultChartColors:
        - *blue
        - *red
    table:
      fgColor: *foreground
      bgColor: default
      cursorFgColor: *white
      cursorBgColor: *background
      markColor: *yellow
      header:
        fgColor: *foreground
        bgColor: default
        sorterColor: *cyan
    xray:
      fgColor: *foreground
      bgColor: default
      cursorColor: *current_line
      graphicColor: *blue
      showIcons: false
    yaml:
      keyColor: *purple
      colonColor: *blue
      valueColor: *foreground
    logs:
      fgColor: *foreground
      bgColor: default
      indicator:
        fgColor: *foreground
        bgColor: *selection
    help:
      fgColor: *foreground
      bgColor: default
      indicator:
        fgColor: *red
        bgColor: *selection

{...}: {
  xdg.configFile."fcitx5/conf/classicui.conf".text = ''
    Theme=catppuccin-mocha-mauve
    Font="Inter 14"
  '';
  stylix.targets = {
    # Don't turn on
    waybar.enable = false;
    hyprlock.enable = false;
  };
}

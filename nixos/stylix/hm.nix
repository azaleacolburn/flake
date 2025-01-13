{...}: {
  xdg.configFile."fcitx5/conf/classicui.conf".text = ''
    Theme=catppuccin-mocha-mauve
    Font="Inter 14"
  '';
  stylix.targets = {
    waybar.enable = true;
    hyprlock.enable = false;
  };
}

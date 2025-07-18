{ config, ... }:
{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;

      download = "${config.home.homeDirectory}/downloads";
      desktop = "${config.home.homeDirectory}/media/desktop";
      documents = "${config.home.homeDirectory}/media/docs";
      pictures = "${config.home.homeDirectory}/media/pictures";
      music = null;
      videos = null;
      templates = null;
      publicShare = null;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/media/pictures/screenshots";
        XDG_ISOS_DIR = "${config.home.homeDirectory}/media/isos";
        XDG_PROJECTS = "${config.home.homeDirectory}/projects";
      };
    };
  };

  xdg.configFile."npm/npmrc".text = ''
    prefix=$\{XDG_DATA_HOME}/npm
    cache=$\{XDG_CACHE_HOME}/npm
    init-module=$\{XDG_CONFIG_HOME}/npm/config/npm-init.js
    logs-dir=$\{XDG_STATE_HOME}/npm/logs
  '';

  home.sessionVariables = {
    ZSH_COMPDUMP = "$XDG_CACHE_HOME/zsh/.zcompdump";
    CARGO_HOME = "$HOME/.cargo";

    PYTHON_HISTORY = "$XDG_STATE_HOME/python/history";
    PYTHONPYCACHEPREFIX = "$XDG_CACHE_HOME/python";
    PYTHONUSERBASE = "$XDG_DATA_HOME/python";

    XCOMPOSEFILE = "$XDG_CONFIG_HOME/X11/xcompose";
    XCOMPOSECACHE = "$XDG_CACHE_HOME/X11/xcompose";
  };
}

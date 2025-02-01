# Copyright (c) 2024-2025 awwpotato <awwpotato@voidq.com>
{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.programs.librewolf;
  daily = 24 * 60 * 60 * 1000;
  search = {
    force = true;
    default = "DuckDuckGo";
    privateDefault = "DuckDuckGo";
    engines = {
      "YouTube" = {
        urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
        iconUpdateURL = "https://www.youtube.com/favicon.ico";
        updateInterval = daily;
        definedAliases = ["!yt"];
      };
      "MyNixOS" = {
        urls = [{template = "https://mynixos.com/search?q={searchTerms}";}];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = ["!no"];
      };
    };
  };
  settings = {
    # firefox settings
    "privacy.resistFingerprinting" = false;
    "privacy.clearOnShutdown.history" = false;
    "privacy.clearOnShutdown.downloads" = false;
    "browser.startup.page" = 3; # Open previous windows and tabs
    "middlemouse.paste" = false;
    "general.autoScroll" = true;
    "identity.fxaccounts.enabled" = true;

    "browser.download.autohideButton" = true;
    "browser.uiCustomization.state" = builtins.readFile ./toolbar.json;
    "browser.aboutConfig.showWarning" = false;
    "browser.toolbars.bookmarks.visibility" = "never";
    "browser.urlbar.keepPanelOpenDuringImeComposition" = true;

    "font.name.monospace.x-western" = config.stylix.fonts.monospace.name;
    "font.name.sans-serif.x-western" = config.stylix.fonts.sansSerif.name;
    "font.name.serif.x-western" = config.stylix.fonts.serif.name;

    "browser.newtabpage.activity-stream.showSearch" = false;
    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
    "browser.newtabpage.activity-stream.feeds.snippets" = false;
    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
    "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
    "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
    "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.system.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.newtabpage.activity-stream.showWeather" = false;
    "browser.newtabpage.activity-stream.showRecentSaves" = false;
    "browser.newtabpage.activity-stream.feeds.topsites" = false;
    "browser.newtabpage.activity-stream.feeds.telemetry" = false;

    # potato tweaks
    "uc.tweak.translucency" = true;
    "uc.tweak.sidebar.short" = true;
    "uc.tweak.no-window-controls" = true;

    # for potatofox
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "browser.tabs.allow_transparent_browser" = true;
    "svg.context-properties.content.enabled" = true;
    "layout.css.has-selector.enabled" = true;
    "browser.urlbar.suggest.calculator" = true;
    "browser.urlbar.unitConversion.enabled" = true;
    "browser.urlbar.trimHttps" = true;
    "browser.urlbar.trimURLs" = true;
    "widget.gtk.rounded-bottom-corners.enabled" = true;
    "browser.compactmode.show" = true;
    "widget.gtk.ignore-bogus-leave-notify" = 1;
    "browser.uidensity" = 1;
  };
in {
  options.programs.librewolf.default = lib.mkEnableOption "Set librewolf as the default browser";

  config = lib.mkIf cfg.enable {
    home.sessionVariables.DEFAULT_BROWSER = lib.mkIf cfg.default "${pkgs.librewolf}/bin/librewolf";
    xdg.mimeApps.defaultApplications = lib.mkIf cfg.default {
      "application/pdf" = "librewolf.desktop";
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
    };
    programs.librewolf = {
      policies = {
        ExtensionSettings = {
          # sidebery
          "{3c078156-979c-498b-8990-85f7987dd929}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4246774/sidebery-5.2.0.xpi";
            installation_mode = "force_installed";
          };
          # userchrome toggle
          "userchrome-toggle-extended@n2ezr.ru" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4341014/userchrome_toggle_extended-2.0.1.xpi";
            installation_mode = "force_installed";
          };
          # ublock origin
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          # Return Youtube Dislike
          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4371820/return_youtube_dislikes-3.0.0.18.xpi";
            installation_mode = "force_installed";
          };
          # Hide Youtube Shorts
          "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4366398/hide_youtube_shorts-1.8.3.xpi";
            installation_mode = "force_installed";
          };
          # SponsorBlock
          "sponsorBlocker@ajay.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4395988/sponsorblock-5.10.1.xpi";
            installation_mode = "force_installed";
          };
        };
      };
      profiles = {
        default = {
          inherit settings search;
          isDefault = true;
          path = "default";
          id = 0;
        };
        school = {
          inherit settings search;
          path = "school";
          id = 1;
        };
      };
    };
    home.file.".librewolf/default/chrome" = {
      source = "${inputs.potatofox}/chrome";
      recursive = true;
    };
    home.file.".librewolf/school/chrome" = {
      source = "${inputs.potatofox}/chrome";
      recursive = true;
    };
  };
}

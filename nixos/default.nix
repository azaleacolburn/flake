{
  inputs,
  pkgs,
  pkgs-unstable,
  name,
  config,
  ...
}: {
  imports = [
    ./homeConf/nixos.nix
    ./stylix/nixos.nix
    ./host
    ./update.nix
    ./nix-ld.nix
  ];

  networking = {
    hostName = name;
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [22];
  };

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = ["nix-command" "flakes"];
  # systemd.enableStrictShellChecks = true;

  users.users.${config.homeConf.username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "video"
      "netdev"
      "networkmanager"
      "input"
      "uinput"
    ];
  };

  environment.systemPackages = with pkgs; [
    libnotify
    killall
    neovim
    git
    tree
    wget
    curl
    nh
    powertop
    just
    isoimagewriter
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        pkgs-unstable
        ;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    sharedModules = [../home];
  };

  programs = {
    nh = {
      enable = true;
      flake = "/etc/nixos";
      clean = {
        enable = true;
        extraArgs = "--keep 5 --keep-since 3d";
      };
    };
    ssh.startAgent = true;
    zsh.enable = true;
    git = {
      enable = true;
      lfs.enable = true;
    };
    nix-ld.enable = true;
  };

  services = {
    openssh = {
      ports = [22];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null;
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "yes";
      };
      enable = true;
    };
    fwupd.enable = true;
    power-profiles-daemon.enable = true;
  };

  system.stateVersion = "24.05";
}

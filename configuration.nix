{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "systemd.show_status=false"
    "rd.systemd.show_status=false"
    "udev.log_level=3"
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.substituters = [ 
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=5" 
    "https://mirrors.ustc.edu.cn/nix-channels/store?priority=10" 
    "https://cache.nixos.org/"
  ];

  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;
  networking.proxy.default = "http://127.0.0.1:7897";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.firewall.enable = false;

  time.timeZone = "Asia/Shanghai";

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    clash-verge-rev
    webkitgtk_4_1
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";

    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    inputMethod = {
      enable = true;
      type = "fcitx5";

      fcitx5.addons = with pkgs; [
        rime-data
        fcitx5-gtk
        fcitx5-nord
        fcitx5-rime
      ];
    };
  };

  programs.fuse.userAllowOther = true;
  programs.thunar.enable = true;
  programs.fish.enable = true;
  programs.dconf.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    gcc.cc.lib
    freetype
    libSM
    libICE
    libXrender
    libXrandr
    libXfixes
    libXcursor
    fontconfig
    libX11
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.victor-mono
    wqy_zenhei
    noto-fonts-color-emoji
    source-han-sans
    source-han-serif
    lxgw-wenkai
  ];

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Victor Mono Nerd Font Mono" ];
    # sansSerif = [ "WenQuanYi Zen Hei" ];
    # sansSerif = [ "Source Han Sans SC" ];
    sansSerif = [ "LXGW WenKai" ];
    # serif = [ "WenQuanYi Zen Hei" ];
    serif = [ "Source Han Serif SC" ];
    # serif = [ "LXGW WenKai" ];
  };
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    windowManager.awesome.enable = true;
    displayManager.startx = {
      enable = true;
      generateScript = true;
    };
  };
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  # 解决jlink的usb权限
  services.udev.extraRules = ''
    ATTR{idVendor}=="1366", MODE="0666"
  '';
  services.getty.autologinUser = null;

  virtualisation.vmware.guest.enable = true;
  systemd.services.vmware-hgfs = {
    description = "Mount VMware HGFS";
    after = [ "vmtoolsd.service" ];
    wantedBy = [ "multi-user.target" ];
  
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.open-vm-tools}/bin/vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other";
      ExecStop = "/run/current-system/sw/bin/umount /mnt/hgfs";
    };
  };
  systemd.tmpfiles.rules = [
    "d /mnt/hgfs 0755 root root -"
  ];

  users.users.microvee = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };
  security.sudo.extraRules = [
    {
      users = [ "microvee" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
  system.stateVersion = "26.05";
}

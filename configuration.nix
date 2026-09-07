# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  # 隐藏 systemd 启动过程
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  
  # 减少 kernel 输出
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "systemd.show_status=false"
    "rd.systemd.show_status=false"
    "udev.log_level=3"
  ];
  nix.settings.substituters = [ 
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=5" 
    "https://mirrors.ustc.edu.cn/nix-channels/store?priority=10" 
    "https://cache.nixos.org/"
  ];

  networking.hostName = "nixos"; 

  nix.settings.experimental-features = ["nix-command" "flakes"];

  virtualisation.vmware.guest.enable = true;
  programs.fuse.userAllowOther = true;

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
 
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Shanghai";

  networking.proxy.default = "http://127.0.0.1:7897";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    windowManager.awesome.enable = true;
    displayManager.startx = {
      enable = true;
      generateScript = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.microvee = {
     isNormalUser = true;
     shell = pkgs.fish;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };


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

  # nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.allowUnfreePredicate = pkg:
  #  builtins.elem (lib.getName pkg) [
  #    "clion"
  #  ];
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     cmake
	 ninja
	 gcc-arm-embedded
	 gdb
	 openocd
	 usbutils
	 feh
	 lf
	 nh
     open-vm-tools
     gnupg
     eza 
     vim
     wget
     git
     tmux
     unzip
     clash-verge-rev
     webkitgtk_4_1
     ungoogled-chromium
     fd
     ripgrep
     p7zip
     ibus
     xclip
	 meld
   ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
  
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    inputMethod = {
      enable = true;
      type = "ibus";

      ibus.engines = [
        pkgs.ibus-engines.rime
      ];
    };
  };

  environment.variables = {
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";

    EDITOR = "nvim";
    VISUAL = "nvim";
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

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  programs.fish.enable = true;
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

  programs.thunar.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  # 解决jlink的usb权限
  services.udev.extraRules = ''
    ATTR{idVendor}=="1366", MODE="0666"
  '';
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}


{ config, pkgs, inputs, ... }:

{
  home.username = "microvee";
  home.homeDirectory = "/home/microvee";

  home.file.".tmux".source = ./.tmux;
  home.file.".vim".source = ./.vim;
  home.file.".local/bin/advcp".source = ./advcp;
  home.file.".local/bin/advmv".source = ./advmv;
  home.file.".gitconfig".source = ./dotfile/.gitconfig;
  home.file.".xinitrc".source = ./dotfile/.xinitrc;
  home.file.".tmux.conf".source = ./dotfile/.tmux.conf;
  home.file.".emacs.d".source = ./dotfile/.emacs.d;
  home.file.".astylerc".source = ./dotfile/.astylerc;
  home.file.".gdbinit".source = ./dotfile/.gdbinit;
  home.file.".local/share/fcitx5/themes".source = ./fcitx5/themes;

  xdg.configFile."awesome".source = ./.config/awesome;
  xdg.configFile."nvim".source = ./.config/nvim;
  xdg.configFile."fish".source = ./.config/fish;
  xdg.configFile."wezterm".source = ./.config/wezterm;
  xdg.configFile."picom".source = ./.config/picom;
  xdg.configFile."rofi".source = ./.config/rofi;
  xdg.configFile."dunst".source = ./.config/dunst;
  xdg.configFile."lf".source = ./.config/lf;

  home.packages = with pkgs;[
    mermaid-cli
    plantuml
    graphviz
	pandoc
    prettier
    stylua
    diffnav
    ctags
    astyle
    ncdu
    kdePackages.okular
    libreoffice
    meld
    clang
    clang-tools
    emacs
    btop  
    neovim
    picom
    rofi
    dunst
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
    python3
    ungoogled-chromium
    usbutils
    fastfetch
    nh
    open-vm-tools
    eza 
    lf
    wezterm
    tmux
    unzip
    fd
    ripgrep
    xclip
    tree
    pkgs.bibata-cursors
  ];
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Amber";
    size = 11;
    x11.enable = true;
    gtk.enable = true;
  };
  gtk = {
    enable = true;
    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };
    iconTheme = {
      name = "oomox-gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "microvee";
        email = "815514981@qq.com";
      };
      init.defaultBranch = "main";
    };
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  home.stateVersion = "26.05";
}

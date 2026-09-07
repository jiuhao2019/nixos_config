{ config, pkgs, inputs, ... }:

{
  # 注意修改这里的用户名与用户目录
  home.username = "microvee";
  home.homeDirectory = "/home/microvee";

  # 将当前配置目录中的文件导入 Nix store，并在 Home 目录下生成指向该 store 文件的符号链接
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # 将 scripts 目录导入 Nix store，并在 Home 目录下递归生成指向 store 中的文件的符号链接
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # 递归整个文件夹
  #   executable = true;  # 将其中所有文件添加「执行」权限
  # };

  # 直接以 text 的方式，在 nix 配置文件中硬编码文件内容
  # home.file.".xxx".text = ''
  #     xxx
  # '';
  home.file.".gitconfig".source = ./dotfile/.gitconfig;
  home.file.".tmux".source = ./.tmux;
  home.file.".vim".source = ./.vim;
  home.file.".xinitrc".source = ./dotfile/.xinitrc;
  home.file.".tmux.conf".source = ./dotfile/.tmux.conf;
  home.file.".emacs.d".source = ./dotfile/.emacs.d;
  home.file.".astylerc".source = ./dotfile/.astylerc;
  home.file = {
    "wallpapers" = {
      source = inputs.gruvbox-wallpapers.packages.${pkgs.stdenv.hostPlatform.system}.default;
      recursive = true;
    };
  };
  home.file.".local/bin/advcp".source = ./advcp;
  home.file.".local/bin/advmv".source = ./advmv;

  xdg.configFile."awesome".source = ./.config/awesome;
  xdg.configFile."nvim".source = ./.config/nvim;
  xdg.configFile."fish".source = ./.config/fish;
  xdg.configFile."wezterm".source = ./.config/wezterm;
  xdg.configFile."picom".source = ./.config/picom;
  xdg.configFile."rofi".source = ./.config/rofi;
  xdg.configFile."dunst".source = ./.config/dunst;
  xdg.configFile."ranger".source = ./.config/ranger;
  xdg.configFile."lf".source = ./.config/lf;
  xdg.configFile."starship.toml".source = ./.config/starship.toml;
  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    style=Fusion
    color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors.conf
    [Fonts]
    fixed="VictorMono Nerd Font,10,-1,5,50,0,0,0,0,0"
    general="WenQuanYi Zen Hei,10,-1,5,50,0,0,0,0,0"
  '';
  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装
  home.packages = with pkgs;[
	mermaid-cli
    plantuml
    graphviz
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
    fortune
    emacs
    nix-output-monitor
    btop  
    fastfetch
    neovim
    wezterm
    picom
    rofi
    dunst
    ranger
    starship
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
	qt6Packages.qt6ct
	python3
  ];
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
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_SCALE_FACTOR = "2.55";
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
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";
}

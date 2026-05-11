{ config, pkgs, ... }:

{
  # ------------------------
  # GTK (Breeze Dark)
  # ------------------------
  gtk = {
    enable = true;

    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    iconTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-icons;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.theme = config.gtk.theme;
  };
 

  # ------------------------
  # Qt (Breeze)
  # ------------------------
  qt = {
    enable = true;

    # platformTheme.name = "gtk3";

    style = {
      name = "breeze";
      package = pkgs.kdePackages.breeze;
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Breeze-Dark";

    # Qt consistency
    # QT_QPA_PLATFORMTHEME = "gtk3";
    QT_STYLE_OVERRIDE = "breeze";

    # helps mixed toolkits detect dark mode
    XDG_CURRENT_DESKTOP = "niri";
  };

  # ------------------------
  # dconf (dark mode flag for GTK/GNOME apps)
  # ------------------------
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Breeze-Dark";
      icon-theme = "breeze-dark";
    };
  };

  # ------------------------
  # XDG portals (critical on Wayland)
  # ------------------------
  xdg.portal = {
    enable = true;

    config.common.default = [ "gtk" ];

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.myDesktop.niri;
in
{
  options.myDesktop.niri = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable niri window manager and related packages";
    };
  };
  imports = [
    ./services
  ];

  config = mkIf cfg.enable {
  # =====================================================================
  # START OF CONFIG
  # =====================================================================
    programs.niri.enable = true;


    services.gnome.gcr-ssh-agent.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.polkit.enable = true;
    programs.seahorse.enable = true;


    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      configPackages = [pkgs.xdg-desktop-portal-gtk];
      config.common.default = "gtk";
    };

    environment.systemPackages = with pkgs; [
      foot
      fuzzel
      waybar
      xwayland-satellite
      awww
      swaynotificationcenter
      hyprlock
      hypridle
      polkit_gnome

      wayland-logout
      wlogout

      eza
      bemoji
      wtype
      cliphist
    ];

    programs.thunar.enable = true;
    programs.thunar.plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
      thunar-vcs-plugin
      thunar-shares-plugin
      thunar-media-tags-plugin
      thunar-unwrapped
    ];

    # NVIDIA HIGH VRAM USAGE FIX
    # Check: https://github.com/niri-wm/niri/wiki/Nvidia
    environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".text = ''
    {

        "rules": [
            {
                "pattern": {
                    "feature": "procname",
                    "matches": "niri"
                },
                "profile": "Limit Free Buffer Pool On Wayland Compositors"
            }
        ],
        "profiles": [
            {
                "name": "Limit Free Buffer Pool On Wayland Compositors",
                "settings": [
                    {
                        "key": "GLVidHeapReuseRatio",
                        "value": 0
                    }
                ]
            }
        ]
    }
    '';
  };
}

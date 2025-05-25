{
  config,
  pkgs,
  inputs,
  ...
}: {
  #services.displayManager.cosmic-greeter.enable = true;
  #services.desktopManager.cosmic.enable = true;
  #services.desktopManager.cosmic.xwayland.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
  ];

  services.xserver = {
    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
  };

  xdg = {
    # Default browser
    mime.defaultApplications = {
      "text/html" = "firefox.desktop";
      "application/pdf" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "inode/directory" = "yazi.desktop";
    };
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
}

{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  #services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the KDE Plasma Desktop Environment.
  # services.displayManager.sddm.enable = true;

  services.desktopManager.plasma6.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  programs.xwayland.enable = true;
  services.displayManager.defaultSession = "plasmax11";
  #services.displayManager.cosmic-greeter.enable = true;
  #services.desktopManager.cosmic.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  # services.xserver.desktopManager.cinnamon.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}

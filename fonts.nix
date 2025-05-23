{pkgs, ...}: {
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    fira-code-symbols
    nerd-fonts.symbols-only
    meslo-lg
    nerd-fonts.droid-sans-mono
    weather-icons
    font-awesome
    freefont_ttf
    corefonts # Times New Roman
  ];

  environment.systemPackages = with pkgs; [
    papirus-icon-theme
  ];
}

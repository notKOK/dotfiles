# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./desktop.nix
    ./fonts.nix
    ./tmux.nix
    ./rusty.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix = {
    optimise.automatic = true;
    # SLOW OPERATION. DISABLE TO SPEED UP BUILDS
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    extraOptions = ''
      min-free = ${toString (10000 * 1024 * 1024)}
      max-free = ${toString (10024 * 1024 * 1024)}
    '';
  };

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdb";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "DanilaNix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };

  # Enable CUPS to print document

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.danila = {
    isNormalUser = true;
    description = "danila";
    extraGroups = ["networkmanager" "wheel" "danila" "video" "tty"];

    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };
  users.groups.danila = {};

  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {pipewireSupport = true;}) {};
  };
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
  };
  nixpkgs.config.allowUnfree = true;

  programs.neovim.defaultEditor = true;
  programs.neovim.enable = true;
  programs.steam.enable = true;
  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    telegram-desktop
    neovim
    enpass
    rustdesk
    tmux
    syncthing
    alejandra
    git
    lazygit
    libnotify
    btop
    htop
    jetbrains.webstorm
    jetbrains.rust-rover
    jetbrains.pycharm-professional
    jetbrains.goland
    jetbrains.datagrip
    rocmPackages.rocm-smi
    nvtopPackages.amd
    chromium
    opera
    mesa
    vulkan-tools
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;
  system.stateVersion = "25.05"; # Did you read the comment?
}

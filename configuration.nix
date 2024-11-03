# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
    memtest86.enable = true;
    netbootxyz.enable = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
  boot.plymouth.theme = "breeze";

  networking.hostName = "venus"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable Wayland and KDE session
  services.desktopManager.plasma6.enable = true;
  services.displayManager = {
    defaultSession = "plasma";
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.root = {
    openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClvL8fcyrXFkctt10XikCpkkkfnKDFWr9ePtFNa6JqZCpf8WgbB59AimHUCJ66qTJNLFhjylw6YbeZIKaVnfu3/NVD5ogp7XB7//d6xkgV3XQlHuBNqMzXi1zjHnw2yTp2IIVnWvbRqRG5CokYCUY7jUNIavPxQi+OPuOCczwnCUc5MQOQyDExSkTwDplJHz+Efu5XdiwPi1/5YdD5Gts4LRFTSbv/Up4HcJCS5shaoKpTHMy5qlPPgAIRAhqizlstxxS/LRyYDm1Of71pij4duxjTwGvWlAI4EArZHX+S1wdQeXVRaZjs3QHLyXfolMGH5Q4qQrm1igNLAy2OcgeV ryan@earth"
    ];
  };
  users.users.ryan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      nodejs_22
      opam
      quickemu
      tokei
      rustup
      devenv
      eza
      k3d
      yadm
      git-crypt
      fzf
      zig
      inputs.roclang.packages.x86_64-linux.default
    ];
    openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClvL8fcyrXFkctt10XikCpkkkfnKDFWr9ePtFNa6JqZCpf8WgbB59AimHUCJ66qTJNLFhjylw6YbeZIKaVnfu3/NVD5ogp7XB7//d6xkgV3XQlHuBNqMzXi1zjHnw2yTp2IIVnWvbRqRG5CokYCUY7jUNIavPxQi+OPuOCczwnCUc5MQOQyDExSkTwDplJHz+Efu5XdiwPi1/5YdD5Gts4LRFTSbv/Up4HcJCS5shaoKpTHMy5qlPPgAIRAhqizlstxxS/LRyYDm1Of71pij4duxjTwGvWlAI4EArZHX+S1wdQeXVRaZjs3QHLyXfolMGH5Q4qQrm1igNLAy2OcgeV ryan@earth"
    ];
    linger = true;
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    coreutils
    gnumake
    gnused
    neovim
    wget
    curl
    btop
    tmux
    git
    python313
    bat
    fd
    bash
    gawk
    just
    ripgrep
    firefox
    gcc
    rsync
    rename
    wl-clipboard
    plasma-thunderbolt
    kdePackages.bluedevil
    pinentry-tty
    pinentry-curses
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.zsh.enable = true;

  # List services that you want to enable:
  services.openssh.enable = true;
  services.flatpak.enable = true;
  services.fwupd.enable = true;
  #services.fprintd.enable = true;

  virtualisation.docker.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 3000 8000 8080 8081 8443 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  #system.copySystemConfiguration = true;

}

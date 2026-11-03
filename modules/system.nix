{ pkgs, config, lib, ... }:
{
  system.stateVersion = "26.05";
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    # auto-optimise-store = true;
  };

   # nixpkgs.config.allowUnfree = true;
     
  # boot
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # host
  networking.hostName = "saman";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Tehran";

  # user / privilege
  users.users."devssh" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };

  # ssh
  services.sshd.enable = true;
  
  programs.zsh.enable = true;
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      groups = [ "wheel" ];
      persist = true;
      keepEnv = true;
    }];
  };

  # graphics
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "modesetting" ];

  # hardware.nvidia = {
  #   open = false;
  #   package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  #   modesetting.enable = true;
  #   powerManagement.enable = true;
  #   prime = {
  #     offload = {
  #       enable = true;
  #       enableOffloadCmd = true;
  #     };
  #     intelBusId = "PCI:0:2:0";
  #     nvidiaBusId = "PCI:1:0:0";
  #   };
  # };
  
  
  # session
  programs.sway.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # fonts
  fonts = {
    packages = with pkgs; [
      maple-mono.NF
      ibm-plex
      liberation_ttf
      noto-fonts
      noto-fonts-color-emoji
      roboto
      dejavu_fonts
    ];
    fontconfig.defaultFonts = {
      monospace = [ "Maple Mono NF" ];
      sansSerif = [ "IBM Plex Sans" "IBM Plex Sans Arabic" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };


  programs.git.enable = true;
  programs.git.config = {
    user.name = "devsshq";
    user.email = "devssh@tuta.io";
    init.defaultBranch = "main";
    url."https://github.com/".insteadOf = [ "gh:" "github:" ];
  };

  
  environment.systemPackages = with pkgs; [
    # git
    helix
    mpv
    nnn
    aria2
    wl-clipboard
    btop
  ];
}

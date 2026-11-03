{
  flake.modules.nixos.graphics = {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "modesetting" ];

    # hardware.nvidia = {
    #   open = false;
    #   package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    #   modesetting.enable = true;
    #   powerManagement.enable = true;
    #   prime = {
    #     offload = { enable = true; enableOffloadCmd = true; };
    #     intelBusId = "PCI:0:2:0";
    #     nvidiaBusId = "PCI:1:0:0";
    #   };
    # };
  };
}

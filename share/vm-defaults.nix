{ modulesPath, config, lib, pkgs, ... }:

{
  imports = [ (modulesPath + "/virtualisation/qemu-vm.nix") ];

  networking.hostName = "knix-vm";

  boot.initrd.includeDefaultModules = false;
  boot.kernelPackages = pkgs.linuxKernel.packagesFor (
    pkgs.linuxKernel.kernels.linux_testing.override {
      autoModules = false;
      enableCommonConfig = false;
      argsOverride = {
        structuredExtraConfig = with lib.kernel; {
          HYPERVISOR_GUEST = yes;
          PARAVIRT = yes;
          KVM_GUEST = yes;
          VIRTIO_MMIO = module;
          VIRTIO_BLK = module;
          VIRTIO_PCI = module;
          VIRTIO_NET = module;
          VIRTIO_BALLOON = module;
          HW_RANDOM_VIRTIO = module;
          EXT4_FS    = module;
          NET_9P_VIRTIO = module;
          "9P_FS" = module;
          BLK_DEV = yes;
          PCI = yes;
          NETDEVICES = yes;
          NET_CORE = yes;
          INET = yes;
          NETWORK_FILESYSTEMS = yes;
          SERIAL_8250_CONSOLE = yes;
          SERIAL_8250 = yes;
          OVERLAY_FS = yes;
        };
      };
    }
  );
}

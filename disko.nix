# https://github.com/nix-community/disko/blob/master/example/luks-lvm.nix
{ lib, ... }:
{
    disko.devices = {
        disk.disk1 = {
            device = lib.mkDefault "/dev/sda";
            type = "disk";
            content = {
                type = "gpt";
                partitions = {
                    boot = {
                        name = "boot";
                        size = "1M";
                        type = "EF02";
                    };
                    esp = {
                        size = "500M";
                        type = "EF00";
                        content = {
                            type = "filesystem";
                            format = "vfat";
                            mountpoint = "/boot";
                            mountOptions = [
                            "defaults"
                            ];
                        };
                    };
                    luks = {
                        size = "100%";
                        content = {
                            type = "luks";
                            name = "luks";
                            settings.allowDiscards = true;
                            passwordFile = "/tmp/luks.key";
                            # extraOpenArgs = [ ];
                            # settings = {
                                # if you want to use the key for interactive login be sure there is no trailing newline
                                # for example use `echo -n "password" > /tmp/secret.key`
                                # keyFile = "/home/nixos/nixos/key.key";
                                # allowDiscards = true;
                            # };
                            # additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
                            content = {
                                type = "lvm_pv";
                                vg = "pool";
                            };
                        };
                    };
                };
            };
        };
        lvm_vg = {
            pool = {
                type = "lvm_vg";
                lvs = {
                    root = {
                        size = "100%FREE"; # 100M
                        content = {
                            type = "filesystem";
                            format = "ext4";
                            mountpoint = "/";
                            mountOptions = [
                                "defaults"
                            ];
                        };
                    };
                # home = {
                    # size = "10M";
                    # content = {
                        # type = "filesystem";
                        # format = "ext4";
                        # mountpoint = "/home";
                    # };
                # };
                # raw = {
                    # size = "10M";
                # };
                };
            };
        };
    };
}

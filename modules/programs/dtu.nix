{
  delib,
  pkgs,
  homeconfig,
  ...
}: let
  installDir = "${homeconfig.home.homeDirectory}/files/Xilinx";
in
  delib.module {
    name = "programs.dtu";

    options = delib.singleEnableOption false;

    myconfig.ifEnabled = {
      overlays.nix-xilinx.enable = true;

      programs.development = {
        java.enable = true;
        python.enable = true;
      };
    };

    home.ifEnabled = {
      home.packages = with pkgs; [
        ltspice # Circuit simulation software
        logisim-evolution # Digital electronics simulator
        vivado # FPGA
      ];

      programs = {
        git.includes = [
          {
            condition = "hasconfig:remote.*.url:git@gitlab.gbar.dtu.dk:*/**";
            contents = {
              user = {
                name = "s265172";
                email = "s265172@student.dtu.dk";
                signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcgjELhorYRWrbhR35yd69scBEACj1jT2Mw2FYBQN3O";
              };
            };
          }
        ];
      };
      home.file.".Xilinx/install_config.txt".text = ''
        Edition=Vivado Design Suite
        Product=Vivado
        Destination=${installDir}
        InstallOptions=Acquire or Manage a License Key:0

        Modules=xc2ve3804:0,xcvp2502:0,Virtex-7 FPGAs:0,xcvr1652:0,Zynq UltraScale+ RFSoCs:0,xcvm1502:0,xcvp1902:0,xcvc2602:0,xc2ve3858:0,xqvc1902:0,xcvm2902:0,xcvr1652_es1:0,xqvc1702:0,xcvp2802:0,Virtex UltraScale+ FPGAs:0,Kintex UltraScale FPGAs:0,xcvc1902:0,xcvm2502:0,Kintex-7 FPGAs:0,Artix-7 FPGAs:1,xcvh1582:0,xcvm1802:0,Install Devices for Kria SOMs and Starter Kits:0,xqve2302:0,xqrvc1902:0,Spartan UltraScale+:0,xcvm2302:0,Virtex UltraScale FPGAs:0,xave1752:0,Install devices for Alveo and edge acceleration platforms:0,xave2002:0,Zynq-7000 All Programmable SoC:0,xcve2802:0,xqve2102:0,xqvp1702:0,xcvp1402:0,xcvh1782:0,xcvh1542:0,Power Design Manager (PDM):0,xqvm1402:0,xqvm1802:0,xqvp1202:0,xcvp1502:0,xcvh1522:0,xqvp1402:0,xqvm1502:0,Spartan-7 FPGAs:0,xqrve2302:0,xcvm2202:0,xqvm1102:0,xcve2302:0,xcvp1052:0,xave2202:0,Kintex UltraScale+ FPGAs:0,xc2ve3358:0,xcvm1302:0,xcvp1702:0,Vitis Embedded Development:0,xqvp1052:0,xqvp1502:0,xcvp1552:0,xcve2602:0,xcvm2152:0,Vitis Networking P4:0,xave2102:0,xcve2202:0,xcvp1102:0,xcvh1742:0,xc2vm3558:0,xcvr1602:0,Virtex UltraScale+ 58G FPGAs:0,xcvp1202:0,xcvm1102:0,xqvp2502:0,Virtex UltraScale+ HBM FPGAs:0,xc2ve3504:0,Vitis Model Composer(A toolbox for Simulink):0,xcve2102:0,xc2ve3558:0,xave2602:0,xcvm1402:0,Artix UltraScale+ FPGAs:0,Zynq UltraScale+ MPSoCs:0,xcvp1002:0,xcvc1802:0,xcvr1602_es1:0,xc2vm3858:0,xave2302:0,xcv80:0,xcvc1502:0,xcvc1702:0,DocNav:0,xcvp1802:0,xcvc2802:0,xcve2002:0,xave2802:0,xcve1752:0

        CreateProgramGroupShortcuts=0
        ProgramGroupFolder=AMD Adaptive SoC and FPGA Tools
        CreateShortcutsForAllUsers=0
        CreateDesktopShortcuts=0
        CreateFileAssociation=1
      '';

      home.file.".config/xilinx/nix.sh".text = ''
        INSTALL_DIR="${installDir}"
        VERSION=2026.1
        XILINXD_LICENSE_FILE="$HOME/.local/share/licenses/Xilinx.lic"
      '';
    };

    nixos.ifEnabled = {
      environment.systemPackages = with pkgs; [
        openconnect
      ];

      networking.networkmanager.plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };
  }

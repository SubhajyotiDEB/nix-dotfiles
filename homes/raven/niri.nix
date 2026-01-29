{ pkgs, ... }:

let
  qt6ct = pkgs.qt6Packages.qt6ct.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      ./_patches/qt6ct.patch
    ];
  });
in
{
  programs.niri.config = null;
  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;

  programs.dank-material-shell = {
    enable = true;
    niri = {
      includes.enable = false;
      enableSpawn = true;
    };
    enableSystemMonitoring = true;
    enableVPN = true;
    enableAudioWavelength = true;
    enableDynamicTheming = true;
    enableCalendarEvents = true;

    plugins = {
      displayMirror = {
        enable = true;
        src = fetchGit {
          url = "https://github.com/debarchito/displayMirror";
          ref = "main";
          rev = "92cd44c4fb67834bf71fdd78f83c29df5e0750b2";
        };
      };
      dockerManager = {
        enable = true;
        src = fetchGit {
          url = "https://github.com/debarchito/dockerManager";
          ref = "main";
          rev = "860457bbb043a6651a2cbafe6e77d443123a0b07";
        };
      };
      dankKDEConnect = {
        enable = true;
        src = "${
          fetchGit {
            url = "https://github.com/debarchito/dms-plugins";
            ref = "master";
            rev = "bd1033ed94647bf6753b1337148480598e3a7a25";
          }
        }/DankKDEConnect";
      };
      easyEffects = {
        enable = true;
        src = fetchGit {
          url = "https://github.com/debarchito/easyEffects";
          ref = "main";
          rev = "ac2726063d308ef28c1704956564f013951e3a0a";
        };
      };
    };
  };

  home.packages = [
    pkgs.nautilus
    pkgs.xwayland-satellite
    qt6ct
  ];
}

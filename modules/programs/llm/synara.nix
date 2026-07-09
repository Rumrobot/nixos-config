{
  delib,
  host,
  pkgs,
  ...
}: let
  pname = "synara";
  version = "0.4.1";
  src = pkgs.fetchurl {
    url = "https://github.com/Emanuele-web04/synara/releases/download/v${version}/Synara-${version}-x86_64.AppImage";
    hash = "sha256-k/swzPlAhCZmJCYnyJeDybwnzmJZZNsXt8tl7lqZFXk=";
  };
  contents = pkgs.appimageTools.extract {inherit pname version src;};
  synara = pkgs.appimageTools.wrapType2 {
    inherit pname version src;
    extraInstallCommands = ''
      install -Dm444 ${contents}/synara.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/synara.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=synara'
      install -Dm444 ${contents}/synara.png \
        $out/share/icons/hicolor/512x512/apps/synara.png
      install -Dm444 ${contents}/synara.png $out/share/pixmaps/synara.png
    '';
  };
in
  delib.module {
    name = "programs.llm.synara";

    options = delib.singleEnableOption (host.llmFeatured && host.developmentFeatured && host.guiFeatured);

    home.ifEnabled.home.packages = [synara];
  }

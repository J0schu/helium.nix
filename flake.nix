{
  description = "Helium Browser Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      version = "0.14.8.2";
      hash = "sha256-7Kde6Crsr6LdKnfER+6yE7JkU6+10xXtJ1GQEHhBtqg=";
      pname = "helium";

      contents = pkgs.appimageTools.extract {
        inherit pname version;
        src = pkgs.fetchurl {
          url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
          inherit hash;
        };
      };

    in {
      packages.${system}.default = pkgs.appimageTools.wrapType2 {
        inherit pname version;
        
        src = pkgs.fetchurl {
          url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
          inherit hash;
        };

        extraInstallCommands = ''
          install -m 444 -D ${contents}/${pname}.desktop $out/share/applications/${pname}.desktop
          
          substituteInPlace $out/share/applications/${pname}.desktop

          cp -r ${contents}/usr/share/icons $out/share/
        '';
      };
    };
}

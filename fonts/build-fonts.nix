{ pkgs }:

let
    # Using nerd-fonts with the hyphen
    iosevka-term = pkgs.nerd-fonts.iosevka-term;

    cormorant-garamond = pkgs.stdenv.mkDerivation {
        pname   = "cormorant-garamond";
        version = "3.601";

        src = pkgs.fetchFromGitHub {
            owner  = "CatharsisFonts";
            repo   = "Cormorant";
            rev    = "v3.601";
            sha256 = "sha256-gw+Wm7NT6tI1zq2Bmw6T2bH5HLz8ZZaoxMdTO5pPvi4=";
        };

        installPhase = ''
            mkdir -p $out/share/fonts/opentype
            find . -name "*.otf" -exec cp {} $out/share/fonts/opentype/ \;
        '';
    };
in
{
    inherit iosevka-term cormorant-garamond;

    all-lab-fonts = pkgs.symlinkJoin {
        name  = "lab-fonts";
        paths = [ iosevka-term cormorant-garamond ];
    };
}

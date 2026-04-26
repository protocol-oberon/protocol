{
    description = "The Laboratory Protocol: WIT contracts, custom fonts, and typst maxims.";

    inputs = {
        # Pinning to the 25.11 stable release for 2026 reproducibility
        nixpkgs-stable.url   = "github:NixOS/nixpkgs/nixos-25.11";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url      = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs-stable, nixpkgs-unstable, flake-utils }:
        let
            # Global attributes (non-system specific)
            # This allows other flakes to access your .typ files directly via inputs.protocol.lib.typst
            lab-templates = ./typst;

        in
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs-stable   = import nixpkgs-stable   { inherit system; };
                pkgs-unstable = import nixpkgs-unstable { inherit system; };

                # Load the font build logic
                lab-fonts = import ./fonts/build-fonts.nix { pkgs = pkgs-stable; };
            in
            {
                # 1. Export as packages (for 'nix build .#iosevka-oberon')
                packages = {
                    inherit (lab-fonts) iosevka-oberon cormorant-garamond all-lab-fonts;
                    default = lab-fonts.all-lab-fonts;
                };

                # 2. Export fonts in lib so other repos can access the paths
                lib = {
                    lab-templates = lab-templates;
                    lab-fonts     = lab-fonts;
                };

                devShells.default = pkgs-stable.mkShell {
                    name = "protocol-dev-shell";
                    packages = [
                        pkgs-stable.typst
                        # Including fonts in the shell so they're available for local typst use
                        lab-fonts.all-lab-fonts
                    ];

                    shellHook = ''
                        echo "--- Laboratory Protocol Environment ---"
                        echo "Typst : $(typst --version)"
                        echo "Accent Color: #7030A0 | Fonts: Iosevka Term, Cormorant Garamond"
                        # Exporting path for local typst usage
                        export TYPST_FONT_PATHS="${lab-fonts.all-lab-fonts}/share/fonts"
                    '';
                };
            }
        ) // {
            # Global lib export
            # This allows access via inputs.protocol.lab-templates without system prefix
            lab-templates = lab-templates;
        };
}

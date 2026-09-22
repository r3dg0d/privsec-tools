{
  description = "privsec-tools — Nix package set / directory for the PRIV/SEC CLI toolkit";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    macrandom.url = "github:r3dg0d/macrandom";
    mullvadctl.url = "github:r3dg0d/mullvadctl";
    dnscheck.url = "github:r3dg0d/dnscheck";
    netidentity.url = "github:r3dg0d/netidentity";
    fileshred.url = "github:r3dg0d/fileshred";
    metaclean.url = "github:r3dg0d/metaclean";
    browserprivacy.url = "github:r3dg0d/browserprivacy";
    opsec-check.url = "github:r3dg0d/opsec-check";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          fromInput = name: inputs.${name}.packages.${system}.default or null;
        in {
          # Rust tools that expose flake packages
          macrandom = fromInput "macrandom";
          mullvadctl = fromInput "mullvadctl";
          dnscheck = fromInput "dnscheck";
          netidentity = fromInput "netidentity";
          fileshred = fromInput "fileshred";
          metaclean = fromInput "metaclean";
          browserprivacy = fromInput "browserprivacy";
          opsec-check = fromInput "opsec-check";
          # Python AI tools: install from their own flakes / pip; listed for discoverability
          default = pkgs.writeTextDir "share/doc/privsec-tools/README.md" (builtins.readFile ./README.md);
        });

      # Convenience: documentation-only default for `nix flake show`
      checks = forAllSystems (system: {
        readme = self.packages.${system}.default;
      });
    };
}

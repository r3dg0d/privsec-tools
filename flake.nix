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
      toolNames = [
        "macrandom" "mullvadctl" "dnscheck" "netidentity"
        "fileshred" "metaclean" "browserprivacy" "opsec-check"
      ];
      toolPackages = system: nixpkgs.lib.genAttrs toolNames
        (name: inputs.${name}.packages.${system}.default);
    in {
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in toolPackages system // {
          # The default remains documentation; tools are selected explicitly.
          default = pkgs.writeTextDir "share/doc/privsec-tools/README.md" (builtins.readFile ./README.md);
        });

      apps = forAllSystems (system: nixpkgs.lib.genAttrs toolNames (name: {
        type = "app";
        program = "${self.packages.${system}.${name}}/bin/${name}";
      }));

      checks = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          tools = toolPackages system;
        in tools // {
          readme = self.packages.${system}.default;
          cli-smoke = pkgs.runCommand "privsec-tools-cli-smoke" { } ''
            ${nixpkgs.lib.concatMapStringsSep "\n" (name: "${tools.${name}}/bin/${name} --help > /dev/null") toolNames}
            touch "$out"
          '';
        });
    };
}

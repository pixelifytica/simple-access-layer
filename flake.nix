{
  description = "Simple Access Layer (SAL) is a data access middleware and storage system, focused on storing scientific data for large experiments.";
  outputs =
    { self, nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs = forAllSystems (system: (nixpkgs.legacyPackages.${system}.extend self.overlays.default));
    in
    {
      overlays.default = final: prev: {
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          (pfinal: pprev: {
            simple-access-layer = pfinal.callPackage ./derivation.nix { };
            sal = pfinal.simple-access-layer;
          })
        ];
      };
      devShells = forAllSystems (system: {
        default = pkgs.${system}.mkShellNoCC {
          packages = [ (pkgs.${system}.python3.withPackages (ps: [ ps.simple-access-layer ])) ];
        };
      });
    };
}

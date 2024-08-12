{
  description = "Simple Access Layer (SAL) is a data access middleware and storage system, focused on storing scientific data for large experiments.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (system: {
        sal = import ./default.nix { inherit (pkgs.${system}) python3; };
        default = self.packages.${system}.sal;
      });
    };
}

{
  python3 ? ((import <nixpkgs> { }).python3),
}:
python3.pkgs.callPackage ./derivation.nix { }

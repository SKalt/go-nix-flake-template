{ pkgs ? (
    let
      inherit (builtins) fetchTree fromJSON readFile;
      inherit ((fromJSON (readFile ./flake.lock)).nodes) nixpkgs gomod2nix;
    in
    import (fetchTree nixpkgs.locked) {
      overlays = [
        (import "${fetchTree gomod2nix.locked}/overlay.nix")
      ];
    }
  )
, buildGoApplication ? pkgs.buildGoApplication
}:

pkgs.buildGoApplication {
  pname = "TODO";
  version = "0.0.0"; # TODO: update mechanism
  pwd = ./.;
  src = ./.;
  modules = ./gomod2nix.toml;
}

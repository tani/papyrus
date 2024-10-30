{
  description = "A flake for fibonacci";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    systems,
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;
      perSystem = {pkgs, ...}: let
        pname = "papyrus";
        version = "1.1.0";
        lispLib = pkgs.sbcl.buildASDFSystem {
          inherit pname version;
          src = ./.;
          systems = [pname "${pname}/test"];
          lispLibs = with pkgs.sbcl.pkgs; [
            named-readtables
            parachute
          ];
        };
        lispApp = pkgs.sbcl.withPackages (ps: [lispLib]);
        test = pkgs.writeShellScriptBin "${pname}-test" ''
          ${lispApp}/bin/sbcl --noinform --non-interactive --eval "(require :asdf)" --eval "(asdf:test-system :${pname})"
        '';
      in {
        packages.default = lispLib;
        devShells.default = pkgs.mkShell {
          packages = [lispApp];
        };
        apps.test = {
          type = "app";
          program = test;
        };
      };
    };
}

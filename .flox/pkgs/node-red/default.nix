{ pkgs ? import <nixpkgs> { } }:
let
  lib = pkgs.lib;
  nodejs = pkgs.nodejs_20;
  root = ../../..;
  src = lib.cleanSource root;
  npmLock = root + "/package-lock.json";
in
pkgs.buildNpmPackage {
  inherit nodejs src npmLock;
  pname = "node-red";
  version = "4.1.2";

  npmDepsHash = "sha256-/aBgx87o5ZNHqjHd905fQ9ljy7+qSwn5Kxn8BPN5n2k=";
  npmInstallFlags = [ "--include=dev" ];
  npmBuild = true;
  makeCacheWritable = true;

  nativeBuildInputs = [ pkgs.python3 pkgs.pkg-config ];
  buildInputs = lib.optionals pkgs.stdenv.isDarwin [
    pkgs.darwin.cctools
    pkgs.libiconv
  ];

  meta = {
    description = "Low-code programming for event-driven applications";
    homepage = "https://nodered.org";
    license = lib.licenses.asl20;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
}

/**
  * lib/autoImport.nix
  *
  * Given a profile name, returns the list of module paths that declare
  * membership in that profile.  Import this in a profile's
  * configuration.nix / home.nix:
  *
  *   imports = import ../../lib/autoImport.nix {
  *     inherit lib;
  *     registry  = ../../modules/system.nix;   # or home.nix
  *     profile   = systemSettings.profile;     # "personal" | "wsl"
  *   };
  *
  * Each entry in the registry is { path, profiles }.
  * `path` is an absolute path (use `./relative/path` inside the registry).
  * `profiles` is a list of strings matching systemSettings.profile values.
  */
{ lib, registry, profile }:
let
  entries = import registry;
  matching = builtins.filter (e: builtins.elem profile e.profiles) entries;
in
  map (e: e.path) matching

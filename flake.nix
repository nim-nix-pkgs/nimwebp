{
  description = ''Webp encoder and decoder bindings for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."nimwebp-master".dir   = "master";
  inputs."nimwebp-master".owner = "nim-nix-pkgs";
  inputs."nimwebp-master".ref   = "master";
  inputs."nimwebp-master".repo  = "nimwebp";
  inputs."nimwebp-master".type  = "github";
  inputs."nimwebp-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimwebp-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}
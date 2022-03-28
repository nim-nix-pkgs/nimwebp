{
  description = ''webp bindings'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimwebp-master.flake = false;
  inputs.src-nimwebp-master.ref   = "refs/heads/master";
  inputs.src-nimwebp-master.owner = "tormund";
  inputs.src-nimwebp-master.repo  = "nimwebp";
  inputs.src-nimwebp-master.type  = "github";
  
  inputs."nimpng".owner = "nim-nix-pkgs";
  inputs."nimpng".ref   = "master";
  inputs."nimpng".repo  = "nimpng";
  inputs."nimpng".dir   = "v0_3_1";
  inputs."nimpng".type  = "github";
  inputs."nimpng".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimpng".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github.com/yglukhov/clurp".owner = "nim-nix-pkgs";
  inputs."github.com/yglukhov/clurp".ref   = "master";
  inputs."github.com/yglukhov/clurp".repo  = "github.com/yglukhov/clurp";
  inputs."github.com/yglukhov/clurp".dir   = "";
  inputs."github.com/yglukhov/clurp".type  = "github";
  inputs."github.com/yglukhov/clurp".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/yglukhov/clurp".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimwebp-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nimwebp-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}
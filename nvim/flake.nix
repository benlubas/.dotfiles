{
  description = "Portable Neovim Flake, Kinda unmaintained/unused";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";

    neovim-nightly-src = {
      url = "github:neovim/neovim";
      flake = false;
    };
  };

  outputs = { nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        binpath = pkgs.lib.makeBinPath (with pkgs; [
          lua-language-server
          stylua
          lua # required for luarocks.nvim to work
          nil # nix-ls
          nixfmt-rfc-style

          nodePackages.prettier
          nodePackages.pyright

          # I can't install this with the rest of the python packages b/c this needs to be in path
          python3Packages.jupytext
        ]);
        neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
          extraLuaPackages = p: [ p.magick ];
          extraPython3Packages = p:
            with p; [
              pynvim
              jupyter-client
              cairosvg
              ipython
              nbformat
            ];
          withNodeJs = true;
          withRuby = true;
          withPython3 = true;
          # https://github.com/NixOS/nixpkgs/issues/211998
          customRC = "luafile ${inputs.self}/init.lua";
        };
        fullConfig = (neovimConfig // {
          wrapperArgs = pkgs.lib.escapeShellArgs neovimConfig.wrapperArgs
            + " --prefix PATH : ${binpath}";
        });
        neovim-custom = pkgs.wrapNeovimUnstable
          (pkgs.neovim-unwrapped.overrideAttrs (oldAttrs: {
            buildInputs = oldAttrs.buildInputs ++ [ pkgs.tree-sitter ];
            src = inputs.neovim-nightly-src;
          })) fullConfig;
        neovim-stable = pkgs.wrapNeovimUnstable
          (pkgs.neovim-unwrapped.overrideAttrs (oldAttrs: {
            buildInputs = oldAttrs.buildInputs ++ [ pkgs.tree-sitter ];
          })) fullConfig;

      in {
        packages = {
          default = neovim-custom;
          stable = neovim-stable;
        };
      });
}

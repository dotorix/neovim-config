{ lib, config, pkgs, pkgs-unstable, host-type, eval-type, ... }@args:
let
  support_packages = (with pkgs; [
    wl-clipboard
    xclip
    ripgrep
    jq  # json formatter
    nil # nix language server
  ]);
in {

  # packages
  nixos.programs.neovim.enable = true;
  nixos.environment.systemPackages = support_packages;

  #darwin = {};

  home-manager.home.packages = (lib.optionals (host-type == "home-manager") (with pkgs; [
    neovim
  ])) ++ support_packages;
  #pkgs.fishPlugins.z

  #home-manager.programs.fish.enable = true;

  #home-manager.programs.fish.plugins = [
#{
#  name = "z";
#  src = pkgs.fetchFromGitHub {
#    owner = "jethrokuan";
#    repo = "z";
#    rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
#    sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
#  };
#}
#];

  home-manager.xdg.configFile."nvim".source = pkgs.stdenv.mkDerivation {
    name = "config-nvim";
    src = ./.;
    phases = [ "installPhase" ];
    installPhase = ''
        mkdir -p $out
        cp $src $out -Tr
        rm $out/lazy-lock.json
        ln -sT ${config.xdg.dataHome}/nvim/lazy-lock.json $out/lazy-lock.json
        #cp -T $src/lazy-lock.json $out/lazy-lock.json
    '';
  };
  #home-manager.xdg.dataFile."nvim/lazy-lock.json".text='''';
  home-manager.home.activation."nvim-lazy-lock" = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir $VERBOSE_ARG -p ${config.xdg.dataHome}/nvim
    $DRY_RUN_CMD cp $VERBOSE_ARG -LT --remove-destination \
      ${./lazy-lock.json} ${config.xdg.dataHome}/nvim/lazy-lock.json
    $DRY_RUN_CMD chmod $VERBOSE_ARG 664 ${config.xdg.dataHome}/nvim/lazy-lock.json
  '';
  
#rm -rf ${config.xdg.dataHome}/nvim/lazy-lock.json
 # ln -sT "${config.xdg.dataHome}/nvim" $out/
  #home-manager.xdg.configFile."fish".source = pkgs.runCommandLocal "fish-config" {} '''';
  #home-manager.xdg.configFile."fish".source = pkgs.stdenv.mkDerivation {
  #  name = ".config-fish";
  #  src = ./.;
  #  phases = [ "installPhase" ];
  #  installPhase = ''
  #  ln -sT $src $out
  #  '';
  #};
  # dotfiles
  #home-manager.home.activation."fish" = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #  ln -sTf ${./.} $HOME/.config/fish --verbose
  #'';
  #home-manager.xdg.configFile = {
  #  "fish/config.fish".source = ./config.fish;
  #  "fish/prompt.fish".source = ./prompt.fish;
  ##  "fish/fish_variables".source = ./fish_variables;
  #  "fish/fish_plugins".source = ./fish_plugins;
  #};

  #home-manager.xdg.configFile."fish".source = config.lib.file.mkOutOfStoreSymlink ./.;
  #home-manager.xdg.configFile."fish".source = ./.;
  #home-manager.xdg.configFile."fish".recursive = true;
  #home-manager.xdg.configFile."fish/fish_variables2" = {
  #  source = config.lib.file.mkOutOfStoreSymlink "/home/admin/.local/share/fish/fish_variables";
  #  #target = "fish/fish_variables";
  #};
  #home-manager.home.file.".config/fish".source = ./.;
  #home-manager.home.file.".config/fish".recursive = true;
  #home-manager.home.file.".config/fish/fish_variables2".source = config.lib.file.mkOutOfStoreSymlink "/home/admin/.local/share/fish/fish_variables";
  #home-manager.home.file.".config/fish/fish_variables2".source = ./fish_variables1;

  # "${xdg.configHome}"
  #home-manager.home.file.".config/fish/fish_variables".source = ./fish_variables1; #config.lib.file.mkOutOfStoreSymlink "$HOME/.local/share/fish/fish_variables";
  #home-manager.xdg.configFile."fish/fish_variables".source = ./fish_variables1; #config.lib.file.mkOutOfStoreSymlink /data/cfg/nixos-preparation/modules/fish/fish_variables;
  #"$HOME/.local/fish/fish_variables";
  #home-manager.xdg.dataFile."fish/fish_variables".source = config.lib.file.mkOutOfStoreSymlink
  #home-manager.home.file.".config/fish".source = ./.;
  #home-manager.home.file.".config/fish".mode = "0644";
  #home-manager.home.file.".config/fish".source = config.lib.file.mkOutOfStoreSymlink ./.;

}.${eval-type} or {}


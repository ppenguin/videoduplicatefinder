{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  mylibs = with pkgs; [
    fontconfig
    xorg.libX11
    xorg.libICE
    xorg.libSM
  ];
in {
  # https://devenv.sh/basics/
  env = {
    GREET = "devenv";
    DOTNET_ROOT = "${pkgs.dotnet-runtime_9.unwrapped}/share/dotnet";
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath mylibs}";
  };
  # https://devenv.sh/packages/
  packages = with pkgs; [dotnet-sdk_9];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    hello
    git --version
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}

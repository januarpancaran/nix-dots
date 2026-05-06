{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = (pkgs.vscode.fhsWithPackages (pkgs: with pkgs; [
          dotnet-sdk_10
    ]));
  };
}

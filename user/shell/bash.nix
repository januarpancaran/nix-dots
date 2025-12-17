{
  pkgs,
  userSettings,
  ...
}: {
  home.packages = with pkgs; [
    bat
    fzf
    trash-cli
    zoxide
  ];

  programs.bash = {
    package = pkgs.bashInteractive;
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;

    historyControl = ["ignoredups" "erasedups"];
    historyFile = "/home/" + userSettings.username + "/.bash_history";
    historySize = 10000;

    shellOptions = [
      "histappend"
      "cmdhist"
    ];

    shellAliases = {
      ls = "ls -a --color=yes";
      ll = "ls -la --color=yes";
      vi = "nvim";
      vim = "nvim";
      fzf = "fzf -m --preview='bat --color=always {}'";
      nfzf = "nvim $(fzf -m --preview='bat --color=always {}')";
      cat = "bat";
      grep = "grep --color=auto";
      rm = "trash";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };

    initExtra = ''
      bind '"\C-p": history-search-backward'
      bind '"\C-n": history-search-forward'

      if command -v fastfetch &>/dev/null; then
        fastfetch
      fi

      export PATH="$PATH:$HOME/go/bin"

      eval "$(fzf --bash)"
      eval "$(starship init bash)"
      eval "$(zoxide init bash)"
    '';
  };
}

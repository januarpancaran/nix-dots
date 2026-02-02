{ pkgs, ... }:
{
  programs.tmux = {
    package = pkgs.tmux;
    enable = true;

    prefix = "C-Space";

    baseIndex = 1;
    mouse = true;
    historyLimit = 10000;

    extraConfig = ''
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      set-option -g status-position top
      set -g default-terminal "tmux-256color"

      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
    ];
  };
}

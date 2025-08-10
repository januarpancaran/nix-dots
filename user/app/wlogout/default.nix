{pkgs, ...}: {
  programs.wlogout = {
    package = pkgs.wlogout;
    enable = true;

    layout = [
      {
        label = "lock";
        action = "loginctl lock-session";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];

    style = ''
      * {
        background-image: none;
        box-shadow: none;
      }

      window {
        background-color: rgba(12, 12, 12, 0.9);
      }

      button {
        border-radius: 12px;
        border-color: #cba6f7;
        text-decoration-color: #cdd6f4;
        color: #cdd6f4;
        background-color: #1e1e2e;
        border-style: solid;
        border-width: 2px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus,
      button:active,
      button:hover {
        background-color: #cba6f7;
        color: #1e1e2e;
        outline-style: none;
      }

      #lock {
        background-image: image(url("./icons/padlock.png"));
      }

      #logout {
        background-image: image(url("./icons/logout.png"));
      }

      #suspend {
        background-image: image(url("./icons/pause-button.png"));
      }

      #hibernate {
        background-image: image(url("./icons/sleeping.png"));
      }

      #shutdown {
        background-image: image(url("./icons/power-button.png"));
      }

      #reboot {
        background-image: image(url("./icons/refresh.png"));
      }
    '';
  };

  home.file.".config/wlogout/icons" = {
    source = ./icons;
    recursive = true;
  };
}

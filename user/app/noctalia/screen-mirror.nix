{ config, pkgs, ... }:
let
  configDir = "${config.xdg.configHome}/noctalia";
  outFile = "${configDir}/z-screen-mirror.toml";

  setupScript = pkgs.writeShellScript "noctalia-screen-mirror-setup" ''
    desktop="''${XDG_CURRENT_DESKTOP:-}"

    case "$desktop" in
      niri)
        plugin="elijaharch/wl-screen-mirror"
        widget="elijaharch/wl-screen-mirror:mirror"
        ;;
      Hyprland)
        plugin="profidev/hypr-screen-mirror"
        widget="profidev/hypr-screen-mirror:widget"
        ;;
      *)
        # Unknown WM — remove any leftover override and bail out
        rm -f "${outFile}"
        exit 0
        ;;
    esac

    cat > "${outFile}" <<TOML
[plugins]
enabled = ["$plugin"]

[bar.default]
end = ["$widget", "tray", "volume", "brightness", "network", "battery", "control-center"]
TOML
  '';
in
{
  systemd.user.services.noctalia-screen-mirror-setup = {
    Unit = {
      Description = "Write noctalia screen-mirror config for the active WM";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${setupScript}";
      # Reload noctalia after writing so it picks up the new plugin/widget,
      # regardless of whether it started before or after this service.
      ExecStartPost = "${pkgs.noctalia}/bin/noctalia msg config-reload";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}


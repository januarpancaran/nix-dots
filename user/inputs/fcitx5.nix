{pkgs, ...}: {
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";

      fcitx5 = {
        waylandFrontend = true;

        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-nord
          fcitx5-chinese-addons
          fcitx5-anthy
          fcitx5-hangul
        ];

        settings = {
          globalOptions = {
            "Hotkey/TriggerKeys"."0" = "Control+backslash";
          };

          inputMethod = {
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "pinyin";
            };

            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "pinyin";
            "Groups/0/Items/2".Name = "anthy";
            "Groups/0/Items/3".Name = "hangul";

            GroupOrder."0" = "Default";
          };

          addons = {
            classicui.globalSection = {
              Theme = "Nord-Dark";
              Font = "JetBrainsMono Nerd Font 14";
              MenuFont = "JetBrainsMono Nerd Font 14";
              TrayFont = "JetBrainsMono Nerd Font Bold 14";
            };
          };
        };
      };
    };
  };
}

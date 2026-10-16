{ lib, ... }:
let
  # ---------------------------------------------------------------------------
  # Desktop shortcuts ("web apps") for Chromium-based browsers.
  #
  # Approach taken from
  # https://discourse.nixos.org/t/module-to-manage-desktop-shortcuts-in-chromium-or-brave/47162
  # The helper it links to (bashfulrobot/nixos, lib/cbb-webwrap) is no longer
  # online, so this is a small re-implementation that additionally reproduces
  # the window identity Chromium derives for `--app` windows, so the task
  # switcher and window rules can recognise them.
  # ---------------------------------------------------------------------------

  # Every `--app=URL` window gets a deterministic id built from the URL and the
  # profile directory. The compositor uses that id to pick the window icon and
  # to apply window rules, so the desktop entry must use the very same value.
  #
  #   app_name = "<host>_<path>"               # GenerateApplicationNameFromURL
  #   app_id   = "<exe>-<app_name>-<profile>"  # GetXdgAppIdForWebApp
  #
  # ...with characters that are illegal in a file name ("/") replaced by "_".
  # See chrome/browser/web_applications/web_app_helpers.cc and
  # chrome/browser/shell_integration_linux.cc in the Chromium tree.
  #
  # <exe> is Chromium's internal process name. It is "chrome" even for Chromium
  # and ungoogled-chromium builds (nixpkgs does not patch it). <profile> is the
  # profile's directory name, which is "Default" unless --profile-directory is
  # passed.
  chromiumAppId =
    {
      url,
      executable ? "chrome",
      profile ? "Default",
    }:
    let
      parts = builtins.match "https?://([^/?#]+)(/[^?#]*)?([?#].*)?" url;
      host = builtins.head parts;
      path = builtins.elemAt parts 1;
    in
    lib.replaceStrings [ "/" ] [ "_" ] "${executable}-${host}_${
      if path == null then "/" else path
    }-${profile}";
in
{
  flake.nixosModules.packagesGUIWebapps =
    { config, lib, pkgs, ... }:
    let
      x11Enabled = config.local.x11.enable;
      waylandEnabled = config.local.wayland.enable;
      windowingEnabled = x11Enabled || waylandEnabled;

      # Turn a URL into an installable desktop shortcut (a .desktop entry plus
      # its icon).
      makeDesktopApp =
        {
          name,
          url,
          icon,
          browser ? pkgs.ungoogled-chromium,
          categories ? [ "Network" ],
          # Flags shared by every web app. Adjust per app if necessary.
          flags ? [
            "--ozone-platform-hint=auto"
            "--force-dark-mode"
            "--enable-features=WebUIDarkMode"
            "--new-window"
          ],
          # Override only if Chromium's identity for the URL differs (see the
          # comment on chromiumAppId; verify with `hyprctl clients`).
          executable ? "chrome",
          profile ? "Default",
        }:
        let
          appId = chromiumAppId { inherit url executable profile; };

          launcher = pkgs.writeShellScript "${appId}-webapp" ''
            exec ${lib.getExe browser} \
              ${lib.escapeShellArgs flags} \
              --app=${lib.escapeShellArg url} \
              "$@"
          '';

          desktopItem = pkgs.makeDesktopItem {
            name = appId;
            desktopName = name;
            genericName = "${name} (web app)";
            comment = "${name}, installed as a Chromium web app";
            exec = "${launcher} %U";
            icon = appId;
            categories = categories;
            startupNotify = true;
            startupWMClass = appId;
          };

          # Icons at the sizes toolkits look for, plus the scalable original.
          icons = pkgs.runCommand "webapp-icon-${appId}" {
            nativeBuildInputs = [ pkgs.librsvg ];
          } ''
            install -Dm644 ${icon} "$out/share/icons/hicolor/scalable/apps/${appId}.svg"
            for size in 32 48 64 128 256 512; do
              dir="$out/share/icons/hicolor/''${size}x''${size}/apps"
              mkdir -p "$dir"
              rsvg-convert --width "$size" --height "$size" \
                --output "$dir/${appId}.png" ${icon}
            done
          '';
        in
        {
          inherit desktopItem icons;
        };

      webapps = [
        (makeDesktopApp {
          name = "WhatsApp";
          url = "https://web.whatsapp.com/";
          icon = ./icons/whatsapp.svg;
          categories = [ "Network" "InstantMessaging" ];
        })
        (makeDesktopApp {
          name = "Telegram";
          url = "https://web.telegram.org/a/";
          icon = ./icons/telegram.svg;
          categories = [ "Network" "InstantMessaging" ];
        })
        (makeDesktopApp {
          name = "Google Meet";
          url = "https://meet.google.com/";
          icon = ./icons/google-meet.svg;
          categories = [ "Network" "VideoConference" ];
        })
        (makeDesktopApp {
          name = "Discord";
          url = "https://discord.com/app";
          icon = ./icons/discord.svg;
          categories = [ "Network" "InstantMessaging" ];
        })
        (makeDesktopApp {
          name = "Instagram";
          url = "https://www.instagram.com/";
          icon = ./icons/instagram.svg;
          categories = [ "Network" ];
        })
        (makeDesktopApp {
          name = "LinkedIn";
          url = "https://www.linkedin.com/feed/";
          icon = ./icons/linkedin.svg;
          categories = [ "Network" ];
        })
      ];
    in
    {
      config = lib.mkIf windowingEnabled {
        environment.systemPackages = lib.concatMap (app: [
          app.desktopItem
          app.icons
        ]) webapps;
      };
    };
}

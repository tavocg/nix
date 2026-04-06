{ self, inputs, ... }: let
  mkSwayConfig = { pkgs, lib }: pkgs.writeText "sway-config" ''
    set $term ${lib.getExe pkgs.foot}
    set $filemgr env QT_QPA_PLATFORM=wayland ${lib.getExe' pkgs.kdePackages.dolphin "dolphin"}
    set $browser ${lib.getExe pkgs.firefox}

    set $col_nb #1e2326
    set $col_nf #374145
    set $col_sb #7fbbb3
    set $col_sf #1e2326

    set $font pango:JetBrainsMono Medium 8

    set $mod Mod4
    floating_modifier $mod
    set $alt Mod1
    set $left h
    set $down j
    set $up k
    set $right l

    bindsym $mod+Return exec $term
    bindsym $mod+r exec $(menu run "")
    bindsym $mod+p exec menu-power
    bindsym $mod+Shift+p exec menu-pass-gtype
    bindsym $mod+o exec menu-output
    bindsym $mod+i exec menu-input
    bindsym $mod+e exec $filemgr
    bindsym $mod+w exec $browser
    bindsym $mod+b exec menu-start
    bindsym XF86AudioRaiseVolume exec volup
    bindsym XF86AudioLowerVolume exec voldown
    bindsym XF86AudioMute exec mute
    bindsym Shift+XF86AudioRaiseVolume exec micup
    bindsym Shift+XF86AudioLowerVolume exec micdown
    bindsym Shift+XF86AudioMute exec micmute
    bindsym XF86AudioMicMute exec micmute
    bindsym XF86MonBrightnessUp exec brightup
    bindsym XF86MonBrightnessDown exec brightdown
    bindsym Print exec prtsc

    bindsym $mod+1 workspace "  1  "
    bindsym $mod+2 workspace "  2  "
    bindsym $mod+3 workspace "  3  "
    bindsym $mod+4 workspace "  4  "
    bindsym $mod+5 workspace "  5  "
    bindsym $mod+6 workspace "  6  "
    bindsym $mod+7 workspace "  7  "
    bindsym $mod+8 workspace "  8  "
    bindsym $mod+9 workspace "  9  "
    bindsym $mod+Shift+1 move container to workspace "  1  "
    bindsym $mod+Shift+2 move container to workspace "  2  "
    bindsym $mod+Shift+3 move container to workspace "  3  "
    bindsym $mod+Shift+4 move container to workspace "  4  "
    bindsym $mod+Shift+5 move container to workspace "  5  "
    bindsym $mod+Shift+6 move container to workspace "  6  "
    bindsym $mod+Shift+7 move container to workspace "  7  "
    bindsym $mod+Shift+8 move container to workspace "  8  "
    bindsym $mod+Shift+9 move container to workspace "  9  "
    bindsym $mod+comma workspace prev_on_output
    bindsym $mod+period workspace next_on_output

    bindsym $mod+Shift+q reload
    bindsym $mod+c kill
    bindsym $mod+$left focus left
    bindsym $mod+$down focus down
    bindsym $mod+$up focus up
    bindsym $mod+$right focus right
    bindsym $mod+Left focus left
    bindsym $mod+Down focus down
    bindsym $mod+Up focus up
    bindsym $mod+Right focus right
    bindsym $mod+Shift+$left move left
    bindsym $mod+Shift+$down move down
    bindsym $mod+Shift+$up move up
    bindsym $mod+Shift+$right move right
    bindsym $mod+Shift+Left move left
    bindsym $mod+Shift+Down move down
    bindsym $mod+Shift+Up move up
    bindsym $mod+Shift+Right move right

    bindsym $mod+Shift+t layout toggle tabbed split
    bindsym $mod+f fullscreen
    bindsym $mod+Shift+f floating toggle
    bindsym $mod+Shift+b bar mode toggle
    bindsym $mod+n split horizontal; layout tabbed
    bindsym $mod+s sticky toggle

    bindsym $mod+Ctrl+l resize shrink width 5 px or 5 ppt
    bindsym $mod+Ctrl+k resize grow height 5 px or 5 ppt
    bindsym $mod+Ctrl+j resize shrink height 5 px or 5 ppt
    bindsym $mod+Ctrl+h resize grow width 5 px or 5 ppt

    smart_gaps on
    hide_edge_borders smart
    client.focused $col_sb $col_sb $col_sf $col_nb $col_sb
    client.unfocused $col_nf $col_nb $col_nf $col_nb $col_nb
    default_border pixel 1
    font $font

    bar {
      position bottom
      font $font
      status_command statusbar
      tray_padding 4

      colors {
        background #000000
        statusline $col_nf
        focused_workspace $col_sb $col_sb $col_sf
        inactive_workspace $col_nf $col_nb $col_nf
      }
    }

    for_window [class="Display-im*"] floating enable
    for_window [title="Steam Settings"] floating enable
    for_window [title="Picture-in-Picture"] floating enable

    output * bg #000000 solid_color

    input type:touchpad {
        natural_scroll enabled
        dwt disabled
        tap enabled
    }

    input type:pointer {
        accel_profile flat
    }

    input type:keyboard {
        xkb_layout latam,us
        xkb_options grp:win_space_toggle
        repeat_delay 300
        repeat_rate 70
    }
  '';
in {
  flake.nixosModules.sway = { pkgs, lib, ... }: {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.sway
    ];

    fonts.packages = with pkgs; [
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  perSystem = { pkgs, lib, ... }: {
    packages.sway = pkgs.writeShellScriptBin "sway" ''
      exec ${lib.getExe pkgs.sway} -c ${mkSwayConfig { inherit pkgs lib; }} "$@"
    '';

    apps.sway = {
      type = "app";
      program = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.sway;
    };
  };
}

{
  lib,
  osConfig,
  ...
}: let
  inputoutput = ''
    ''${color grey}Usage:$color $alignr ''${diskio ${osConfig.fileSystems."/".device}}
    ''${color grey}Temp:$color $alignr ''${hwmon nvme temp 1}°C
  '';
  filesystems = builtins.concatStringsSep "\n" (
    lib.attrsets.mapAttrsToList (name: value: ''
      ''${color grey}${name}$color $alignr ''${fs_used ${name}}/''${fs_size ${name}} - ''${fs_used_perc ${name}}%
    '')
    osConfig.fileSystems
  );
in {
  services.conky = {
    enable = true;
    extraConfig = ''
      conky.config = {
        border_width = 1,
        cpu_avg_samples = 2,
        net_avg_samples = 2,
        no_buffers = true,
        out_to_console = false,
        out_to_stderr = false,
        extra_newline = false,
        stippled_borders = 0,
        uppercase = false,
        use_spacer = 'none',
        show_graph_scale = false,
        show_graph_range = false,

        alignment = 'top_right',
        background = true,
        default_color = 'green',
        default_outline_color = 'white',
        default_shade_color = 'white',
        double_buffer = true,
        draw_borders = false,
        draw_graph_borders = true,
        draw_outline = false,
        draw_shades = false,
        gap_x = 20,
        gap_y = 40,
        minimum_width = 100, minimum_height = 100,
        own_window = true,
        own_window_class = 'Conky',
        own_window_transparent = true,
        own_window_type = 'desktop',
        update_interval = 2.0,
        update_interval_on_battery = 5.0,
        use_xft = true,
        font = 'DejaVu Sans Mono:size=10',

        own_window_argb_value = 0,
        own_window_argb_visual = true,
        own_window_colour = '#000000',
      };
      conky.text = [[
      ''${color white}SYSTEM ''${hr 2}$color
      ''${color grey}$sysname $kernel on $machine
      ''${color grey}Host:$color $alignr $nodename
      ''${color grey}Uptime:$color $alignr $uptime
      ''${color grey}Battery:$color $alignr $battery - $battery_time
      ''${color grey}Processes:$color $processes $alignr ''${color grey}Running:$color $running_processes

      ''${color white}CPU ''${hr 2}$color
      ''${color grey}Frequency:$color $alignr $freq_g GHz
      ''${color grey}Usage:$color $alignr $cpu%
      ''${color grey}Temp:$color $alignr ''${hwmon acpitz temp 1}°C

      ''${color white}GPU ''${hr 2}$color
      ''${if_match ''${exec lsmod | grep -c 'nvidia'} > 0}
      ''${color grey}GPU Frequency:$color $alignr ''${nvidia gpufreq} MHz
      ''${color grey}Memory Frequency:$color $alignr ''${nvidia memfreq} MHz
      ''${color grey}Temp:$color $alignr ''${nvidia temp}°C
      ''${endif}
      ''${if_match ''${exec lsmod | grep -c 'amdgpu'} > 0}
      ''${color grey}GPU Frequency:$color $alignr ''${exec grep -Po '\d+:\s\K(\d+)(?=.*\*$)' /sys/class/drm/card0/device/pp_dpm_sclk} MHz
      ''${color grey}Memory Frequency:$color $alignr ''${exec grep -Po '\d+:\s\K(\d+)(?=.*\*$)' /sys/class/drm/card0/device/pp_dpm_mclk} MHz
      ''${color grey}Temp:$color $alignr ''${hwmon amdgpu temp 1}°C
      ''${endif}

      ''${color white}MEMORY ''${hr 2}$color
      ''${color grey}RAM Usage:$color $alignr $mem/$memmax - $memperc%
      ''${color grey}Swap Usage:$color $alignr $swap/$swapmax - $swapperc%

      ''${color white}I/O ''${hr 2}$color
      ${inputoutput}

      #''${color white}TOP PROCESSES BY CPU ''${hr 2}$color
      #''${color grey}''${top name 1} $alignr ''${top pid 1} ''${top cpu 1} %
      #''${color grey}''${top name 2} $alignr ''${top pid 2} ''${top cpu 2} %
      #''${color grey}''${top name 3} $alignr ''${top pid 3} ''${top cpu 3} %

      #''${color white}TOP PROCESSES BY MEMORY ''${hr 2}$color
      #''${color grey}''${top_mem name 1} $alignr ''${top_mem pid 1} ''${top_mem mem 1} %
      #''${color grey}''${top_mem name 2} $alignr ''${top_mem pid 2} ''${top_mem mem 2} %
      #''${color grey}''${top_mem name 3} $alignr ''${top_mem pid 3} ''${top_mem mem 3} %

      #''${color white}TOP PROCESSES BY I/O ''${hr 2}$color
      #''${color grey}''${top_io name 1} $alignr ''${top_io pid 1} ''${top_io io_perc 1} %
      #''${color grey}''${top_io name 2} $alignr ''${top_io pid 2} ''${top_io io_perc 2} %
      #''${color grey}''${top_io name 3} $alignr ''${top_io pid 3} ''${top_io io_perc 3} %

      ''${color white}FILE SYSTEM ''${hr 2}$color
      ${filesystems}

      ''${color white}NETWORK ''${hr 2}$color
      ''${if_existing /proc/net/route wlp2s0} ''${color lightgrey}$alignc Wireless
      ''${color grey}IP address:$color $alignr ''${addr wlp2s0}
      ''${color grey}SSID:$color $alignr ''${wireless_essid wlp2s0}
      ''${color grey}Speed:$color $alignr ''${wireless_bitrate wlp2s0}
      ''${color grey}Quality:$color $alignr ''${wireless_link_qual_perc wlp2s0}%
      ''${color grey}Inbound:$color ''${downspeed wlp2s0} $alignr ''${color grey}Total:$color ''${totaldown wlp2s0}
      ''${color grey}Outbound:$color ''${upspeed wlp2s0} $alignr ''${color grey}Total:$color ''${totalup wlp2s0}
      ''${endif}
      ''${if_existing /proc/net/route enp1s0} ''${color lightgrey}$alignc Wired
      ''${color grey}IP address:$color $alignr ''${addr enp1s0}
      ''${color grey}Inbound:$color ''${downspeed enp1s0} $alignr ''${color grey}Total:$color ''${totaldown enp1s0}
      ''${color grey}Outbound:$color ''${upspeed enp1s0} $alignr ''${color grey}Total:$color ''${totalup enp1s0}
      ''${endif}
      #''${if_existing /proc/net/route ppp0} ''${color lightgrey}$alignc Mobile
      #''${color grey}IP address:$color $alignr ''${addr ppp0}
      #''${color grey}Inbound:$color ''${downspeed ppp0} $alignr ''${color grey}Total:$color ''${totaldown ppp0}
      #''${color grey}Outbound:$color ''${upspeed ppp0} $alignr ''${color grey}Total:$color ''${totalup ppp0}
      #''${endif}
      ]];
    '';
  };
}

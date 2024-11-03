{
  config,
  lib,
  osConfig,
  ...
}:
with lib;
let
  cfg = config.conkyConfig;
  filesystems = builtins.concatStringsSep "\n" (
    lib.attrsets.mapAttrsToList (name: value: ''
      ''${color grey}${name}$color $alignr ''${fs_used ${name}}/''${fs_size ${name}} - ''${fs_used_perc ${name}}%
    '') osConfig.fileSystems
  );
in
{
  options.conkyConfig = {
    enable = mkEnableOption "Wether to enable conky configuration (see https://conky.cc/)";

    cpuModel = mkOption rec {
      type = types.str;
      default = example;
      description = "Variable for CPU model name";
      example = "''${exec "${escapeShellArg "sed - n 's/([^)]*)//g; /model name/ {s/.*: //; s/ CPU.*//; p; q}' /proc/cpuinfo"}"}";
    };
    cpuTemp = mkOption {
      type = types.str;
      default = null;
      description = "Variable for CPU temperature in °C";
      example = "''${hwmon coretemp temp 1}";
    };

    gpuModel = mkOption {
      type = types.str;
      default = null;
      description = "Variable for GPU model name";
      example = "''${nvidia modelname 0}";
    };
    gpuFreq = mkOption {
      type = types.str;
      default = null;
      description = "Variable for GPU clock speed in MHz";
      example = "''${nvidia gpufreq 0}";
    };
    gpuMemFreq = mkOption {
      type = types.str;
      default = null;
      description = "Variable for GPU memory clock speed in MHz";
      example = "''${nvidia memfreq 0}";
    };
    gpuTemp = mkOption {
      type = types.str;
      default = null;
      description = "Variable for GPU temperature in °C";
      example = "''${nvidia gputemp 0}";
    };

    ioTemp = mkOption {
      type = types.str;
      default = null;
      description = "Variable for I/O temperature in °C";
      example = "''${hwmon nvme temp 1}";
    };

    networkWiredDevice = mkOption {
      type = types.str;
      default = "";
      description = "Name of the wired interface device";
      example = "enp1s0";
    };
    networkWirelessDevice = mkOption {
      type = types.str;
      default = "";
      description = "Name of the wireless interface device";
      example = "wlp1s0";
    };
    networkModemDevice = mkOption {
      type = types.str;
      default = "";
      description = "Name of the modem interface device";
      example = "ppp0";
    };
  };

  config = mkIf cfg.enable {
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
          background = false,
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
          own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
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
        ''${if_empty $battery}
        ''${else} ''${color grey}Battery:$color $alignr $battery - $battery_time
        ''${endif}
        ''${color grey}Processes:$color $processes $alignr ''${color grey}Running:$color $running_processes

        ''${color white}CPU ''${hr 2}$color
        ''${color grey}Frequency:$color $alignr $freq_g GHz
        ''${color grey}Usage:$color $alignr $cpu%
        ''${color grey}Temp:$color $alignr ${cfg.cpuTemp}°C

        ''${color white}GPU ''${hr 2}$color
        ''${color grey}Model:$color $alignr ${cfg.gpuModel}
        ''${color grey}GPU Frequency:$color $alignr ${cfg.gpuFreq} MHz
        ''${color grey}Memory Frequency:$color $alignr ${cfg.gpuMemFreq} MHz
        ''${color grey}Temp:$color $alignr ${cfg.gpuTemp}°C

        ''${color white}MEMORY ''${hr 2}$color
        ''${color grey}RAM Usage:$color $alignr $mem/$memmax - $memperc%
        ''${color grey}Swap Usage:$color $alignr $swap/$swapmax - $swapperc%

        ''${color white}I/O ''${hr 2}$color
        ''${color grey}Usage:$color $alignr ''${diskio ${osConfig.fileSystems."/".device}}
        ''${color grey}Temp:$color $alignr ${cfg.ioTemp}°C

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
        ''${if_existing /proc/net/route ${cfg.networkWirelessDevice}} ''${color lightgrey}$alignc Wireless
        ''${color grey}IP address:$color $alignr ''${addr ${cfg.networkWirelessDevice}}
        ''${color grey}SSID:$color $alignr ''${wireless_essid ${cfg.networkWirelessDevice}}
        ''${color grey}Speed:$color $alignr ''${wireless_bitrate ${cfg.networkWirelessDevice}}
        ''${color grey}Quality:$color $alignr ''${wireless_link_qual_perc ${cfg.networkWirelessDevice}}%
        ''${color grey}Inbound:$color ''${downspeed ${cfg.networkWirelessDevice}} $alignr ''${color grey}Total:$color ''${totaldown ${cfg.networkWirelessDevice}}
        ''${color grey}Outbound:$color ''${upspeed ${cfg.networkWirelessDevice}} $alignr ''${color grey}Total:$color ''${totalup ${cfg.networkWirelessDevice}}
        ''${endif}
        ''${if_existing /proc/net/route ${cfg.networkWiredDevice}} ''${color lightgrey}$alignc Wired
        ''${color grey}IP address:$color $alignr ''${addr ${cfg.networkWiredDevice}}
        ''${color grey}Inbound:$color ''${downspeed ${cfg.networkWiredDevice}} $alignr ''${color grey}Total:$color ''${totaldown ${cfg.networkWiredDevice}}
        ''${color grey}Outbound:$color ''${upspeed ${cfg.networkWiredDevice}} $alignr ''${color grey}Total:$color ''${totalup ${cfg.networkWiredDevice}}
        ''${endif}
        ''${if_existing /proc/net/route ${cfg.networkModemDevice}} ''${color lightgrey}$alignc Modem
        ''${color grey}IP address:$color $alignr ''${addr ${cfg.networkModemDevice}}
        ''${color grey}Inbound:$color ''${downspeed ${cfg.networkModemDevice}} $alignr ''${color grey}Total:$color ''${totaldown ${cfg.networkModemDevice}}
        ''${color grey}Outbound:$color ''${upspeed ${cfg.networkModemDevice}} $alignr ''${color grey}Total:$color ''${totalup ${cfg.networkModemDevice}}
        ''${endif}
        ]];
      '';
    };
  };
}

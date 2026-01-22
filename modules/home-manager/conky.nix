{
  lib,
  options,
  config,
  pkgs,
  osConfig,
  ...
}:
let
  cfg = config.conkyConfig;
  filesystems = builtins.concatStringsSep "\n" (
    lib.attrsets.mapAttrsToList (name: value: ''
      ''${color grey}${name}$color $alignr ''${fs_used ${name}} / ''${fs_size ${name}} (''${fs_used_perc ${name}}%)
    '') osConfig.fileSystems
  );
in
{
  options.conkyConfig = {
    enable = lib.mkEnableOption "Wether to enable conky configuration (see https://conky.cc/)";

    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [
        pkgs.coreutils
        pkgs.jq
        pkgs.gnused
      ];
      description = ''
        List of packages to be added to PATH for the conky service.
      '';
      example = options.conkyConfig.packages.default ++ [ pkgs.nvtopPackages.intel ];
    };

    cpuModel = lib.mkOption rec {
      type = lib.types.str;
      default = example;
      description = "Variable for CPU model name";
      example = "\${execi 86400 sed -n 's/([^)]*)//g; /model name/ {s/.*: //; s/ CPU.*//; p; q}' /proc/cpuinfo}";
    };
    cpuTemp = lib.mkOption rec {
      type = lib.types.str;
      default = example;
      description = "Variable for CPU temperature in Celsius degrees";
      example = "\${hwmon coretemp temp 1}";
    };

    gpuModel = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        Variable for GPU model name.

        Possible values:
        - NVIDIA: ''\${nvidia modelname 0}
        - Others: ''${execi 86400 nvtop -s | jq -r '.[0].device_name // "N/A"'}
      '';
      example = "\${nvidia modelname 0}";
    };
    gpuCoreFreq = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        Variable for GPU core clock speed in MHz.

        Possible values:
        - NVIDIA: ''\${nvidia gpufreq 0}
        - Others: ''${exec nvtop -s | jq -r '.[0].gpu_clock // "N/A" | rtrimstr("Hz")' | numfmt --from=si --invalid=ignore --to-unit=1M}
      '';
      example = "\${nvidia gpufreq 0}";
    };
    gpuMemFreq = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        Variable for GPU memory (VRAM) clock speed in MHz.

        Possible values:
        - NVIDIA: ''\${nvidia memfreq 0}
        - Others: ''${exec nvtop -s | jq -r '.[0].mem_clock // "N/A" | rtrimstr("Hz")' | numfmt --from=si --invalid=ignore --to-unit=1M}
      '';
      example = "\${nvidia memfreq 0}";
    };
    gpuMemUsed = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        Variable for amount of used GPU memory (VRAM).

        Possible values:
        - NVIDIA: ''\${nvidia memused 0}
      '';
      example = "\${nvidia memused 0}";
    };
    gpuMemTotal = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        Variable for total amount of GPU memory (VRAM).

        Possible values:
        - NVIDIA: ''\${nvidia memtotal 0}
      '';
      example = "\${nvidia memtotal 0}";
    };
    gpuMemUsage = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        Variable for GPU memory (VRAM) utilization in percent.

        Possible values:
        - NVIDIA: ''\${nvidia memutil 0}
        - Others: ''${exec nvtop -s | jq -r '.[0].mem_util // "N/A" | rtrimstr("%")'}
      '';
      example = "\${nvidia memutil 0}";
    };
    gpuTemp = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        Variable for GPU temperature in Celsius degrees.

        Possible values:
        - NVIDIA: ''\${nvidia gputemp 0}
        - AMD: ''\${hwmon amdgpu temp 1}
        - Others: ''${exec nvtop -s | jq -r '.[0].temp // "N/A" | rtrimstr("C")'}
      '';
      example = "\${nvidia gputemp 0}";
    };
    gpuUsage = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        Variable for GPU utilization in percent.

        Possible values:
        - NVIDIA: ''\${nvidia gpuutil 0}
        - Others: ''${exec nvtop -s | jq -r '.[0].gpu_util // "N/A" | rtrimstr("%")'}
      '';
      example = "\${nvidia gpuutil 0}";
    };

    ioTemp = lib.mkOption rec {
      type = lib.types.str;
      default = example;
      description = "Variable for I/O temperature in Celsius degrees";
      example = "\${hwmon nvme temp 1}";
    };

    top = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Wether to enable the display of top processes by CPU, memory and I/O";
        example = "true";
      };
    };

    networkWiredDevice = lib.mkOption {
      type = lib.types.str;
      default = "null";
      description = "Name of the wired interface device";
      example = "enp1s0";
    };
    networkWirelessDevice = lib.mkOption {
      type = lib.types.str;
      default = "null";
      description = "Name of the wireless interface device";
      example = "wlp1s0";
    };
    networkModemDevice = lib.mkOption {
      type = lib.types.str;
      default = "null";
      description = "Name of the modem interface device";
      example = "ppp0";
    };
  };

  config = lib.mkIf cfg.enable {
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
          update_interval = 5.0,
          update_interval_on_battery = 15.0,
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
        ''${if_empty $battery} ''${else} ''${color grey}Battery:$color $alignr $battery_percent ($battery_status) - $battery_time ''${endif}
        ''${color grey}Processes:$color $processes $alignr ''${color grey}Running:$color $running_processes

        ''${color white}CPU ''${hr 2}$color
        ''${color grey}Model:$color $alignr ${cfg.cpuModel}
        ''${color grey}Frequency:$color $alignr $freq MHz ($cpu%)
        ''${color grey}Temp:$color $alignr ${cfg.cpuTemp}°C

        ''${if_match "${cfg.gpuModel}" != ""}''${color white}GPU ''${hr 2}$color
        ''${color grey}Model:$color $alignr ${cfg.gpuModel}
        ''${color grey}Core Frequency:$color $alignr ${cfg.gpuCoreFreq} MHz''${if_match "${cfg.gpuUsage}" != ""} (${cfg.gpuUsage}%)''${endif}
        ''${if_match "${cfg.gpuMemFreq}" != ""}''${color grey}Memory Frequency:$color $alignr ${cfg.gpuMemFreq} MHz''${endif}
        ''${if_match "${cfg.gpuMemUsage}" != ""}''${color grey}Memory Usage:$color $alignr ''${if_match "${cfg.gpuMemUsed}" != ""}${cfg.gpuMemUsed} / ${cfg.gpuMemTotal} ''${endif}(${cfg.gpuMemUsage}%)''${endif}
        ''${if_match "${cfg.gpuTemp}" != ""}''${color grey}Temp:$color $alignr ${cfg.gpuTemp}°C''${endif}
        ''${endif}

        ''${color white}MEMORY ''${hr 2}$color
        ''${color grey}RAM Usage:$color $alignr $mem / $memmax ($memperc%)
        ''${color grey}Swap Usage:$color $alignr $swap / $swapmax ($swapperc%)

        ''${color white}I/O ''${hr 2}$color
        ''${color grey}Usage:$color $alignr ''${diskio ${osConfig.fileSystems."/".device}}
        ''${color grey}Temp:$color $alignr ${cfg.ioTemp}°C

        ''${if_match "${lib.boolToString cfg.top.enable}" == "true"}
        ''${color white}TOP PROCESSES BY CPU ''${hr 2}$color
        ''${color grey}''${top name 1} $alignr ''${top pid 1} ''${top cpu 1}%
        ''${color grey}''${top name 2} $alignr ''${top pid 2} ''${top cpu 2}%
        ''${color grey}''${top name 3} $alignr ''${top pid 3} ''${top cpu 3}%

        ''${color white}TOP PROCESSES BY MEMORY ''${hr 2}$color
        ''${color grey}''${top_mem name 1} $alignr ''${top_mem pid 1} ''${top_mem mem 1}%
        ''${color grey}''${top_mem name 2} $alignr ''${top_mem pid 2} ''${top_mem mem 2}%
        ''${color grey}''${top_mem name 3} $alignr ''${top_mem pid 3} ''${top_mem mem 3}%

        ''${color white}TOP PROCESSES BY I/O ''${hr 2}$color
        ''${color grey}''${top_io name 1} $alignr ''${top_io pid 1} ''${top_io io_perc 1}%
        ''${color grey}''${top_io name 2} $alignr ''${top_io pid 2} ''${top_io io_perc 2}%
        ''${color grey}''${top_io name 3} $alignr ''${top_io pid 3} ''${top_io io_perc 3}%
        ''${endif}

        ''${color white}FILE SYSTEM ''${hr 2}$color
        ${filesystems}

        ''${color white}NETWORK ''${hr 2}$color
        ''${if_up ${cfg.networkWirelessDevice}}''${color lightgrey}$alignc Wireless
        ''${color grey}IP address:$color $alignr ''${addr ${cfg.networkWirelessDevice}}
        ''${color grey}SSID:$color $alignr ''${wireless_essid ${cfg.networkWirelessDevice}}
        ''${color grey}Speed:$color $alignr ''${wireless_bitrate ${cfg.networkWirelessDevice}}
        ''${color grey}Quality:$color $alignr ''${wireless_link_qual_perc ${cfg.networkWirelessDevice}}%
        ''${color grey}Inbound:$color ''${downspeed ${cfg.networkWirelessDevice}} $alignr ''${color grey}Total:$color ''${totaldown ${cfg.networkWirelessDevice}}
        ''${color grey}Outbound:$color ''${upspeed ${cfg.networkWirelessDevice}} $alignr ''${color grey}Total:$color ''${totalup ${cfg.networkWirelessDevice}}
        ''${endif}
        ''${if_up ${cfg.networkWiredDevice}}''${color lightgrey}$alignc Wired
        ''${color grey}IP address:$color $alignr ''${addr ${cfg.networkWiredDevice}}
        ''${color grey}Inbound:$color ''${downspeed ${cfg.networkWiredDevice}} $alignr ''${color grey}Total:$color ''${totaldown ${cfg.networkWiredDevice}}
        ''${color grey}Outbound:$color ''${upspeed ${cfg.networkWiredDevice}} $alignr ''${color grey}Total:$color ''${totalup ${cfg.networkWiredDevice}}
        ''${endif}
        ''${if_up ${cfg.networkModemDevice}}''${color lightgrey}$alignc Modem
        ''${color grey}IP address:$color $alignr ''${addr ${cfg.networkModemDevice}}
        ''${color grey}Inbound:$color ''${downspeed ${cfg.networkModemDevice}} $alignr ''${color grey}Total:$color ''${totaldown ${cfg.networkModemDevice}}
        ''${color grey}Outbound:$color ''${upspeed ${cfg.networkModemDevice}} $alignr ''${color grey}Total:$color ''${totalup ${cfg.networkModemDevice}}
        ''${endif}
        ]];
      '';
    };

    systemd.user.services."conky" = {
      Service = {
        Environment = "PATH=$PATH:${lib.makeBinPath (cfg.packages)}";
      };
    };
  };
}

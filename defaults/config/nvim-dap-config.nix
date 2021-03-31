{ pkgs }:
with pkgs;
let

  python = pkgs.python3.withPackages (ps: [ ps.debugpy ]); # TODO: not ideal

  dapWrapper = configs: ''
    local dap = require('dap')
    dap.adapters = {
      ${builtins.toJSON configs.adapters}
    }
    dap.configurations = {
      ${builtins.toJSON configs.configurations}
    }
  '';
in
dapWrapper {
  adapters = {
    python = {
      type = "executable";
      command = "${python}/bin/python";
      args = [ "-m" "debugpy.adapter" ];
    };
  };

  configurations = {
    python = {
      type = "python";
      request = "launch";
      name = ''''${file}'';
      pythonPath = "${python}/bin/python";
    };

    # go = {
    #   type = "go";
    #   name = "Debug";
    #   request = "launch";
    #   program = "''${file}";
    # };
  };

}
#''
#  
#
#  dap.adapters.python = {
#    type = 'executable',
#    command = '${python3.withPackages (ps: [ ps.debugpy ])}/bin/python',
#    args = { '-m', 'debugpy.adapter' }
#  }
#
#  dap.configurations.python = {
#    {
#      type = 'python',
#      request = 'launch',
#      name = "Launch File",
#      program = "''${file}",
#      pythonPath = function(adapter)
#        return '${python3}/bin/python'
#      end
#    }
#  }
#
#  dap.adapters.cpp = {
#    type = 'executable',
#    attach = {
#      pidProperty = "pid",
#      pidSelect = "ask"
#    },
#    command = '${pkgs.lldb}/bin/lldb-vscode',
#    env = {
#      LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
#    },
#    name = "lldb"
#  }
#
#  dap.adapters.go = function(callback, config)
#    local handle
#    local pid_or_err
#    local port = 38697
#    handle, pid_or_err =
#      vim.loop.spawn(
#      "dlv",
#      {
#        args = {"dap", "-l", "127.0.0.1:" .. port},
#        detached = true
#      },
#      function(code)
#        handle:close()
#        print("Delve exited with exit code: " .. code)
#      end
#    )
#     ----should we wait for delve to start???
#    --vim.defer_fn(
#    --function()
#      --dap.repl.open()
#      --callback({type = "server", host = "127.0.0.1", port = port})
#    --end,
#    --100)
#
#      callback({type = "server", host = "127.0.0.1", port = port})
#  end
#  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
#  dap.configurations.go = {
#    {
#      type = "go",
#      name = "Debug",
#      request = "launch",
#      program = "''${file}"
#    }
#  }
#
#''

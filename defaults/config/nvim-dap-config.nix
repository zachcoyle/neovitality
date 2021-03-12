{ pkgs }:
with pkgs;
''
  packadd nvim-dap
  lua << EOF

  local dap = require('dap')
  dap.adapters.python = {
    type = 'executable',
    command = '${python3.withPackages (ps: [ ps.debugpy ])}/bin/python',
    args = { '-m', 'debugpy.adapter' }
  }

  dap.configurations.python = {
    {
      type = 'python',
      request = 'launch',
      name = "Launch File",
      program = "''${file}",
      pythonPath = function(adapter)
        return '${python3}/bin/python'
      end
    }
  }

  EOF
''

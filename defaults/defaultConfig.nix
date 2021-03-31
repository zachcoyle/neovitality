{ pkgs, lib ? pkgs.lib }:
with builtins;
with lib;
let
  wrapLuaConfig = luaConfig: ''
    lua << EOF
    ${luaConfig}
    EOF
  '';

in
{
  plugins = with pkgs.vimPlugins; with pkgs.vitalityVimPlugins;  [
    { plugin = barbar-nvim; }
    { plugin = compe-tabnine; }
    { plugin = conjure; }
    { plugin = direnv-vim; config = readFile ./config/direnv-vim-config.vim; }
    { plugin = editorconfig-vim; }
    { plugin = emmet-vim; config = readFile ./config/emmet-vim-config.vim; }
    { plugin = formatter-nvim; config = wrapLuaConfig (import ./config/formatter-nvim-config.nix { inherit pkgs; }); }
    { plugin = fugitive; }
    { plugin = galaxyline-nvim; config = wrapLuaConfig (builtins.readFile ./config/galaxyline-nvim-config.lua); }
    { plugin = gitsigns-nvim; config = wrapLuaConfig (builtins.readFile ./config/gitsigns-nvim-config.lua); }
    { plugin = gruvbox; config = readFile ./config/theme-config.vim; }
    { plugin = indent-blankline-nvim; config = "let g:indent_blankline_bufname_exclude = ['Startify']"; }
    { plugin = lsp_extensions-nvim; }
    { plugin = lspkind-nvim; config = "lua require('lspkind').init()"; }
    { plugin = LuaSnip; }
    { plugin = nvim-blame-line; }
    { plugin = nvim-compe; config = wrapLuaConfig (readFile ./config/nvim-compe-config.lua); }
    # { plugin = nvim-dap-virtual-text; config = "let g:dap_virtual_text = v:true"; }
    # { plugin = nvim-dap; config = "packadd nvim-dap" + wrapLuaConfig (import ./config/nvim-dap-config.nix { inherit pkgs; }); }
    { plugin = nvim-lightbulb; config = "autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()"; }
    { plugin = nvim-lspconfig; }
    { plugin = nvim-tree-lua; config = readFile ./config/nvim-tree-lua-config.vim; }
    { plugin = nvim-treesitter-context; }
    { plugin = nvim-treesitter-textobjects; config = readFile ./config/nvim-treesitter-textobjects-config.vim; }
    { plugin = nvim-treesitter; config = wrapLuaConfig (readFile ./config/nvim-treesitter-config.lua); }
    { plugin = nvim-ts-autotag; }
    { plugin = nvim-ts-context-commentstring; }
    { plugin = nvim-ts-rainbow; }
    { plugin = nvim-web-devicons; }
    # { plugin = packer-nvim; }
    { plugin = pkgs.vimPlugins.telescope-fzy-native-nvim; config = "lua require('telescope').load_extension('fzy_native')"; }
    { plugin = plenary-nvim; }
    { plugin = popup-nvim; }
    { plugin = scrollbar-nvim; config = readFile ./config/scrollbar-nvim-config.vim; }
    { plugin = surround; }
    { plugin = tabular; }
    { plugin = telescope-github-nvim; config = "lua require('telescope').load_extension('gh')"; }
    { plugin = telescope-node-modules-nvim; config = "lua require'telescope'.load_extension('node_modules')"; }
    { plugin = telescope-nvim; config = wrapLuaConfig (readFile ./config/telescope-nvim-config.lua); }
    { plugin = vim-closer; }
    { plugin = vim-commentary; }
    { plugin = vim-cursorword; }
    { plugin = vim-dadbod-ui; }
    { plugin = vim-dadbod; }
    { plugin = vim-devicons; }
    { plugin = vim-dispatch; }
    { plugin = vim-floaterm; config = readFile ./config/vim-floaterm-config.vim; }
    { plugin = vim-hexokinase; config = "let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'"; }
    { plugin = vim-mundo; config = readFile ./config/mundo-config.vim; }
    { plugin = vim-parinfer; }
    { plugin = vim-polyglot; }
    { plugin = vim-prisma; }
    { plugin = vim-repeat; }
    { plugin = vim-sensible; }
    { plugin = vim-sneak; config = "let g:sneak#label=1"; }
    { plugin = vim-startify; config = readFile ./config/vim-startify-config.vim; }
    { plugin = vim-tmux-navigator; }
    { plugin = vimagit; }
    {
      plugin = vim-which-key;
      config = ''
        let g:mapleader = "\<Space>" 
        let g:maplocalleader = ','
        nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<cr>
        nnoremap <silent> <localleader> :<c-u>WhichKey  ','<cr>
      '';
    }
  ];

  configRC = ''
    ${builtins.readFile ./config/init.vim}
  '';

  nnoremap = {

    #NvimTree
    Ctrl-n = ":NvimTreeToggle<cr>";
    "<leader>n" = ":NvimTreeFindFile<cr>";
    # "<leader>r" = ":NvimTreeRefresh<cr>";

    # nvim lsp
    "<F2>" = "<cmd>lua vim.lsp.buf.rename()<cr>";
    "<leader>e" = "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>";
    "<leader>f" = "<cmd>lua vim.lsp.buf.formatting()<cr>";
    "<leader>k" = "<cmd>lua vim.lsp.buf.signature_help()<cr>";
    "<leader>q" = "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>";
    "<leader>rn" = "<cmd>lua vim.lsp.buf.rename()<cr>";
    "<leader>wa" = "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>";
    "<leader>wl" = "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>";
    "<leader>wr" = "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>";
    "[d" = "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>";
    "]d" = "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>";
    gi = "<cmd>lua vim.lsp.buf.implementation()<cr>";
    K = "<cmd>lua vim.lsp.buf.hover()<cr>";

    # telescope
    "<leader>a" = "<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>";
    "<leader>d" = "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>";
    "<leader>i" = "<cmd>lua require('telescope').extensions.gh.issues()<cr>";
    "<leader>p" = "<cmd>lua require('telescope').extensions.gh.pull_request()<cr>";
    "<leader>t" = "<cmd>Telescope<cr>";
    "<leader>tr" = "<cmd>lua require('telescope.builtin').live_grep()<cr>";
    Ctrl-_ = "<cmd>lua require('telescope.builtin').live_grep()<cr>";
    Ctrl-B = "<cmd>lua require('telescope.builtin').buffers()<cr>";
    Ctrl-P = "<cmd>lua require('telescope.builtin').find_files()<cr>";
    gd = "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>";
    gr = "<cmd>lua require('telescope.builtin').lsp_references()<cr>";

    # navigation
    Ctrl-h = "<C-W>h";
    Ctrl-j = "<C-W>j";
    Ctrl-k = "<C-W>k";
    Ctrl-l = "<C-W>l";

    # nvim-dap
    "<F10>" = "lua require'dap'.step_over()<cr>";
    "<F11>" = "lua require'dap'.step_into()<cr>";
    "<F12>" = "lua require'dap'.step_out()<cr>";
    "<F5>" = "lua require'dap'.continue()<cr>";
    "<leader>B" = "lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition:'))<cr>";
    "<leader>b" = "lua require'dap'.toggle_breakpoint()<cr>";
    "<leader>dl" = "lua require'dap'.repl.run_last()<cr>";
    "<leader>dr" = "lua require'dap'.repl.open()<cr>";
    "<leader>lp" = "lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message:'))<cr>";

    #Floaterm
    "<leader>fn" = "<cmd>FloatermToggle<cr>";
    "<leader>fg" = "<cmd>FloatermNew ${pkgs.gitui}/bin/gitui<cr>";

    # blameline
    "<leader>bl" = "<cmd>ToggleBlameLine<cr>";

    #gundo
    "<F3>" = "<cmd>MundoToggle<cr>";

  };

  inoremap = { };

  snoremap = { };

  tnoremap = {
    "<leader>x" = "<Esc> <C-\\><C-n>";
  };
}

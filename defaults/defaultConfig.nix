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
    { plugin = codi-vim; }
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
    # { plugin = lsp_signature-vim; config = "require'lsp_signature'.on_attach()"; }
    { plugin = lspkind-nvim; config = "lua require('lspkind').init()"; }
    { plugin = nvim-compe; config = wrapLuaConfig (readFile ./config/nvim-compe-config.lua); }
    { plugin = compe-tabnine; }
    { plugin = nvim-dap-virtual-text; }
    { plugin = nvim-dap; config = import ./config/nvim-dap-config.nix { inherit pkgs; }; }
    { plugin = nvim-blame-line; config = "autocmd BufEnter * EnableBlameLine"; }
    # { plugin = nvim-jdtls; config = ""; }
    { plugin = nvim-lightbulb; config = "autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()"; }
    { plugin = nvim-lspconfig; }
    { plugin = nvim-tree-lua; config = readFile ./config/nvim-tree-lua-config.vim; }
    { plugin = nvim-treesitter-context; }
    { plugin = nvim-treesitter-textobjects; config = readFile ./config/nvim-treesitter-textobjects-config.vim; }
    { plugin = nvim-treesitter; config = wrapLuaConfig (readFile ./config/nvim-treesitter-config.lua); }
    { plugin = nvim-ts-rainbow; }
    { plugin = nvim-ts-autotag; }
    { plugin = nvim-web-devicons; }
    { plugin = plenary-nvim; }
    { plugin = popup-nvim; }
    { plugin = scrollbar-nvim; config = readFile ./config/scrollbar-nvim-config.vim; }
    { plugin = surround; }
    { plugin = tabular; }
    { plugin = telescope-nvim; config = wrapLuaConfig (readFile ./config/telescope-nvim-config.lua); }
    { plugin = pkgs.vimPlugins.telescope-fzy-native-nvim; config = "lua require('telescope').load_extension('fzy_native')"; }
    { plugin = telescope-github-nvim; config = "lua require('telescope').load_extension('gh')"; }
    { plugin = telescope-node-modules-nvim; config = "lua require'telescope'.load_extension('node_modules')"; }
    { plugin = vim-closer; }
    # { plugin = vim-closetag; config = readFile ./config/vim-closetag-config.vim; }
    { plugin = vim-commentary; }
    { plugin = vim-cursorword; }
    { plugin = vim-dadbod-ui; }
    { plugin = vim-dadbod; }
    { plugin = vim-devicons; }
    { plugin = vim-dispatch; }
    { plugin = vim-floaterm; }
    { plugin = vim-hexokinase; config = "let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'"; }
    {
      plugin = vim-import-cost;
      config = ''
        augroup import_cost_auto_run
          autocmd!
          autocmd InsertLeave *.js,*.jsx,*.ts,*.tsx ImportCost
          autocmd BufEnter *.js,*.jsx,*.ts,*.tsx ImportCost
          autocmd CursorHold *.js,*.jsx,*.ts,*.tsx ImportCost
        augroup END
      '';
    }
    { plugin = vim-mundo; config = readFile ./config/mundo-config.vim; }
    { plugin = vim-parinfer; }
    { plugin = vim-polyglot; }
    { plugin = vim-prisma; }
    { plugin = vim-repeat; }
    { plugin = vim-sensible; }
    { plugin = vim-startify; config = readFile ./config/vim-startify-config.vim; }
    { plugin = vim-tmux-navigator; }
    { plugin = vim-vsnip; config = readFile ./config/vim-vsnip-config.vim; }
    { plugin = vim-vsnip-integ; }
    { plugin = vimagit; }
    { plugin = vim-sneak; }
    {
      plugin = vim-which-key;
      config = ''
        let g:mapleader = "\<Space>" 
        let g:maplocalleader = ','
        nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
        nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
      '';
    }
  ];

  configRC = ''
    ${builtins.readFile ./config/init.vim}
  '';

  nnoremap = {

    #NvimTree
    Ctrl-n = ":NvimTreeToggle<CR>";
    "<leader>n" = ":NvimTreeFindFile<CR>";
    # "<leader>r" = ":NvimTreeRefresh<CR>";

    # nvim lsp
    "<F2>" = "<cmd>lua vim.lsp.buf.rename()<CR>";
    "<leader>d" = "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()";
    "<leader>e" = "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>";
    "<leader>f" = "<cmd>lua vim.lsp.buf.formatting()<CR>";
    "<leader>k" = "<cmd>lua vim.lsp.buf.signature_help()<CR>";
    "<leader>q" = "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>";
    "<leader>rn" = "<cmd>lua vim.lsp.buf.rename()<CR>";
    "<leader>wa" = "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>";
    "<leader>wl" = "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>";
    "<leader>wr" = "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>";
    "[d" = "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>";
    "]d" = "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>";
    gi = "<cmd>lua vim.lsp.buf.implementation()<CR>";
    K = "<cmd>lua vim.lsp.buf.hover()<CR>";

    # telescope
    Ctrl-_ = "<cmd>lua require('telescope.builtin').live_grep()<cr>";
    Ctrl-P = "<cmd>lua require('telescope.builtin').find_files()<cr>";
    Ctrl-B = "<cmd>lua require('telescope.builtin').buffers()<cr>";
    gd = "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>";
    gr = "<cmd>lua require('telescope.builtin').lsp_references()<cr>";
    "<leader>a" = "<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>";
    "<leader>t" = "<cmd>Telescope<cr>";
    "<leader>i" = "<cmd>lua require('telescope').extensions.gh.issues()<cr>";
    "<leader>p" = "<cmd>lua require('telescope').extensions.gh.pull_request()<cr>";

    # navigation
    Ctrl-h = "<C-W>h";
    Ctrl-j = "<C-W>j";
    Ctrl-k = "<C-W>k";
    Ctrl-l = "<C-W>l";

    # nvim-dap
    "<F10>" = "lua require'dap'.step_over()<CR>";
    "<F11>" = "lua require'dap'.step_into()<CR>";
    "<F12>" = "lua require'dap'.step_out()<CR>";
    "<F5>" = "lua require'dap'.continue()<CR>";
    "<leader>B" = "lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition:'))<CR>";
    "<leader>b" = "lua require'dap'.toggle_breakpoint()<CR>";
    "<leader>dl" = "lua require'dap'.repl.run_last()<CR>";
    "<leader>dr" = "lua require'dap'.repl.open()<CR>";
    "<leader>lp" = "lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message:'))<CR>";

    #gundo
    "<F3>" = "<cmd>MundoToggle<CR>";

  };

  inoremap = { };

  snoremap = { };

  tnoremap = {
    "<leader>x" = "<Esc> <C-\\><C-n>";
  };
}

{ pkgs
, lib ? pkgs.lib
}:

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
    # { plugin = nvim-autopairs; config = wrapLuaConfig (readFile ./config/nvim-autopairs-config.lua); }
    { /*0*/ plugin = telescope-nvim; config = wrapLuaConfig (readFile ./config/telescope-nvim-config.lua); }
    { /*1*/ plugin = vim-vsnip; }
    { plugin = barbar-nvim; }
    { plugin = blamer-nvim; config = readFile ./config/blamer-nvim-config.vim; }
    # { plugin = copilot-vim; }
    # { plugin = cmp-copilot; }
    { plugin = cmp-buffer; }
    { plugin = cmp-nvim-lsp; }
    { plugin = cmp-path; }
    { plugin = cmp-tabnine; }
    { plugin = cmp-treesitter; }
    { plugin = cmp-vsnip; }
    { plugin = conjure; }
    { plugin = dashboard-nvim; config = readFile ./config/dashboard-nvim-config.vim; }
    { plugin = direnv-vim; config = readFile ./config/direnv-vim-config.vim; }
    { plugin = editorconfig-vim; }
    { plugin = emmet-vim; config = readFile ./config/emmet-vim-config.vim; }
    { plugin = formatter-nvim; config = wrapLuaConfig (import ./config/formatter-nvim-config.nix { inherit pkgs; }); }
    { plugin = friendly-snippets; }
    { plugin = gitsigns-nvim; config = wrapLuaConfig (builtins.readFile ./config/gitsigns-nvim-config.lua); }
    { plugin = gruvbox; config = readFile ./config/theme-config.vim; }
    { plugin = harpoon; config = wrapLuaConfig (readFile ./config/harpoon-config.lua); }
    { plugin = idris2-vim; }
    { plugin = indent-blankline-nvim; config = readFile ./config/indent-blankline-nvim-config.vim; }
    { plugin = lsp_extensions-nvim; }
    { plugin = lsp_signature-nvim; config = "lua require'lsp_signature'.on_attach()"; }
    { plugin = lspkind-nvim; config = "lua require('lspkind').init()"; }
    { plugin = lualine-nvim; config = "lua require('lualine').setup { options = { theme = 'gruvbox' } } "; }
    { plugin = neogit; }
    { plugin = nvim-cmp; config = wrapLuaConfig (readFile ./config/nvim-cmp-config.lua); }
    { plugin = nvim-dap-virtual-text; config = "let g:dap_virtual_text = v:true"; }
    { plugin = nvim-dap; config = wrapLuaConfig (import ./config/nvim-dap-config.nix { inherit pkgs; }); }
    { plugin = nvim-lightbulb; config = "autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()"; }
    { plugin = nvim-lspconfig; }
    { plugin = nvim-scrollview; }
    { plugin = nvim-treesitter-context; }
    { plugin = nvim-treesitter-textobjects; config = readFile ./config/nvim-treesitter-textobjects-config.vim; }
    { plugin = nvim-ts-autotag; }
    { plugin = comment-nvim; config = wrapLuaConfig "require('Comment').setup()"; }
    { plugin = nvim-ts-rainbow; }
    { plugin = nvim-web-devicons; }
    { plugin = octo-nvim; }
    { plugin = pkgs.vimPlugins.nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars); config = wrapLuaConfig (readFile ./config/nvim-treesitter-config.lua); }
    { plugin = pkgs.vimPlugins.telescope-fzy-native-nvim; config = "lua require('telescope').load_extension('fzy_native')"; }
    { plugin = plenary-nvim; }
    { plugin = popup-nvim; }
    { plugin = presence-nvim; config = wrapLuaConfig (readFile ./config/presence-nvim-config.lua); }
    { plugin = sqlite-lua; }
    { plugin = surround; }
    { plugin = tabular; }
    { plugin = telescope-dap-nvim; config = "lua require('telescope').load_extension('dap')"; }
    { plugin = telescope-emoji-nvim; config = "lua require('telescope').load_extension('emoji')"; }
    { plugin = telescope-file-browser-nvim; config = "lua require('telescope').load_extension('file_browser')"; }
    { plugin = telescope-frecency-nvim; config = "lua require('telescope').load_extension('frecency')"; }
    { plugin = telescope-github-nvim; config = "lua require('telescope').load_extension('gh')"; }
    { plugin = telescope-node-modules-nvim; config = "lua require'telescope'.load_extension('node_modules')"; }
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
    { plugin = vim-tmux-navigator; }
    { plugin = which-key-nvim; config = wrapLuaConfig (readFile ./config/which-key-nvim-config.lua); }
  ];

  configRC = ''
    ${wrapLuaConfig (builtins.readFile ./config/init.lua)}
  '';

  nnoremap = {

    # nvim lsp
    "<F2>" = "<cmd>lua vim.lsp.buf.rename()<cr>";
    "[d" = "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>";
    "]d" = "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>";
    gi = "<cmd>lua vim.lsp.buf.implementation()<cr>";
    K = "<cmd>lua vim.lsp.buf.hover()<cr>";

    Ctrl-_ = "<cmd>lua require('telescope.builtin').live_grep({layout_strategy='vertical',layout_config={width=0.9}})<cr>";
    Ctrl-B = "<cmd>lua require('telescope.builtin').buffers()<cr>";
    Ctrl-P = "<cmd>lua require('telescope.builtin').find_files({layout_strategy='vertical',layout_config={width=0.9}})<cr>";
    gd = "<cmd>lua require('telescope.builtin').lsp_definitions({layout_strategy='vertical',layout_config={width=0.9}})<cr>";
    gr = "<cmd>lua require('telescope.builtin').lsp_references({layout_strategy='vertical',layout_config={width=0.9}})<cr>";

    # navigation
    Ctrl-h = "<C-W>h";
    Ctrl-j = "<C-W>j";
    Ctrl-k = "<C-W>k";
    Ctrl-l = "<C-W>l";

    # nvim-dap
    "<F10>" = "<cmd>lua require'dap'.step_over()<cr>";
    "<F11>" = "<cmd>lua require'dap'.step_into()<cr>";
    "<F12>" = "<cmd>lua require'dap'.step_out()<cr>";
    "<F5>" = "<cmd>lua require'dap'.continue()<cr>";

    #Floaterm
    "<leader>hg" = "<cmd>FloatermNew --title=gitui ${pkgs.gitui}/bin/gitui<cr>";
  };

  inoremap = { };

  snoremap = { };

  tnoremap = {
    "<leader>x" = "<Esc> <C-\\><C-n>";
  };
}

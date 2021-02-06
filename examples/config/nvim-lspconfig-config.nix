{ pkgs }:
with pkgs;
let
  lspConfigs = { };

  c_family_setup =
    if pkgs.system == "x86_64-darwin"
    then ''
      lspconfig.sourcekit.setup {
        filetypes = { "swift", "c", "cpp", "objc", "objcpp" }
      }
    ''
    else ''
      lspconfig.ccls.setup {
        cmd = { '${ccls}/bin/ccls' }
      }
    '';

  # TODO
  # '${jdtls}/bin/jdt-language-server'
in
''
  local lspconfig = require'lspconfig'

  lspconfig.bashls.setup {
    cmd = { '${nodePackages.bash-language-server}/bin/bash-language-server', 'start' }
  }

  ${c_family_setup}

  lspconfig.clojure_lsp.setup {
    cmd = { '${clojure-lsp}/bin/clojure-lsp' }
  }

  lspconfig.dockerls.setup {
    cmd = { '${nodePackages.dockerfile-language-server-nodejs}/bin/docker-langserver', '--stdio' }
  }

  lspconfig.gopls.setup {
    cmd = { '${gopls}/bin/gopls' }
  }

  lspconfig.hls.setup {
    cmd = { '${haskellPackages.haskell-language-server}/bin/haskell-language-server', '--lsp' }
  }

  lspconfig.kotlin_language_server.setup {
    cmd = { '${nur.repos.zachcoyle.kotlin-language-server}/bin/kotlin-language-server' }
  }

  lspconfig.metals.setup {
    cmd = { '${metals}/bin/metals' }
  }

  lspconfig.ocamlls.setup { 
    cmd = { '${nodePackages.ocaml-language-server}/bin/ocaml-language-server', '--stdio' }
  }

  lspconfig.pyright.setup { 
    cmd = { '${nodePackages.pyright}/bin/pyright-langserver', '--stdio' }
  }

  lspconfig.rnix.setup {
    cmd = { '${rnix-lsp}/bin/rnix-lsp' }
  }

  lspconfig.solargraph.setup {
    cmd = { '${solargraph}/bin/solargraph', 'stdio' }
  }

  lspconfig.rust_analyzer.setup {
    cmd = { '${rust-analyzer}/bin/rust-analyzer' }
  }

  lspconfig.tsserver.setup {
    cmd = { '${nodePackages.typescript-language-server}/bin/typescript-language-server', '--stdio' },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "json", "jsonc" },
  }

  lspconfig.vimls.setup {
    cmd = { '${nodePackages.vim-language-server}/bin/vim-language-server', '--stdio' }
  }

  lspconfig.yamlls.setup {
    cmd = { '${nodePackages.yaml-language-server}/bin/yaml-language-server', '--stdio' }
  }

  local function preview_location_callback(_, _, result)                                     
    if result == nil or vim.tbl_isempty(result) then                                         
      return nil                                                                             
    end                                                                                        
    vim.lsp.util.preview_location(result[1])                                                 
  end                                                                                        
                                                                                             
  function PeekDefinition()                                                                  
    local params = vim.lsp.util.make_position_params()                                       
    return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
  end

''

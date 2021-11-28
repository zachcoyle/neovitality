{ pkgs }:

with pkgs;
{

  bashls = { };
  clangd = lib.mkIf (system == "x86_64-linux") { };
  clojure_lsp = { };
  dhall_lsp_server = { };
  dockerls = { };
  gopls = { };
  hls = { };
  jdtls = { };
  kotlin_language_server = { };
  metals = { };
  ocamlls = { };
  pyright = { };
  rnix = { };
  rust_analyzer = { };
  solargraph = { };
  sourcekit = lib.mkIf (pkgs.system == "x86_64-darwin") { };
  sumneko_lua = lib.mkIf (pkgs.system == "x86_64-linux") { };
  texlab = { };
  terraformls = { };
  tsserver = { };
  vimls = { };
  yamlls = { };
}

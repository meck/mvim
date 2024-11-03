_: {

  # TODO:
  # - [ ] In Nixvim: https://github.com/Saghen/blink.cmp/commit/708a4a9ba2c9b235ed98cd79bde65aa05b7f32be    
  # - [ ] Add cmp.compat?
  # - [ ] Command line completion

  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap.__raw = "'super-tab'";
      trigger.signature_help.enabled = true;
      completion.show_in_snippet = false;
      highlight.use_nvim_cmp_as_default = true;
      windows = {
        autocomplete.draw = "reversed";
        documentation.auto_show = true;
      };
    };
  };

  plugins.friendly-snippets.enable = true;
}

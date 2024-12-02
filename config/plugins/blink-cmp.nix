_: {

  # TODO:
  # - [ ] In Nixvim: https://github.com/Saghen/blink.cmp/commit/708a4a9ba2c9b235ed98cd79bde65aa05b7f32be    
  # - [ ] Add cmp.compat?
  # - [ ] Command line completion

  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap.preset = "super-tab";
      trigger.signature_help.enabled = true;
      trigger.completion.show_in_snippet = false;
      highlight.use_nvim_cmp_as_default = true;
      windows = {
        autocomplete.draw.columns.__raw = ''{{ "label", "label_description", gap = 1 }, { "kind_icon", "kind" }}'';
        documentation.auto_show = true;
      };
    };
  };

  plugins.friendly-snippets.enable = true;
}

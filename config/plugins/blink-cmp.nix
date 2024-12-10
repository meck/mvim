_: {

  # TODO:
  # - [ ] Add cmp.compat?
  # - [ ] Command line completion

  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap.preset = "super-tab";
      signature.enabled = true;
      completion = {
        documentation.auto_show = true;
        trigger.show_in_snippet = false;
        menu.draw.columns.__raw = ''{{ "label", "label_description", gap = 1 }, { "kind_icon", gap = 1, "kind" }}'';
      };
      appearance.use_nvim_cmp_as_default = true;
    };
  };

  plugins.friendly-snippets.enable = true;
}

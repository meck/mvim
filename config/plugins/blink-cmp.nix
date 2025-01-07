_: {
  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap.preset = "super-tab";
      signature.enabled = true;
      completion = {
        documentation.auto_show = true;
        trigger.show_in_snippet = false;
      };
      appearance = {
        nerd_font_variant = "normal";
        use_nvim_cmp_as_default = true;
      };
    };
  };

  plugins.friendly-snippets.enable = true;
}

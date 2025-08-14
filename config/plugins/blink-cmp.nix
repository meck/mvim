_: {
  plugins.blink-cmp = {
    enable = true;
    settings = {
      fuzzy.prebuilt_binaries.download = false;
      keymap.preset = "super-tab";
      signature.enabled = true;
      completion = {
        documentation.auto_show = true;
        trigger.show_in_snippet = false;
      };
      appearance.nerd_font_variant = "normal";
    };
  };

  plugins.friendly-snippets.enable = true;
}

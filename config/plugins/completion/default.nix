_: {
  plugins = {
    luasnip = {
      enable = true;
      fromLua = [ { paths = ./snippets; } ];
    };

    friendly-snippets.enable = true;

    lspkind = {
      enable = true;
      cmp = {
        enable = true;
        menu = {
          nvim_lsp = "";
          treesitter = "";
          luasnip = "";
          nvim_lua = "";
          conventionalcommits = "󰊢";
          path = "";
          spell = "󰓆";
          buffer = "";
        };
      };
    };

    cmp = {
      enable = true;
      luaConfig.pre = "luasnip = require('luasnip')";
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "treesitter"; }
          { name = "nvim_lua"; }
          { name = "buffer"; }
          { name = "conventionalcommits"; }
          {
            name = "path";
            groupIndex = 1;
          }
          {
            name = "spell";
            groupIndex = 1;
          }
        ];

        mapping = {
          "<CR>" = # lua
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  if luasnip.expandable() then
                    luasnip.expand()
                  else
                    cmp.confirm({
                      select = true,
                    })
                  end
                else
                  fallback()
                end
              end, {"i", "s", "c"})
            '';
          "<Esc>" = # lua
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.abort()
                else
                  fallback()
                end
              end, {'i', 'c'})
            '';
          "<Tab>" = # lua
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.locally_jumpable(1) then
                  luasnip.jump(1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
          "<S-Tab>" = # lua
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
          "<C-Space>" = # lua
            ''cmp.mapping.complete()'';
          "<C-d>" = # lua
            ''cmp.mapping.scroll_docs(-4)'';
          "<C-f>" = # lua
            ''cmp.mapping.scroll_docs(4)'';
        };

        snippet.expand = # lua
          ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
      };

      cmdline = {
        "/" = {
          mapping.__raw = "cmp.mapping.preset.cmdline()";
          formatting.fields = [ "abbr" ];
          sources = [ { name = "buffer"; } ];
        };
        ":" = {
          mapping.__raw = "cmp.mapping.preset.cmdline()";
          formatting.fields = [ "abbr" ];
          sources = [
            { name = "path"; }
            { name = "cmdline"; }
          ];
          matching.disallow_prefix_unmatching = false;
        };
      };
    };
  };
}

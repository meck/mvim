_: {
  plugins = {
    lspkind = {
      enable = true;
      cmp.enable = true;
    };

    luasnip = {
      enable = true;
      fromLua = [{paths = ./snippets;}];
    };

    friendly-snippets.enable = true;

    nvim-cmp = {
      enable = true;

      snippet.expand = "luasnip";

      sources = [
        {name = "nvim_lsp";}
        {name = "nvim_lua";}
        {name = "luasnip";}
        {name = "treesitter";}
        {name = "buffer";}
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
        "<CR>" =
          /*
          lua
          */
          ''cmp.mapping.confirm({ select = true })'';
        "<C-d>" =
          /*
          lua
          */
          ''cmp.mapping.scroll_docs(-4)'';
        "<C-f>" =
          /*
          lua
          */
          ''cmp.mapping.scroll_docs(4)'';
        "<C-Space>" =
          /*
          lua
          */
          ''cmp.mapping.complete()'';
        "<C-e>" =
          /*
          lua
          */
          ''cmp.mapping.abort()'';
        "<Tab>" = {
          action =
            /*
            lua
            */
            ''
              function(fallback)
                local has_words_before = function()
                  unpack = unpack or table.unpack
                  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
                end

                if cmp.visible() then
                  cmp.select_next_item()
                elseif require('luasnip').expand_or_jumpable() then
                  require('luasnip').expand_or_jump()
                elseif has_words_before() then
                  cmp.complete()
                else
                  fallback()
                end
              end
            '';
          modes = [
            "i"
            "s"
          ];
        };
        "<S-Tab>" = {
          action =
            /*
            lua
            */
            ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end
            '';
          modes = ["i" "s"];
        };
      };
    };
    cmp-cmdline.enable = true;
  };
  extraConfigLua = ''
    local cmp = require('cmp')

    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      formatting = {
        fields = { "abbr" },
      },
      sources = {
        { name = 'buffer' }
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      formatting = {
        fields = { "abbr" },
      },
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })

  '';
}

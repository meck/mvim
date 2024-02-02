{
  # TODO: Revisit on nvim 0.10, should have native support
  plugins.nvim-osc52.enable = true;

  extraConfigLua = ''
    local function copy(lines, _)
      require('osc52').copy(table.concat(lines, '\n'))
    end

    local function paste()
      return {vim.fn.split(vim.fn.getreg(""), '\n'), vim.fn.getregtype("")}
    end
    -- If in SSH (without tmux) use this as clipboard provider
    if vim.env.TMUX == nil and vim.env.SSH_CONNECTION ~= nil then
      vim.g.clipboard = {
        name = 'osc52',
        copy = {['+'] = copy, ['*'] = copy},
        paste = {['+'] = paste, ['*'] = paste},
      }
    end
  '';
}

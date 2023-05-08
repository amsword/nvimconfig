return function()
  local _, solarized = pcall(require, "solarized")

  solarized:setup({
    config = {
      theme = "neovim", -- or 'neovim' or 'vscode'
    },
    highlights = function(colors, _darken, _lighten, blend)
      return {
        LineNr = { bg = colors.bg },
        Visual = { fg = colors.cyan, bg = blend(colors.cyan, colors.bg, 0.15) },
        -- NvimTreeNormal = { bg = colors.bg_alt },
        -- NvimTreeNormalNC = { bg = colors.bg_alt },
      }
    end,
  })
end

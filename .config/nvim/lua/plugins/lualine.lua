return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- length = 0 で cwd からの相対パスを省略なしで表示する
      opts.sections.lualine_c[4] = { LazyVim.lualine.pretty_path({ length = 0 }) }
    end,
  },
}

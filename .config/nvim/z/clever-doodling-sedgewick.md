# lualine.nvim でステータスラインに相対パスを表示する

## Context

現在、LazyVim のデフォルト設定で lualine が動作しており、ファイル名の表示に `LazyVim.lualine.pretty_path()` が使われている。
この関数はデフォルトで `length = 3` が設定されており、パスが長い場合は `src/…/components/Button.tsx` のように途中が省略される。
ユーザーは開いているファイルのパスが分かりづらいため、省略なしの相対パスを表示したい。

## 変更内容

`lua/plugins/lualine.lua` を新規作成し、`pretty_path` の `length` オプションを `0`（省略なし）に変更する。

```lua
-- lua/plugins/lualine.lua
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_c[4] = { LazyVim.lualine.pretty_path({ length = 0 }) }
    end,
  },
}
```

### 仕組み

- `pretty_path({ length = 0 })` により、cwd からの相対パスが省略なしで表示される
- `lualine_c[4]` は LazyVim デフォルトで `{ LazyVim.lualine.pretty_path() }` が設定されている箇所（`ui.lua:109`）
- 他のコンポーネント（root_dir, diagnostics, filetype icon）はそのまま維持される

### 対象ファイル

- **新規作成**: `lua/plugins/lualine.lua`
- **参考**: LazyVim デフォルト設定 `~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/ui.lua:97-110`
- **参考**: `pretty_path` 実装 `~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/util/lualine.lua:82-149`

## 検証方法

1. Neovim を再起動（または `:Lazy reload lualine.nvim`）
2. 深い階層のファイルを開いて、ステータスラインに相対パスが省略なしで表示されることを確認

local js_ts_formatters = {
  denols = true,
  ts_ls = true,
  tsserver = true,
  vtsls = true,
}

local function disable_formatting(client)
  if not js_ts_formatters[client.name] then
    return
  end

  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("OxfmtFormatting", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then
            return
          end

          if client.name == "oxfmt" then
            for _, attached_client in ipairs(vim.lsp.get_clients({ bufnr = event.buf })) do
              disable_formatting(attached_client)
            end
          elseif #vim.lsp.get_clients({ bufnr = event.buf, name = "oxfmt" }) > 0 then
            disable_formatting(client)
          end
        end,
      })
    end,
    opts = {
      servers = {
        oxfmt = {
          mason = false,
        },
      },
    },
  },
}

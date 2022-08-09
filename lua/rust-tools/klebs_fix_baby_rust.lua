local utils = require("rust-tools.utils.utils")
local vim = vim

local M = {}

local function get_params()
  local params = vim.lsp.util.make_range_params()
  local range = params.range

  params.range = nil
  params.ranges = { range }

  return params
end

local function handler(_, result, ctx)
  vim.lsp.util.apply_text_edits(
    result,
    ctx.bufnr,
    vim.lsp.get_client_by_id(ctx.client_id).offset_encoding
  )
end

-- Sends the request to rust-analyzer to get the TextEdits to join the lines
-- under the cursor and applies them
function M.klebs_fix_baby_rust()
  utils.request(0, "experimental/klebsFixBabyRust", get_params(), handler)
end

return M


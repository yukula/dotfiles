local folder_icon = require("icons").symbol_kinds.Folder
local separator = " %#WinbarSeparator# "

local M = {}

function M.format_path(path)
  local cwd_tail = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  local rel_path = vim.fn.fnamemodify(path, ":.")

  if rel_path == "." then
    rel_path = ""
  end

  local result = ""
  if cwd_tail ~= "" and cwd_tail ~= "/" then
    result = string.format("%%#WinBarDir#%s %s", folder_icon, cwd_tail)

    if rel_path ~= "" then
      result = result .. "/" .. rel_path
    end
  else
    result = rel_path
  end

  return result
end

--- Window bar that shows the current file path (in a fancy way).
---@return string
function M.render()
  -- Get the path and expand variables.
  local path = vim.fs.normalize(vim.fn.expand("%:p") --[[@as string]])

  -- No special styling for diff views.
  if vim.startswith(path, "diffview") then
    return string.format("%%#Winbar#%s", path)
  end

  -- Replace slashes by arrows.

  local prefix, prefix_path = "", ""

  if vim.startswith(path, vim.fn.getcwd()) then
    path = M.format_path(path)
  end

  -- Remove leading slash.
  path = path:gsub("^/", "")

  return table.concat({
    " ",
    prefix,
    table.concat(
      vim
        .iter(vim.split(path, "/"))
        :map(function(segment)
          return string.format("%%#Winbar#%s", segment)
        end)
        :totable(),
      separator
    ),
  })
end

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("mariasolos/winbar", { clear = true }),
  desc = "Attach winbar",
  callback = function(args)
    if
      not vim.api.nvim_win_get_config(0).zindex -- Not a floating window
      and vim.bo[args.buf].buftype == "" -- Normal buffer
      and vim.api.nvim_buf_get_name(args.buf) ~= "" -- Has a file name
      and not vim.wo[0].diff -- Not in diff mode
    then
      vim.wo.winbar = "%{%v:lua.require'winbar'.render()%}"
    end
  end,
})

return M

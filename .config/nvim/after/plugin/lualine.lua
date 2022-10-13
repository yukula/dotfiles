local function get_file_component()
  local file_path = vim.api.nvim_buf_get_name(0)
  local file_path_parent = vim.fs.dirname(file_path)

  if vim.fn.getcwd() == file_path_parent then
    return vim.fs.basename(file_path)
  end

  --  , 
  return vim.fs.basename(file_path_parent) .. "  " .. vim.fs.basename(file_path)
end

function lspstatus()
  if table.getn(vim.lsp.get_active_clients()) then
    local lsp_name = vim.lsp.get_active_clients()[1].name
    if table.getn(vim.diagnostic.get()) ~= 0 then
      return require('lsp-status').status() 
    else
      return lsp_name
    end
    
  end
end

require'lualine'.setup {
  options = {
    theme = "auto"
  },
  sections = {
    lualine_a = { get_file_component },
    lualine_b = {},
    lualine_c = {},
    lualine_x = { lspstatus },
    lualine_y = {'location'},
    lualine_z = { 'filetype' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}



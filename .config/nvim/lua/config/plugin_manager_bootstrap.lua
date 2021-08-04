local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.notify("> Could not found packer; packer.nvim will be downloaed to: "..install_path, "info", {})
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.notify("> packer.nvim is downloaded", "info", {})
  execute 'packadd packer.nvim'
end

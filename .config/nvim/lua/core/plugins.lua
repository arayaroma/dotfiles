local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- packer plugin
  use 'wbthomason/packer.nvim'

  -- kanagawa colorscheme
  use 'rebelot/kanagawa.nvim'

  -- nvim-tree
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'

  -- nvim-lualine
  use 'nvim-lualine/lualine.nvim'

  -- nvim-treesitter
  use 'nvim-treesitter/nvim-treesitter'

  -- nvim-telescope
  use {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.0',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

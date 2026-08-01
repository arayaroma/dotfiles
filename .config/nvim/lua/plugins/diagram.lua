return {
  {
    '3rd/image.nvim',
    opts = {
      backend = 'kitty',
      max_width_window_percentage = 80,
      max_height_window_percentage = 60,
    },
  },
  {
    '3rd/diagram.nvim',
    dependencies = { '3rd/image.nvim' },
    ft = { 'markdown' },
    opts = {
      renderer_options = {
        mermaid = { background = 'transparent', theme = 'dark', scale = 2 },
      },
    },
  },
}

return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = 'cd app && npm install && git checkout -- yarn.lock',
  keys = {
    { '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Markdown preview (browser)', ft = 'markdown' },
  },
}

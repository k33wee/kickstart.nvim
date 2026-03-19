local media = require 'config.media'

return {
  {
    '3rd/image.nvim',
    build = false,
    event = 'VeryLazy',
    config = function()
      if not media.has_imagemagick() then return end

      local backend = media.image_backend()
      if not backend then return end

      require('image').setup {
        backend = backend,
        processor = 'magick_cli',
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            floating_windows = false,
            filetypes = { 'markdown', 'quarto', 'rmd' },
          },
          html = { enabled = false },
          css = { enabled = false },
        },
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true,
        editor_only_render_when_focused = true,
        hijack_file_patterns = {
          '*.png',
          '*.jpg',
          '*.jpeg',
          '*.gif',
          '*.webp',
          '*.avif',
          '*.svg',
        },
      }
    end,
  },
}

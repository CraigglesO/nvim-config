require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      { 'filename', file_status = true, path = 1 },
      {
        'lsp',
        icon = ' ',
        color = { gui = 'bold' },
        cond = function()
          return next(vim.lsp.buf_get_clients()) ~= nil
        end,
        fmt = function()
          local buf_clients = vim.lsp.buf_get_clients()
          if next(buf_clients) == nil then
            return 'No LSP'
          end
          local client_names = {}
          for _, client in pairs(buf_clients) do
            table.insert(client_names, client.name)
          end
          return table.concat(client_names, ', ')
        end,
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

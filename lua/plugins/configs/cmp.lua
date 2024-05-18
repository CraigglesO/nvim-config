local cmp = require "cmp"

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },

    -- luasnip
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp", priority = 1 },
    { name = 'npm', keyword_length = 4, priority = 5 },
    { name = "crates", priority = 5 },
    { name = "luasnip", priority = 6 },
    { name = "buffer", priority = 7 },
    { name = "nvim_lua", priority = 8 },
    { name = "path", priority = 9 },
    { name = "codeium", priority = 10 },
  },

  sorting = {
    priority_weight = 1.0,
    comparators = {
      -- compare.score_offset, -- not good at all
      cmp.config.compare.locality,
      cmp.config.compare.recently_used,
      cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
      cmp.config.compare.offset,
      cmp.config.compare.order,
      -- compare.scopes, -- what?
      -- compare.sort_text,
      -- compare.exact,
      -- compare.kind,
      -- compare.length, -- useless 
    },
    -- comparators = {
    --   comparators = {
    --     -- compare.score_offset, -- not good at all
    --     compare.locality,
    --     compare.recently_used,
    --     compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
    --     compare.offset,
    --     compare.order,
    --     -- compare.scopes, -- what?
    --     -- compare.sort_text,
    --     -- compare.exact,
    --     -- compare.kind,
    --     -- compare.length, -- useless 
    --   },
    --   cmp.config.compare.offset,
    --   cmp.config.compare.exact,
    --   cmp.config.compare.score,
    --   cmp.config.compare.recently_used,
    --   cmp.config.compare.kind,
    --   cmp.config.compare.sort_text,
    --   cmp.config.compare.length,
    --   cmp.config.compare.order,
    -- },
  },

  window = {
    completion = cmp.config.window.bordered({
      border = 'rounded',
      winhighlight = 'Normal:None,FloatBorder:CmpDocFloatBorder,CursorLine:PmenuSel,Search:None',
      side_padding = 0,
    }),
    documentation = cmp.config.window.bordered({
      border = 'rounded',
      winhighlight = 'Normal:None,FloatBorder:CmpDocFloatBorder,CursorLine:PmenuSel,Search:None',
      side_padding = 0,
    }),
  },

  formatting = {
    format = require('lspkind').cmp_format({
        mode = "symbol",
        maxwidth = 50,
        ellipsis_char = '...',
        symbol_map = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
          Codeium = "",
          crates = "",
          npm = "",
        }
    })
  },
}

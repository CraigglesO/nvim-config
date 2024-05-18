local map = vim.keymap.set

-- Function to toggle inlay hints
local function toggle_inlay_hints()
  -- -- Get the current buffer number
  -- local bufnr = vim.api.nvim_get_current_buf()
  
  -- -- Check if inlay hints are enabled
  -- local inlay_hints_enabled = vim.lsp.inlay_hint(bufnr, { enabled = true })
  
  -- -- Toggle inlay hints
  -- vim.lsp.inlay_hint(bufnr, { enabled = not inlay_hints_enabled })

  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

local function hop_words()
  local hop = require("hop")
  hop.hint_words({ keys = "etovxqpdygfblzhckisuran" })
end

local function gitsignsPreviewHunkInline()
  local gitsigns = require("gitsigns")
  gitsigns.preview_hunk_inline()
end

-- general mappings
map("n", "<C-s>", "<cmd> w <CR>")
map("i", "jk", "<ESC>")
map("n", "<C-c>", "<cmd> %y+ <CR>") -- copy whole filecontent
map("n", "<leader>ih", toggle_inlay_hints, { desc = "Toggle Inlay Hints" })
map("n", "gh", hop_words, { desc = "Easy Motions" })
map('n', '<leader>gp', gitsignsPreviewHunkInline, { desc = "Preview Hunk Inline" })
map('n', '<leader>fw', '<cmd>w<CR>', { desc = 'Save File', silent = true, noremap = true })
map('n', '<leader>fq', '<cmd>q<CR>', { desc = 'Quit File', silent = true, noremap = true })

-- nvimtree
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>")
map("n", "<C-h>", "<cmd> NvimTreeFocus <CR>")

-- telescope
map("n", "<leader>ft", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle NvimTree" })
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
map("n", "<leader>fb", "<cmd> Telescope file_browser <CR>")
map("n", "<leader>fg", "<cmd> Telescope live_grep <CR>")
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>")
map("n", "<leader>cs", "<cmd> Telescope colorscheme <CR>")

-- bufferline, cycle buffers
map("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>")
map("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")
map("n", "<C-q>", "<cmd> bd <CR>")

-- comment.nvim
map("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end)

-- toggle terminal
map("n", "<C-t>", "<cmd>ToggleTerm <CR>")

-- minimap
map("n", "<leader>mm", ":MinimapToggle<CR>", { desc = "Toggle Minimap" })

map("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- format
map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "Format" })

-- precognition
map("n", "<leader>th", function()
  require("precognition").toggle()
end)

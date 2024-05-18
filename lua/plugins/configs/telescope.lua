require("telescope").setup {
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        results_width = 0.5, -- Ratio of the width for the results
        preview_width = 0.5, -- Ratio of the width for the preview
      },
      width = 0.95,
    },
    prompt_prefix = "   ",
  },
}

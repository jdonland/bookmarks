suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(stringr)
})

read_csv("bookmarks.csv", show_col_types = F) |>
  arrange(category, publication_date) |>
  mutate(markdown_link = paste0("- [", title, "](", url, ")"),
         category = paste("\n## ", str_to_title(category)),
         .keep = "none") |>
  group_by(category) |>
  summarize(content = paste0(markdown_link, collapse = "\n")) |>
  mutate(content = paste(category, "\n", content, "\n")) |>
  pull(content) |>
  paste0(collapse = " ") |>
  write_file("README.md")


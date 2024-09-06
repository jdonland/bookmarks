suppressPackageStartupMessages({
  library(readr)
  library(tidyr)
  library(dplyr)
  library(stringr)
})

read_csv("bookmarks.csv", show_col_types = F) |>
  arrange(category, publication_date) |>
  drop_na(title) |>
  mutate(markdown_link = str_c("- [", title, "](", url, ")"),
         category = paste("\n## ", str_to_title(category)),
         .keep = "none") |>
  group_by(category) |>
  summarize(content = str_c(markdown_link, collapse = "\n")) |>
  mutate(content = paste(category, "\n", content, "\n")) |>
  pull(content) |>
  str_c(collapse = " ") |>
  write_file("README.md")

library(tidyverse)

read_csv("bookmarks.csv") |>
  arrange(category, date_added) |>
  mutate(markdown_link = paste0("- [", title, "](", url, ")"),
         category = paste("\n## ", str_to_title(category)),
         .keep = "none") |>
  group_by(category) |>
  summarize(content = paste0(markdown_link, collapse = "\n")) |>
  mutate(content = paste(category, "\n", content, "\n")) |>
  pull(content) |>
  paste0(collapse = " ") |>
  write_file("README.md")

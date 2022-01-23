# rmd be hard

file.copy("./R/wordle_strategy.Rmd",
          "./README.Rmd")

rmarkdown::render(
  "./README.Rmd",
  output_file = "README.md",
  output_dir = here::here(),
  knit_root_dir = here::here()
)

file.remove("./README.Rmd")
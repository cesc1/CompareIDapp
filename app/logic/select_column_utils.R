box::use(
  glue[glue],
  shiny[HTML],
)

show_input_text <- function(data, col_name) {
  if (is.null(col_name)) {
    HTML(
      "<h3>Column selected: <span class = 'text-danger'>None</span></h3>"
    )
  } else {
    HTML(glue("<h3>Column selected: <span class = 'text-success'>{col_name}</span></h3>"))
  }
}

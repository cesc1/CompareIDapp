# File imports
box::use(
  app/view/load_data,
  app/view/select_id,
  app/view/theme[my_theme],
)
# Package imports
box::use(
  shiny[bootstrapPage, moduleServer, NS, tags],
  shiny[observe],
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  bootstrapPage(
    theme = my_theme,
    load_data$ui(ns("load_data")),
    tags$hr(),
    select_id$ui(ns("select_id")),
    tags$hr()
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    data_list <- load_data$server("load_data")
    ids <- select_id$server("select_id", data_list)

    observe({
      print(ids())
    })
  })
}

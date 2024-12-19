# File imports
box::use(
  app/view/load_data,
  app/view/theme[my_theme],
)
# Package imports
box::use(
  shiny[moduleServer, NS, bootstrapPage, tags, HTML],
  #DT[dataTableOutput, renderDataTable],
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  bootstrapPage(
    theme = my_theme,
    load_data$ui(ns("load_data"))
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    data_list <- load_data$server("load_data")
  })
}

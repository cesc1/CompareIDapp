box::use(
  app/logic/select_column_utils[show_input_text],
)
box::use(
  DT[datatable, DTOutput, renderDT],
  shiny[is.reactive, reactive, renderUI, req, uiOutput],
  shiny[moduleServer, NS, tagList, tags],
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(class = "row",
      uiOutput(ns("text")),
    ),
    tags$div(class = "row h-100",
      DTOutput(ns("table"))
    )
  )
}

#' @export
server <- function(id, data) {
  stopifnot(is.reactive(data))

  moduleServer(id, function(input, output, session) {
    output$table <- renderDT({
      req(data())
      datatable(
        data(),
        rownames = FALSE,
        selection = list(mode = "single", target = "column"),
        style = "default",
        options = list(pageLength = 5)
      )
    })

    col_name <- reactive({
      req(data())
      if (is.null(input$table_columns_selected)) {
        col_name <- NULL
      } else { # add 1 because rownames = FALSE, datatable starts idx 0.
        col_name <- colnames(data())[input$table_columns_selected + 1]
      }
    })

    output$text <- renderUI({
      req(data())
      show_input_text(data(), col_name())
    })

    col_name
  })
}

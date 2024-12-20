# File imports
box::use(
  app/view/select_column,
)
# Package imports
box::use(
  compareid[CompareID],
  shiny[actionButton, bindEvent, icon, reactive, req],
  shiny[moduleServer, NS, tagList, tags],
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(class = "container",
      tags$h2(class = "text-center", "Choose the common ID for both tables"),
      tags$div(class = "row",
        tags$div(class = "col-6",
          select_column$ui(ns("select_column1"))
        ),
        tags$div(class = "col-6",
          select_column$ui(ns("select_column2"))
        )
      ),
      tags$div(class = "row justify-content-center",
        tags$div(class = "col-6",
          actionButton(ns("calc_compareid"), "Select IDs",
                       icon = icon("check"))
        )
      )
    )
  )
}

#' @export
server <- function(id, data_list) {
  stopifnot(is.list(data_list))

  moduleServer(id, function(input, output, session) {
    id1 <- select_column$server("select_column1", data_list$data1)
    id2 <- select_column$server("select_column2", data_list$data2)

    compare_id_obj <- reactive({
      req(id1(), id2())
      CompareID$new(
        data_list$data1(),
        data_list$data2(),
        c(id1(), id2())
      )
    }) |>
      bindEvent(input$calc_compareid)

    compare_id_obj
  })
}

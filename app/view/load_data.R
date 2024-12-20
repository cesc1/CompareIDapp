# File imports
box::use(

)
# Package imports
box::use(
  shiny[moduleServer, NS, tagList],
  shiny[tags, fileInput],
  shiny[reactive, req],
  rio[import],
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(class = "container",
      tags$h2(class = "text-center", "Load both datasets"),
      # Extra padding on the top, to offset fileInput extra bottom padding (loading bar)
      tags$div(class = "row justify-content-around m-3 pt-4 bg-light border",
        tags$div(class = "col-5",
          fileInput(ns("data1"), NULL,
                    placeholder = "Select data 1"),
        ),
        tags$div(class = "col-5",
          fileInput(ns("data2"), NULL,
                    placeholder = "Select data 2")
        )
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    data1 <- reactive({
      req(input$data1)
      rio::import(input$data1$datapath)
    })
    data2 <- reactive({
      req(input$data2)
      rio::import(input$data2$datapath)
    })
    list(data1 = data1, 
         data2 = data2)
  })
}
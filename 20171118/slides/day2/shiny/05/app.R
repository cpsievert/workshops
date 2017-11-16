library(shiny)
library(plotly)

ui <- fluidPage(
  plotlyOutput("plot")
)

server <- function(input, output, session) {
  
  y <- c(0, 1)
  
  output$plot <- renderPlotly({
    plot_ly(y = y, x = seq_along(y), mode = "lines", type = "scatter") 
  })
  
  rv <- reactiveValues(
    yt = sum(y), 
    n = length(y)
  )
  
  observe({
    invalidateLater(100, session)
    new_y <- sample(c(-1, 1), 1)
    isolate({
      rv$yt <- rv$yt + new_y
      rv$n <- rv$n + 1
    })
    plotlyProxy("plot", session) %>%
      plotlyProxyInvoke(
        "extendTraces", 
        list(
          y = list(list(rv$yt)), 
          x = list(list(rv$n))
        ), 
        list(0)
      )
  })
  
}

shinyApp(ui, server)
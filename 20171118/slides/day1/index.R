## ---- include = FALSE----------------------------------------------------
#> knitr::opts_chunk$set(
#>   eval = FALSE,
#>   message = FALSE,
#>   comment = "#>",
#>   collapse = TRUE,
#>   fig.width = 10,
#>   fig.height = 4
#> )

## ------------------------------------------------------------------------
#> library(plotly)
#> plot_ly(x = c("A", "B"), y = 1:2)

## ------------------------------------------------------------------------
#> subplot(
#>   plot_ly(x = 1:2, y = 1:2),
#>   plot_ly(x = 1:2, y = 1:2, mode = "lines"),
#>   plot_ly(x = 1:2, y = 1:2, mode = "markers+lines"),
#>   plot_ly(x = 1:2, y = 1:2, text = 1:2, mode = "text"),
#>   plot_ly(x = 1:2, y = 1:2, text = 1:2, mode = "markers+lines+text"),
#>   shareY = TRUE
#> )


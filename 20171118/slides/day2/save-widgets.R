library(plotly)
library(crosstalk)
library(htmltools)

# save widgets under 'index_files' since that doesn't seem configurable in rmarkdown?
options(htmltools.dir.version = FALSE)
save_widget <- function(...) {
  htmlwidgets::saveWidget(..., selfcontained = FALSE, libdir = "index_files")
}
save_html_ <- function(...) {
  htmltools::save_html(..., libdir = "index_files")
}

x <- demo("crosstalk-highlight-pipeline", package = "plotly")
save_widget(x$value, "01-pipeline.html")
x <- demo("crosstalk-highlight-binned-target-a", package = "plotly")
save_widget(x$value, "02-binned-target-a.html")
x <- demo("crosstalk-highlight-binned-target-b", package = "plotly")
save_widget(x$value, "02-binned-target-b.html")
x <- demo("crosstalk-highlight-binned-target-c", package = "plotly")
save_widget(x$value, "02-binned-target-c.html")


tx <- SharedData$new(txhousing)
widgets <- bscols(
  widths = c(12, 12, 12),
  filter_select("city", "Cities", tx, ~city),
  filter_slider("sales", "Sales", tx, ~sales),
  filter_checkbox("year", "Years", tx, ~year, inline = TRUE)
)
save_html_(widgets, "03-filter-widgets.html")

save_html_(bscols(
  widths = c(4, 8), widgets, 
  plot_ly(tx, x = ~date, y = ~median, showlegend = FALSE) %>% 
    add_lines(color = ~city, colors = "black")
), "04-filter.html")


save_html_(source("05-leaflet.R")$value, "05-leaflet.html")

subplot(shareX = TRUE, nrows = 2,
  plot_ly(logs, x = ~date, y = ~package, z = ~count, type = "heatmap"),
  plot_ly(logs, x = ~date, y = ~count, color = ~package, mode = "lines")
)

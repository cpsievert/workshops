subplot(shareY = TRUE,
  plot_ly(x = 1:2, y = 1:2),
  plot_ly(x = 1:2, y = 1:2, mode = "lines"),
  plot_ly(x = 1:2, y = 1:2, mode = "markers+lines"),
  plot_ly(x = 1:2, y = 1:2, text = 1:2, mode = "text"),
  plot_ly(x = 1:2, y = 1:2, text = 1:2, mode = "markers+lines+text")
)

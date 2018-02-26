library(plotly)

nr <- 1000
nc <- 1000
m <- matrix(rnorm(nr*nc), nrow = nr, ncol = nc)
plot_ly(z = m, type = "heatmapgl")
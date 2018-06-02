library(cranlogs)
library(plotly)
library(heatmaply)

# convert data frame to numeric matrix of counts (dates on rows, packages on columns)
dates <- unique(logz$date)
packages <- unique(logz$package)
m <- matrix(logz$count, nrow = length(dates), dimnames = list(dates, packages))

# don't cluster/reorder dates
hm <- heatmaply(m, Rowv = FALSE, plot_method = "plotly")

# fix some plotly layout things
layout(
  hm, 
  yaxis = list(showticklabels = FALSE),
  yaxis2 = list(ticktext = dates),
  margin = list(b = 100, l = 38)
)

# square root is a bit better
sq <- heatmaply(sqrt(m), Rowv = FALSE, plot_method = "plotly")
layout(
  sq, 
  yaxis = list(showticklabels = FALSE),
  yaxis2 = list(ticktext = dates),
  margin = list(b = 100, l = 38)
)


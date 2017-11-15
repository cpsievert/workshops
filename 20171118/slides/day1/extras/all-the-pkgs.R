library(cranlogs)
library(plotly)
library(heatmaply)

pkg_nms <- as.character(installed.packages()[, "Package"])
cran <- unlist(lapply(pkg_nms, function(x) if (!identical("CRAN", packageDescription(x)$Repository)) NULL else x))
logs <- cran_downloads(cran, "last-month")

logs <- get_logs("last-month")

# convert data frame to numeric matrix of counts (dates on rows, packages on columns)
dates <- unique(logs$date)
packages <- unique(logs$package)
m <- matrix(logs$count, nrow = length(dates), dimnames = list(dates, packages))

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

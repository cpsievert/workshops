library(plotly)
library(htmlwidgets)
library(dplyr)

options(htmltools.dir.version = FALSE)

# some 'globals' that these various scripts 
# logs <- cranlogs::cran_downloads(c("plotly", "ggvis", "leaflet", "networkD3", "rbokeh"), "last-month")
# saveRDS(logs, "logs.rds")
logs <- readRDS("logs.rds")

# last months downloads for the installed packages on this machine
# pkg_nms <- as.character(installed.packages()[, "Package"])
# cran <- unlist(lapply(pkg_nms, function(x) if (!identical("CRAN", packageDescription(x)$Repository)) NULL else x))
# logz <- cranlogs::cran_downloads(cran, "last-month")
# saveRDS(logz, "logz.rds")
logz <- readRDS("logz.rds")

tx <- txhousing %>%
  select(city, year, month, median) %>%
  filter(city %in% c("Galveston", "Midland", "Odessa", "South Padre Island"))

rscripts <- Sys.glob("0*.R")
for (i in rscripts) {
  w <- source(i)
  saveWidget(w$value, sub(".R", ".html", i, fixed = TRUE), selfcontained = FALSE, libdir = "index_files")
}
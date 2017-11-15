library(plotly)

# save widgets under 'index_files' since that doesn't seem configurable in rmarkdown?
options(htmltools.dir.version = FALSE)
save_widget <- function(...) {
  htmlwidgets::saveWidget(..., selfcontained = FALSE, libdir = "index_files")
}

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

rscripts <- c(
  "01-simple-bar.R",
  "02-scatter-modes.R",
  "03-heatmap.R",
  "04-lines.R",
  "04-lines-b.R",
  "05-heatmaply.R",
  "06-rangeslider.R",
  "07-webgl.R"
)
for (i in rscripts) {
  w <- source(i)
  save_widget(w$value, sub(".R", ".html", i, fixed = TRUE))
}


library(dplyr)
tx <- txhousing %>%
  select(city, year, month, median) %>%
  filter(city %in% c("Galveston", "Midland", "Odessa", "South Padre Island"))

library(crosstalk)
TX <- SharedData$new(tx, ~year)
p <- ggplot(TX, aes(month, median, group = year)) + geom_line() +
  facet_wrap(~city, ncol = 2)
(gg <- ggplotly(p, tooltip = "year", height = 380, width = 750))

save_widget(gg, "08-small-multiples.html")
save_widget(highlight(gg, "plotly_hover", defaultValues = "2006"), "08-modes.html")
save_widget(highlight(gg, dynamic = TRUE, persistent = TRUE, selectize = TRUE), "08-dynamic.html")

save_widget(highlight(
  gg, dynamic = TRUE, persistent = TRUE, 
  selected = attrs_selected(mode = "markers+lines", marker = list(symbol = "x"))
), "08-custom.html")


p <- ggplot(tx, aes(month, median)) + 
  geom_line(aes(group = year), alpha = 0.2) +
  geom_line(aes(frame = year), color = "red") +
  facet_wrap(~city, ncol = 2) + labs(x = NULL, y = NULL)
gg2 <- ggplotly(p, height = 350, width = 750) %>% animation_opts(600, 500, redraw = FALSE, easing = "linear")
save_widget(gg2, "08-automate.html")

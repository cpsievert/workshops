library(leaflet)
library(crosstalk)
library(plotly)

sd <- SharedData$new(quakes)
stations <- filter_slider("station", "Number of Stations", sd, ~stations)

p <- plot_ly(sd, x = ~depth, y = ~mag) %>% 
  add_markers(alpha = 0.5) %>% 
  highlight("plotly_selected")

map <- leaflet(sd) %>% 
  addTiles() %>% 
  addCircles()

# same map, but with https://plot.ly/r/reference/#scattermapbox
#map <- plot_mapbox(sd, x = ~long, y = ~lat) %>% 
#  add_markers(alpha = 0.5) %>%
#  layout(
#    mapbox = list(
#      zoom = 2,
#      center = list(
#        lon = ~mean(long),
#        lat = ~mean(lat)
#      )
#    )
#  )

tags <- bscols(
  widths = c(6, 6, 3), 
  p, map, stations
)

# write the HTML (& JS/CSS dependencies) to the current working directory
# note that `libdir` is required to render the HTML, so if you want to share 
# plot, you need to share that directory as well
htmltools::save_html(tags, file = "leaflet-your-turn.html", libdir = "html-dependencies")
browseURL("leaflet-your-turn.html")

# if you have just an htmlwidget object, you can inline the JS/CSS dependencies
# inside the HTML, so that 
htmlwidgets::saveWidget(p, "quakes-your-turn.html", selfcontained = TRUE)

# Warning: these files can be very large! You'd be wise to 'share' dependencies 
# like I do in this repo (see the save-widgets.R script)!

# unlink("leaflet-your-turn.html")
# unlink("html_dependencies")
# unlink("quakes-your-turn.html")
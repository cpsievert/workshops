# ---------------------------------------------------------------------------
# Working with actual data
# ---------------------------------------------------------------------------

# Obtain last month's CRAN downloads of some popular int vis packages
library(cranlogs)
logs <- cran_downloads(c("plotly", "ggvis", "leaflet", "networkD3", "rbokeh"), "last-month")
DT::datatable(logs)

# When referencing column(s) in a data frame (e.g., `logs`), 
# you **must** prefix the expression with a tilde `~`
p <- plot_ly(logs, x = ~date, y = ~count)

# add_*() functions make plotly.js look a little more like ggplot2
add_markers(add_boxplot(p))


# %>% (pronounced 'then') allows us to read left-to-right versus inside-out
p %>% 
  add_boxplot() %>% 
  add_markers()


# can always use the more general `add_trace()`...
p %>% 
  add_boxplot() %>% 
  add_trace(type = "violin")


# how to ensure one line *per package*?
p %>% 
  add_paths()


# plotly respects dplyr's data-manipulation verbs
p %>% 
  group_by(package) %>%
  add_paths()


# Use add_lines() over add_paths() 
# if you want your data arranged by x
p %>%
  group_by(package) %>%
  arrange(count) %>%
  add_paths()

# ----------------------------------------------------------------------
# Special arguments (e.g., color/linetype/symbol/size)
# ----------------------------------------------------------------------

# `plot_ly()` has some special arguments that are not a part of `schema()`,
# but make it easier to map data values to visual attributes. These arguments
# are documented on `help(plot_ly)`.
col <- plot_ly(logs, x = ~date, y = ~count, color = ~package)
lty <- plot_ly(logs, x = ~date, y = ~count, linetype = ~package)
sym <- plot_ly(logs, x = ~date, y = ~count, symbol = ~package)


# To specify the visual range, use the plural form of the argument:
add_lines(col, colors = "Set1")
add_lines(lty, linetypes = 6:1)
add_lines(sym, symbols = 10:15)


# For more explicit control, use a named character vector 
colMap <- setNames(viridis::inferno(5), unique(logs$package))
add_lines(col, colors = colMap)


# To avoid scaling altogether, use `I()`
plot_ly(logs, x = ~date, y = ~count, color = I("black"), symbol = I(3))

# -----------------------------------------------------------
# Customizing tooltips and layout options
# -----------------------------------------------------------

col %>%
  add_lines(
    hoverinfo = "text", hoverlabel = list(bgcolor = "white"),
    text = ~paste(count, "downloads")
  ) %>% 
  layout(hovermode = "x")


# any ggplot2 users out there?
gg <- ggplot(logs, aes(x = date, y = count, group = package)) +
  geom_line(aes(text = paste(package, "downloads")))
ggplotly(gg, tooltip = "text")


# ----------------------------------------------------------------------
# 'global' vs 'local' attributes
# ----------------------------------------------------------------------

# attributes set in `plot_ly()` are considered 'global'
plot_ly(logs, x = ~date, y = ~count, color = I("black")) %>%
  add_markers() %>%
  filter(package == "plotly") %>%
  add_lines()

# `plot_ly()` creates a trace only if `type` is specified 
plot_ly(logs, x = ~date, y = ~count, type = "scatter") %>%
  filter(package == "plotly") %>%
  add_lines(color = I("red"))

# ----------------------------------------------------------------------
# Exposing the magic 
# ----------------------------------------------------------------------

# What happens when you print a plotly object?
r <- png::readPNG("day1/demo/printing.png")
plotly_empty() %>%
  layout(
    images = list(
      source = raster2uri(r),
      xref = "paper", 
      yref = "paper", 
      x = 0, y = 0, 
      sizex = 1, sizey = 1, 
      xanchor = "left", yanchor = "bottom"
    )
  )

# Every plotly graph is "seralized" as JSON 
# As far as plotly.js itself is concerned, only three parts are relevant:
# layout, config, and data (a list of traces)
col %>% add_lines() %>% plotly_json()

# Even works with ggplot2! 
# (this is a nice way to learn plotly.js if you already know ggplot2)
gg <- ggplotly(qplot(1:10))
plotly_json(gg)

# plotly objects inherit from htmlwidget class
class(gg)

# so, if you directly `View()` a plotly object, it has some
# htmlwidget specific info attached. The plotly-specific info
# is under 'x'
View(gg)

# what, no `data` attribute?!?
p <- plot_ly(logs, x = ~date, y = ~count)
View(p$x)

# plotly objects are 'built' at print-time
plot_ly()$preRenderHook

# that's better...
View(plotly_build(p)$x$data)


# ----------------------------------------------------------------------
# Your turn:
#  * Compare the `plotly_json()` of these two plots below. What's the key difference?
#  * What are benefits/drawbacks of each approach?
# ----------------------------------------------------------------------

plot_ly(logs, x = ~date, y = ~count) %>%
  group_by(package) %>%
  add_lines(text = ~package, hoverinfo = "x+y+text")

plot_ly(logs, x = ~date, y = ~count, color = ~package) %>%
  add_lines()

# ----------------------------------------------------------------------
# Your turn: 
#   * Be creative! Use a trace type we haven't discussed yet to visualize `logs` 
#   * What visualization we've seen thus far is the best? Why?
# ----------------------------------------------------------------------




# bonus: did someone say animation?
plot_ly(logs, x = ~format(logs$date, "%b %d"), y = ~count, frame = ~package) %>% 
  add_lines() %>%
  animation_opts(1000, 0) %>%
  layout(
    showlegend = FALSE,
    xaxis = list(title = "", tickangle = 45)
  )
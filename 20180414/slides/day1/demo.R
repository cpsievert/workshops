# ---------------------------------------------------------------------------
# Obtain last year's CRAN downloads of some popular int vis packages
# ---------------------------------------------------------------------------

library(cranlogs)
logs <- cran_downloads(
  c("plotly", "ggvis", "leaflet", "networkD3", "rbokeh"), 
  from = "2017-04-13", 
  to = "2018-04-13"
)
DT::datatable(logs)

# ---------------------------------------------------------------------------
# Visualizing that data with plot_ly()
# ---------------------------------------------------------------------------
library(plotly)

# When referencing column(s) in a data frame (e.g., `logs`), 
# you **must** prefix the expression with a tilde `~`
plot_ly(logs, x = ~date, y = ~count)

# Note that you can provide any valid R expression 
plot_ly(logs, x = ~date, y = ~log(count))

# plotly.js has some nice support for rendering interactive log axes
# %>% (pronounced 'then') allows us to read left-to-right versus inside-out
plot_ly(logs, x = ~date, y = ~count) %>%
  layout(yaxis = list(type = "log"))

# 3 ways to specify a trace type (last approach is recommended)
plot_ly(logs, x = ~date, y = ~count, type = "box")
plot_ly(logs, x = ~date, y = ~count) %>% add_trace(type = "box")
plot_ly(logs, x = ~date, y = ~count) %>% add_boxplot()

# `plot_ly()` doesn't create a trace unless `type` is provided
plot_ly(logs, x = ~date, y = ~count, type = "box") %>% add_markers()
plot_ly(logs, x = ~date, y = ~count) %>% add_boxplot() %>% add_markers()

# Put global mappings in `plot_ly()`
plot_ly(logs, x = ~date, y = ~count, boxpoints = FALSE, showlegend = FALSE) %>% 
  add_boxplot() %>% 
  add_markers()


# how to ensure one line *per package*?
plot_ly(logs, x = ~date, y = ~count) %>%
  add_paths()

# plotly adopts dplyr's data-manipulation verbs
plot_ly(logs, x = ~date, y = ~count) %>%
  group_by(package) %>%
  add_paths()

# Note that add_paths() connects rows by order
# Use add_lines() if you want lines to be ordered by x 
plot_ly(logs, x = ~date, y = ~count) %>%
  group_by(package) %>%
  arrange(count) %>%
  add_lines()

# `plotly_data()` retrieves the data associated with a plotly graph
plot_ly(logs, x = ~date, y = ~count) %>% 
  group_by(package) %>%
  arrange(count) %>%
  plotly_data()


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

# hoverinfo controls which attributes are shown in tooltip (defaults to everything)
col %>%
  add_lines(
    hoverinfo = "text", 
    text = ~paste(count, "downloads"),
    hoverlabel = list(bgcolor = "white")
  ) %>% 
  rangeslider() %>%
  layout(hovermode = "x")


# any ggplot2 users out there?
gg <- ggplot(logs, aes(x = date, y = count, group = package)) +
  geom_line(aes(text = paste(package, "downloads")))
ggplotly(gg, tooltip = "text")


# ----------------------------------------------------------------------
# Your turn:
#  * Compare the `plotly_json()` of these two plots below. What's the key difference?
#  * What are benefits/drawbacks of each approach?
# ----------------------------------------------------------------------

plot_ly(logs, x = ~date, y = ~count, color = ~package) %>%
  add_lines()

plot_ly(logs, x = ~date, y = ~count) %>%
  group_by(package) %>%
  add_lines(text = ~package, hoverinfo = "x+y+text") %>%
  slice(which.max(date) - 1) %>%
  # pro tip: use `plotly_data()` to examine the data 
  # attached to the visual at any point in the "pipeline"
  # plotly_data()
  add_annotations(
    text = ~package, x = ~date, y = ~count, 
    ax = ~ifelse(package == "ggvis", -50, 50)
  )  

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
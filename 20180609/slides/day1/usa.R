library(albersusa)
library(plotly)

usa <- usa_sf("laea")

# What's the difference between `p` and `gg`?
p <- ggplot(usa) + geom_sf(aes(fill = pop_2010, text = name))
gg <- ggplotly(p)

# What's the difference between `gg` and `gg2`?
gg2 <- style(gg, hoveron = "fill")

# Run the following code:
plotly_json(gg)
# In the viewer pane, navigate to 'data' -> '1' 
# In plotly terminology, this is called a trace...the data component of a plotly graph is comprised of multiple traces
# What is the value of the "hoveron" trace attribute? Is the same true for `gg2`?


# Run the following code:
schema()
# In the viewer pane, navigate to 'traces' -> 'scatter' -> 'attributes' -> 'hoveron'. 
# What are the acceptable values for this attribute? What does the description say?
# What are acceptable values for the scatter mode attribute?


# Challenges: 
# (1) Change the opacity of the states using `style()`
# (1) Render markers and lines on the state boundaries
style(gg, opacity = 0.1)
style(gg, mode = "markers+lines")

# Homework: **plotly** actually offers 4 different ways to visualize simple features, check out my blog posts:
# http://blog.cpsievert.me/2018/01/30/learning-improving-ggplotly-geom-sf/
# http://blog.cpsievert.me/2018/03/30/visualizing-geo-spatial-data-with-sf-and-plotly/
subplot(
  nrows = 2,
  ggplot(usa) + geom_sf(),
  plot_ly(usa),
  plot_geo(usa),
  plot_mapbox(usa)
)

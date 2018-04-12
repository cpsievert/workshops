# Load the R package plotly
library(plotly)

# Given data, but no "trace type" (i.e., "chart type"), 
# the `plot_ly()` function infers a sensible chart
# (note the message this produces)
plot_ly(x = c("A", "B"), y = 1:2)

# Note the differences in the message/result for these 2:
plot_ly(x = 1:2, y = 1:2)
plot_ly(x = 1:2, y = 1:2, z = 2:1)

# Remember, plot_ly() builds on plotly.js, and you may have seen
# parts of the "plot schema" before on our "figure reference" page
# https://plot.ly/r/reference/

# I often use `schema()` over the online reference because it 
# contains more information (in some cases, default values, 
# min/max, etc) and will always be the correct version.
schema()

# As a matter of fact, the R package uses `schema()` internally
# to throw errors/warning when you've misspecified something
plot_ly(x = 1:2, y = 1:2, type = "invalid")

# ------------------------------------------------------
# Questions for you:
# (1) How many trace types does plotly.js have? 
# (2) Read the description for `traces.scatter.mode`.
#   - Does the default behavior apply to the R package?
#   - Can you make a plot with two (or more) modes (hint: use '+')?
# (3) Can you get rid of the messages in the above examples 
# (by specifying the trace type, etc)?
# ---------------------------------------------------------


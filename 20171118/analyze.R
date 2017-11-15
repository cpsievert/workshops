library(dplyr)
library(tidyr)
library(plotly)
library(htmlwidgets)


d <- read.csv("~/Downloads/plotcon 2018-report.csv") %>% 
  select(matches("How")) %>% 
  select(-5) %>%
  mutate(id = seq_len(nrow(.))) %>%
  gather(variable, value, -id) %>%
  # make the x-axis labels a bit more readable
  mutate(var = sapply(strsplit(variable, "\\."), function(x) x[[length(x)]]))

sd <- crosstalk::SharedData$new(d, ~variable)

options(digits = 2, htmltools.dir.version = FALSE)

p <- ggplot(sd, aes(x = value, fill = variable)) +
  geom_density(alpha = 0.5) + scale_fill_discrete("")

(w <- ggplotly(p, dynamicTicks = TRUE))

withr::with_dir("20171118/slides/day1", {
  htmlwidgets::saveWidget(w, "attendees.html", selfcontained = FALSE, libdir = "index_files")
})

vars <- unique(d$var)
dims <- list()
for (i in seq_along(vars)) {
  dsub <- subset(d, var == vars[[i]])
  vals <- dsub[["value"]]
  dims[[i]] <- list(
    range = c(0, 10),
    label = vars[[i]],
    values = vals
  )
}

(w2 <- plot_ly(type = 'parcoords', dimensions = dims))

withr::with_dir("20171118/slides/day1", {
  htmlwidgets::saveWidget(w2, "attendees2.html", selfcontained = FALSE, libdir = "index_files")
})

# sd2 <- crosstalk::SharedData$new(d, ~id)

# p <- ggplot(sd2, aes(var, value, group = id)) +
#   geom_line() + theme(axis.text.x = element_text(angle = 45)) +
#   xlab(NULL)
# 
# ggplotly(p) %>% 
#   style(hoverinfo = "none") %>% 
#   highlight("plotly_hover")

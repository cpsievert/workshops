library(crosstalk)
SharedData$new(logz, ~package, "Select package(s)") %>% 
  plot_ly(x = ~date, y = ~count) %>% group_by(package) %>% add_lines(alpha=0.3) %>% 
  highlight(dynamic = TRUE, selectize = TRUE, persistent = TRUE)

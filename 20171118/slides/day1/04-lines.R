plot_ly(logz, x = ~date, y = ~count) %>% group_by(package) %>% add_lines(alpha=0.3)

plot_ly(logs, x = ~date, y = ~count) %>% group_by(package) %>% add_lines(alpha=0.3)

TX <- SharedData$new(tx, ~year)
p <- ggplot(TX, aes(month, median, group = year)) + geom_line() +
  facet_wrap(~city, ncol = 2)
(gg <- ggplotly(p, tooltip = "year"))

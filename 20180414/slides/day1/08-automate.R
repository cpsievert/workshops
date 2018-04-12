p <- ggplot(tx, aes(month, median)) + 
  geom_line(aes(group = year), alpha = 0.2) +
  geom_line(aes(frame = year), color = "red") +
  facet_wrap(~city, ncol = 2)
ggplotly(p)

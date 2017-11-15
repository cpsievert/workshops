y <- sample(c(-1, 1), 1e4, TRUE)
x <- seq(Sys.time(), Sys.time() + length(y) - 1, by = "1 sec")
plot_ly(x = x, y = cumsum(y)) %>% add_lines() %>% rangeslider()

library(dplyr)
library(tibble)
library(DT)

f <- list.files()
# all talk directories have format 'YYYYMMDD'
talks <- f[grepl("[0-9]{8}", f)]

# get yaml front matter fields from a given talk
get_yaml <- function(talk, fields = c("title", "venue", "type", "recording")) {
  txt <- readLines(file.path(talk, "index.Rmd"))
  sep <- which(txt == "---")
  front <- txt[seq.int(sep[1] + 1, sep[2] - 1)]
  yml <- yaml::yaml.load(paste(front, collapse = "\n"))
  yml[names(yml) %in% fields]
}
dauto <- talks %>%
  lapply(get_yaml) %>%
  bind_rows() %>%
  mutate(date = talks) %>%
  mutate(title = sprintf(
    '<a href="%s" target="_blank">%s</a>', sprintf("https://workshops.cpsievert.me/%s", date), title
  ))

# other talks that are located elsewhere
dalt <- tibble(
  title = c(
    "<a href='https://bit.ly/plotcon17-webinar' target='_blank'> News and updates surrounding plotly for R </a>",
    "<a href='https://cpsievert.github.io/plotcon17/workshop/day1' target='_blank'> Getting (re)-acquainted with R, RStudio, data wrangling, ggplot2, and plotly</a>",
    "<a href='https://cpsievert.github.io/plotcon17/workshop/day2' target='_blank'> Advanced plotly</a>"
  ),
  venue = c(
    "The internet",
    "Plotcon 2017",
    "Plotcon 2017"
  ),
  type = c(
    "webinar",
    "workshop",
    "workshop"
  ),
  recording = c(
    "<a href='https://vimeo.com/214301880' target='_blank'>here</a>",
    "none",
    "none"
  ),
  date = c(
    "20170412",
    "20170504",
    "20170505"
  )
)

d <- bind_rows(dauto, dalt)

d %>%
  mutate(date = as.Date(date, format = "%Y%m%d")) %>%
  arrange(desc(date)) %>%
  select(date, title, venue, type, recording) %>%
  datatable(escape = F, options = list(pageLength = 50), rownames = FALSE) %>%
  saveWidget(file = "index.html")


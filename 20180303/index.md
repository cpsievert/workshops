---
title: "'plotly for R' workshop"
author: "[Carson Sievert](https://cpsievert.me/)"
date: "Montréal, Canada ❄️ <br /> March 3rd & 4th, 2018"
venue: "Plotly HQ"
recording: "none"
output: 
  tufte::tufte_html:
    keep_md: true
    mathjax: null
    css: main.css
    self_contained: false
---




# About the workshop

This workshop is highly interactive and attendees are expected to participate in hands-on exercises designed to reinforce the lecture material. To participate in the exercises, attendees should bring a laptop and make sure they can open [this RStudio Cloud project](https://rstudio.cloud/project/14090) before the workshop begins.

By the end of this workshop, you will be able to rapidly pose queries about data with interactive web graphics made using [the R package plotly](https://plot.ly/r/). You will also learn about useful [tidyverse](https://www.tidyverse.org/) tools and concepts such as [tidy data](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html), data reshaping data, and the [split-apply-combine technique](https://www.jstatsoft.org/article/view/v040i01). Though it would be beneficial to have some prior knowledge of R and [ggplot2](http://ggplot2.tidyverse.org/), we do not require it, and as such, we avoid assuming pre-existing knowledge as much as possible. Furthermore, this workshop is _not_ designed to make you an R programming expert -- it's designed to get you [doing powerful things quickly](http://varianceexplained.org/r/teach-hard-way/) regardless of your experience with R or programming in general.

## Day 1 outline

* An overview of plotly for R
    * Motivating examples and demos
    * How does it all fit together (htmlwidgets for R, plotly.js, SVG vs WebGL, etc)?
    * Mapping data to visuals (theory and practice)
    * Tips for learning more, debugging, and generally getting "un-stuck"
* Data wrangling for visualization
    * Reshaping with **tidyr**, manipulation with **dplyr**
    * The data-plot-pipeline
* Interactive maps made simple
    * scattermapbox
    * scattergeo
    * **sf** and geom_sf()

## Day 2 outline

* Animations via `plot_ly()` and `ggplotly()`
* Linking multiple views via **crosstalk**
    * Highlighting via direct/indirect manipulation
    * Filtering via indirect manipulation
* Getting the most of out plotly in **shiny**
    * Quick intro to **shiny**
    * Accessing/responding to plotly events in **shiny**
    * Efficient updates via `plotlyProxy()`
* An intro to **dasher** (dash for R)
    * Why **dasher**?
    * Quick overview of dash components
    * **dasher** basics: layout & callbacks

# Code of Conduct

We are committed to providing a welcoming and harassment-free experience for everyone, regardless of gender, gender identity and expression, age, sexual orientation, disability, physical appearance, body size, race, ethnicity, religion (or lack thereof), or technology choices. We do not tolerate harassment of conference participants in any form. Sexual language and imagery is not appropriate for any conference venue, including talks, workshops, parties, Twitter and other online media. Participants violating these rules may be sanctioned or expelled from the event at the discretion of the organizers.

This code of conduct applies to all participants, including the organizers and applies to all modes of interaction, both in-person and online, including the Slack channel and Twitter.

Workshop participants agree to:

* Be considerate in speech and actions, and actively seek to acknowledge and respect the boundaries of fellow attendees.

* Refrain from demeaning, discriminatory, or harassing behavior and speech. Harassment includes, but is not limited to: deliberate intimidation; stalking; unwanted photography or recording; sustained or willful disruption of talks or other events; inappropriate physical contact; use of sexual or discriminatory imagery, comments, or jokes; and unwelcome sexual attention. If you feel that someone has harassed you or otherwise treated you inappropriately, please alert any member of the conference team in person.

* Take care of each other. Alert a member of the conference team if you notice a dangerous situation, someone in distress, or violations of this code of conduct, even if they seem inconsequential.

## Need Help?

<b>Please contact [Carson Sievert](mailto:cpsievert1@gmail.com) if you have any concerns.</b>

If any attendee engages in harassing behavior, the workshop organizers may take any lawful action we deem appropriate, including but not limited to warning the offender or asking the offender to leave the workshop. (If you feel you have been unfairly accused of violating this code of conduct, you should contact the workshop team with a concise description of your grievance.)

We welcome your feedback on this event, and thank you for working with us to make it a safe, enjoyable, and friendly experience for everyone who participates.

Parts of above text is licensed CC BY-SA 4.0. Credit to [SRCCON](https://srccon.org) and [rOpenSci](http://textworkshop17.ropensci.org/).

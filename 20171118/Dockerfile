From rocker/geospatial:latest
Maintainer "Carson Sievert" cpsievert1@gmail.com

# update/install system dependencies, update R packages
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
  libprotobuf-dev protobuf-compiler \
  && Rscript -e "update.packages(ask=FALSE)"
  
# Install R packages (doing this one-by-one helps leverage caching)
RUN R -e "install.packages('plotly')"
RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('rmarkdown')"
RUN R -e "install.packages('crosstalk')"

RUN R -e "install.packages('sf')"
RUN R -e "install.packages('leaflet')"

# currently need dev version of ggplot2 to work well with plotly
RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_github('tidyverse/ggplot2')"

# copy over workshop materials
COPY slides /home/rstudio
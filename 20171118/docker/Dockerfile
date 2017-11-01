From rocker/geospatial:latest
Maintainer "Carson Sievert" cpsievert1@gmail.com

COPY sources.list /etc/apt/
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
  libprotobuf-dev protobuf-compiler \
  && Rscript -e "update.packages(ask=FALSE); devtools::install_github('cpsievert/workshops/20171018')"
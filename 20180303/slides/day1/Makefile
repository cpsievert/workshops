all: save index

save:
	Rscript save-widgets.R
  
index:
	Rscript -e "options(htmltools.dir.version = FALSE); rmarkdown::render('index.Rmd')"
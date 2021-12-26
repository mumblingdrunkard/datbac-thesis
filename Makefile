pdf:
	R -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_document2', config_file='_bookdown.yml')"

pdf-final: # two passes to include glossary
	R -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_document2', config_file='_bookdown.yml')"
	makeglossaries _main
	R -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_document2', config_file='_bookdown.yml')"

html:
	R -e "bookdown::render_book('index.Rmd', 'bookdown::html_document2', config_file='_bookdown.yml')"

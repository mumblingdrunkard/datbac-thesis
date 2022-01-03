pdf:
	R -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_document2', config_file='_bookdown.yml')"
	rm _main.*

pdf-final: # two passes to include glossary
	R -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_document2', config_file='_bookdown.yml')"
	makeglossaries _main
	R -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_document2', config_file='_bookdown.yml')"
	rm _main.*

html:
	R -e "bookdown::render_book('index.Rmd', 'bookdown::html_document2', config_file='_bookdown.yml')"

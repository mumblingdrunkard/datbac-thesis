pdf:
	OPENSSL_CONF=/dev/null R -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_document2', config_file='_bookdown.yml')"
	rm _main.*

pdf-final: # two passes to include glossary
	OPENSSL_CONF=/dev/null R -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_document2', config_file='_bookdown.yml')"
	makeglossaries _main
	OPENSSL_CONF=/dev/null R -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_document2', config_file='_bookdown.yml')"
	rm _main.*

html:
	OPENSSL_CONF=/dev/null R -e "bookdown::render_book('index.Rmd', 'bookdown::html_document2', config_file='_bookdown.yml')"

docker-image:
	docker build . --tag tmp --build-arg GITHUB_TOKEN=${GITHUB_TOKEN}

FROM fedora:35
RUN dnf update --refresh -y
RUN dnf install texlive-scheme-full pandoc R libcurl make -y

RUN R -e "install.packages('rmarkdown', repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('bookdown', repos='http://cran.us.r-project.org')"

WORKDIR /doc
COPY . .

RUN make pdf-final
CMD cat output/_main.pdf

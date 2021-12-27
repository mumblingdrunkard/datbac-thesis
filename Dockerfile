FROM fedora:35
RUN dnf update --refresh -y
RUN dnf install texlive-scheme-full pandoc R libcurl make -y
RUN dnf install libcurl-devel -y
RUN dnf install openssl -y
RUN dnf install openssl-devel -y


RUN R -e "install.packages(c('rmarkdown', 'bookdown', 'httr', 'kableExtra'), repos='https://cloud.r-project.org/')"

WORKDIR /doc
COPY . .

RUN make pdf-final
CMD cat output/_main.pdf

# NOTE: Should probably be using something more stable than fedora, but I couldn't get Ubuntu to work.
FROM fedora:35
RUN dnf update --refresh -y
RUN dnf install pandoc R libcurl make -y
RUN dnf install texlive \
                texlive-titling \
                texlive-multirow \
                texlive-wrapfig \
                texlive-threeparttable \
                texlive-threeparttablex \
                texlive-ulem \
                texlive-makecell \
                texlive-tabu \
                texlive-biblatex-ieee \
                texlive-floatrow \
                texlive-preprint \
                texlive-glossaries
RUN dnf install libcurl-devel -y
RUN dnf install openssl -y
RUN dnf install openssl-devel -y

RUN R -e "install.packages(                           \
                c('DiagrammeR',                       \
                  'webshot',                          \
                  'rmarkdown',                        \
                  'bookdown',                         \
                  'httr',                             \
                  'kableExtra',                       \
                  'remotes',                          \
                  'tufte'),                           \
                repos='https://cloud.r-project.org/')"

RUN R -e "remotes::install_github('yihui/knitr')"

RUN dnf install bzip2 -y

RUN R -e "webshot::install_phantomjs()"

ARG GITHUB_TOKEN

WORKDIR /doc

ENV OPENSSL_CONF=/dev/null

# TODO figure out how to get
CMD git clone https://${GITHUB_TOKEN}@github.com/mumblingdrunkard/datbac-thesis && \
    cd datbac-thesis && git pull && make pdf-w-glossaries

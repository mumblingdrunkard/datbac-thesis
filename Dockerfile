# NOTE: Should probably be using something more stable than fedora, but I couldn't get Ubuntu to work.
FROM fedora:35
RUN dnf update --refresh -y
RUN dnf install texlive-scheme-full pandoc R libcurl make -y
RUN dnf install libcurl-devel -y
RUN dnf install openssl -y
RUN dnf install openssl-devel -y

# for microsoft fonts
RUN dnf install curl cabextract xorg-x11-font-utils fontconfig -y
RUN rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

RUN R -e "install.packages(c('DiagrammeR', 'webshot', 'rmarkdown', 'bookdown', 'httr', 'kableExtra', 'tufte'), repos='https://cloud.r-project.org/')"

RUN dnf install bzip2 -y

RUN R -e "webshot::install_phantomjs()"

ARG GITHUB_TOKEN

WORKDIR /doc

ENV GITHUB_TOKEN=$GITHUB_TOKEN
RUN echo ${GITHUB_TOKEN}

RUN git clone https://${GITHUB_TOKEN}@github.com/mumblingdrunkard/datbac-thesis

RUN ls -a

CMD ls -a
CMD cd datbac-thesis && git pull && make pdf-final
#CMD ls datbac-thesis/output

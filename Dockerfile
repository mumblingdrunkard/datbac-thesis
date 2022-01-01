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

RUN R -e "install.packages(c('rmarkdown', 'bookdown', 'httr', 'kableExtra'), repos='https://cloud.r-project.org/')"

WORKDIR /doc
COPY . .

RUN make pdf-final
CMD cat output/_main.pdf

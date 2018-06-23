FROM fedora:latest
LABEL maintainer "Ege Gunes <egegunes@gmail.com>"

RUN dnf install -y hugo
RUN useradd -Ums /bin/bash egegunes
USER egegunes
CMD ["hugo", "--help"]

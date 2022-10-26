FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update &&\
    apt install -y g++ bash vim make bison flex build-essential pkgconf \
		libgtest-dev doxygen graphviz cloc doxygen graphviz       				  \
		texlive-latex-base texlive-latex-extra cloc inotify-tools

WORKDIR /home/tang

ENTRYPOINT ["/bin/bash"]

FROM node:6.5

MAINTAINER Antoine Snyers

ENV DEBIAN_FRONTEND noninteractive 
RUN apt-get update > /dev/null && \
apt-get install -y git-all && \
apt-get install -y vim-nox git-core curl silversearcher-ag && \
apt-get install -y build-essential cmake python-dev python3-dev

COPY vimrc /home/developer/.vimrc
COPY vim /home/developer/.vim

RUN cd /home/developer && \
# fzf
      git clone --depth 1 https://github.com/junegunn/fzf.git .fzf && \
      .fzf/install && \
# ag
      ln -s /usr/bin/ag /usr/local/bin/ag && \
# vimproc
      cd /home/developer/.vim/bundle/vimproc.vim && make && \
# YouCompleteMe
      npm install -g typescript && \
      cd /home/developer/.vim/bundle/YouCompleteMe && \ 
      ./install.py --tern-completer 

ENV HOME /home/developer
WORKDIR /home/developer/workspace
ENTRYPOINT ["vim"]

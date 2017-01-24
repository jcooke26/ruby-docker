FROM ubuntu:latest

# install everything into /opt and as user root
WORKDIR /opt
USER root

# add the user "seh" for later
RUN useradd -m -s /bin/bash seh
RUN apt-get update && apt-get -y install sudo
RUN echo "seh ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# install tmux as a viewer
RUN apt-get update && apt-get -y install tmux wget git

USER seh
WORKDIR /home/seh
RUN git clone git://github.com/sstephenson/rbenv.git .rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> .bashrc
RUN echo 'eval "$(rbenv init -)"' >> .bashrc
RUN exec $SHELL

RUN git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

git clone git://github.com/dcarley/rbenv-sudo.git ~/.rbenv/plugins/rbenv-sudo

exec $SHELL

RUBYVERSION=$(wget https://raw.githubusercontent.com/rapid7/metasploit-framework/master/.ruby-version -q -O - )
rbenv install $RUBYVERSION
rbenv global $RUBYVERSION
ruby -v

CMD tmux new -t ruby-docker
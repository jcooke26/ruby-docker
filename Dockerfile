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

RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import
RUN curl -L https://get.rvm.io | bash -s stable 
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.3.1"
RUN /bin/bash -l -c "rvm use 2.3.1 --default"
RUN /bin/bash -l -c "source /usr/local/rvm/scripts/rvm"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN /bin/bash -l -c "source /usr/local/rvm/scripts/rvm && which bundle"
RUN /bin/bash -l -c "which bundle"


CMD tmux new -s ruby-docker
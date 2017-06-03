FROM ubuntu:17.04

ENV DEBIAN_FRONTEND noninteractive
ENV USER root

# Install tools
RUN \
  apt-get update && apt-get install -y sudo mc curl maven git postgresql-9.6 && \
  apt-get install -y ubuntu-gnome-desktop xterm --no-install-recommends

# Install Node.js
RUN \
  curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  apt-get update && apt-get install -y nodejs

# Install Oralcle Java
RUN \
  apt-get update && apt-get install -y --no-install-recommends apt-utils && \
  apt-get install -y software-properties-common && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install Idea IntelliJ
RUN \
  curl -fSL "https://download.jetbrains.com/idea/ideaIU-2017.1.3.tar.gz" -o /tmp/idea.tar.gz && \
  cd /opt/ && tar zxf /tmp/idea.tar.gz && rm /tmp/idea.tar.gz && \
  ln -s /opt/idea-IU* /opt/idea && \
  ln -s /opt/idea/bin/idea.sh /usr/bin/idea

# Install Visual Studio Code
RUN \
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
  mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \
  sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
  apt-get update && apt-get install -y code

# Install Chrome
RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -  && \
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
  apt-get update && apt-get install -y google-chrome-stable && \
  rm -rf /var/lib/apt/lists/*

# Install VNC Server
RUN \
  apt-get update && apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal && \
  apt-get install -y tightvncserver

# Add developer user
RUN \
  useradd -ms /bin/bash developer && \
  echo "developer:developer" | chpasswd && adduser developer sudo

USER developer
WORKDIR /home/developer  

# Download Tomcat
RUN \
  wget "http://ftp.ps.pl/pub/apache/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz"

# Setup VNC Server
RUN \
  mkdir .vnc && \
  touch .Xresources

ADD xstartup /home/developer/.vnc/xstartup
ADD passwd /home/developer/.vnc/passwd

USER root

RUN \
  chmod 600 /home/developer/.vnc/passwd && \
  chown developer:developer /home/developer/.vnc/passwd &&\
  sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1

USER developer

CMD /usr/bin/vncserver :1 -geometry ${g:-1920x1080} -depth 24 && tail -f /home/developer/.vnc/*:1.log

EXPOSE 5901 8080-8100

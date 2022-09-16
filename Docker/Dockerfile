#
# Dockerized environment to run the Yocto build in
#
FROM debian:stretch-slim as yocto-stretch-base

# WORKAROUND problem with openjdk-*-jre-headless install
#RUN mkdir /usr/share/man/man1

# Install any needed packages for the base environment
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated \
    bash \
    locales \
    locales-all \
    screen \
    ncurses-dev

# Required by Yocto (per: https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#ubuntu-packages).
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated \
    git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
    pylint3 xterm python3-wget nano nfs-kernel-server bison flex 

# Plus these that the Yocto build seems to need when you run it.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated \
    gawk wget rsync

# Packages to enable a usable development environment
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated \
    yapf vim jq

# Ensure the locale is set properly
RUN DEBIAN_FRONTEND=noninteractive update-locale 
RUN DEBIAN_FRONTEND=noninteractive update-locale "LANG=en_US.UTF-8"
RUN DEBIAN_FRONTEND=noninteractive locale-gen --purge "en_US.UTF-8"
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Force /bin/sh to be bash
RUN ln -sf /bin/bash /bin/sh

############################################################################################################

# The final pieces of image required to enable in container development (note this is before Jenkins since
# the Jenkins container takes some command line parameters we don't care about....)
FROM yocto-stretch-base as yocto-stretch-dev

##### Stonefly-esque Addons
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo

# Causes the default bash prompt to indicate that we are inside the container.
RUN echo 'yocto-stretch-dev' > /etc/debian_chroot

# Create a group in the container that the user who has logged in can join
RUN groupadd yocto

# Install startup script
COPY start.sh /opt
RUN chmod +x /opt/start.sh
ENTRYPOINT ["/opt/start.sh"]

############################################################################################################

# The final pieces of image required for the pipeline on Jenkins (to be reintegrated at a future date)
FROM yocto-buster-base as yocto-buster-jenkins-pipeline

# The following are to be provided at build time using '--build-arg <name>=<value>'.
ARG userid
ARG groupid

# Add the 'biamp' user to the image since build scripts expect it to exist.
RUN useradd biamp

# Add the jenkins user using the user and group ID provided at build time since the source code is mounted in as a volume owned by jenkins
RUN groupadd -g $groupid jenkins
RUN useradd -m -d /home/jenkins -u $userid -g $groupid jenkins

# Create locations for Yocto caches
RUN mkdir -p /var/cache/yocto/download/
RUN mkdir -p /var/cache/yocto/sstate/
RUN mkdir -p /var/cache/yocto/global/sstate/

# Default to this user.
USER jenkins

# Create a volume for SSH keys.
VOLUME /home/jenkins/.ssh

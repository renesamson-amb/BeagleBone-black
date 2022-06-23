#!/bin/bash
#
# Duplicates the username, UID and GID of the user who started the
# container so that an equivalent user exists inside the container itself.
# This allows the user's home directory, which is bind-mounted inside the
# container, to be properly accessed without permission errors.

# Determine the user's UID and GID
passwdline=`cat /opt/host/etc/passwd | grep "^$USER:"`
uid=`echo $passwdline | cut -f3 -d':'`
gid=`echo $passwdline | cut -f4 -d':'`

# Create a group with the same primary GID and name as the user who started the container.
groupadd -g ${gid} ${USER}

# Create a user with the same UID and name as the user who started the container.
useradd -u ${uid} -g ${USER} -G yocto,sudo -s /bin/bash --home-dir ${HOME} ${USER}

# Create the /dev/loop0 device node if it doesn't already exist.  Needed for
# creation of flash images in the Linux/Yocto development container.
if [ ! -b /dev/loop0 ]; then
  mknod /dev/loop0 b 7 0
fi

# Set the user's password to be the same as their username.
echo "${USER}:${USER}" | chpasswd 

# Redirect the download cache to the developer's home folder via the /mnt based point used by the Jenkins build
sudo mkdir -p "/var/cache/yocto/"
sudo chown ${USER}:${USER} -R "/var/cache/yocto/"
mkdir -p "${HOME}/.yocto-cache/downloads"
sudo chown ${USER}:${USER} -R "${HOME}/.yocto-cache/downloads"
sudo ln -s "${HOME}/.yocto-cache/downloads" "/var/cache/yocto/downloads" 
# Redirect the sstate cache to the developer's home folder via the /mnt based point used by the Jenkins build
mkdir -p "${HOME}/.yocto-cache/sstate"
sudo chown ${USER}:${USER} -R "${HOME}/.yocto-cache/sstate"
sudo ln -s "${HOME}/.yocto-cache/sstate" "/var/cache/yocto/sstate" 

cd $WORKING_DIR

BASH_RC_FILE="/home/${USER}/.bashrc"

# The duplication here is due to the need to quote "$*", as quotes cannot be easily stored inside a variable.
# The BIAMP_CONTAINER variable allows scripts to determine whether they are running inside the container.
if [ $# -gt 0 ]; then
  exec sudo  --user=${USER} env "PATH=${PATH}" "VIRTUAL_ENV=${VIRTUAL_ENV}" "BIAMP_CONTAINER=true" "BIAMP_BITBUCKET_URL=${BIAMP_BITBUCKET_URL}" /bin/bash --rcfile ${BASH_RC_FILE} -c "$*"
else
  exec sudo  --user=${USER} env "PATH=${PATH}" "VIRTUAL_ENV=${VIRTUAL_ENV}" "BIAMP_CONTAINER=true" "BIAMP_BITBUCKET_URL=${BIAMP_BITBUCKET_URL}" /bin/bash --rcfile ${BASH_RC_FILE}
fi

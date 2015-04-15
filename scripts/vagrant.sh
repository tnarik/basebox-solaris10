#!/bin/sh

VAGRANTUSER='vagrant'

## Tag version
date > /etc/vagrant_box_build_time

# Add 'vagrant' to sudoers as well
test -f /etc/sudoers && grep -v "vagrant" "/etc/sudoers" 1>/dev/null 2>&1 && echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Installing vagrant keys
mkdir ${HOME}/.ssh
chmod 700 ${HOME}/.ssh
cd ${HOME}/.ssh
/opt/csw/bin/wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chown -R ${VAGRANTUSER}:${VAGRANTUSER} ${HOME}/.ssh


#Let's try to get the JDS desktop by default
mkdir -p ${HOME}/.dt
echo "/usr/dt/config/Xsession.jds" > ${HOME}/.dt/lastsession

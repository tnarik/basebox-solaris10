#!/bin/sh

## Add the opencsw package site
PATH=/usr/bin:/usr/sbin:$PATH
export PATH

yes|/usr/sbin/pkgadd -d http://mirror.opencsw.org/opencsw/pkgutil-`uname -p`.pkg all
/opt/csw/bin/pkgutil -U

# get 'sudo'
/opt/csw/bin/pkgutil -y -i CSWsudo
chgrp 0 /etc/opt/csw/sudoers
ln -s /etc/opt/csw/sudoers /etc/sudoers
# get 'wget', 'GNU tar' and 'GNU sed' (also needed for Ruby)
/opt/csw/bin/pkgutil -y -i CSWwget CSWgtar CSWgsed

# Add 'vagrant' to sudoers as well
test -f /etc/sudoers && grep -v "vagrant" "/etc/sudoers" 1>/dev/null 2>&1 && echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Speed up SSH by disabling DNS checks for clients
echo "LookupClientHostnames=no" >> /etc/ssh/sshd_config


## Useful tools
/opt/csw/bin/pkgutil -y -i CSWgsed CSWtree CSWggrep CSWgedit
#/opt/csw/bin/pkgutil -y -i CSWruby19-gcc4 CSWruby19-dev CSWruby19
#/opt/csw/bin/pkgutil -y -i CSWrubygems


#/opt/csw/bin/pkgutil -y -i CSWreadline
#/opt/csw/bin/pkgutil -y -i CSWzlib
#/opt/csw/bin/pkgutil -y -i CSWossldevel
#
## no solaris2.11 .... mkheaders here ! needs some fixing ??
## /opt/csw/gcc4/libexec/gcc/i386-pc-solaris2.10/4.3.3/install-tools/mkheaders
#/opt/csw/gcc4/libexec/gcc/i386-pc-solaris2.8/4.3.3/install-tools/mkheaders 
#
#/opt/csw/sbin/alternatives --display rbconfig18
#/opt/csw/sbin/alternatives --set rbconfig18 /opt/csw/lib/ruby/1.8/i386-solaris2.9/rbconfig.rb.gcc4


## Fix the shells to include the /opt/csw and /usr/xpg4 directories
/opt/csw/bin/gsed -i -e 's#^\#PATH=.*$#PATH=/opt/csw/bin:/usr/xpg4/bin:/usr/sbin:/usr/bin:/usr/ucb#g' \
    -e 's#^\#SUPATH=.*$#SUPATH=/opt/csw/bin:/usr/xpg4/bin:/usr/sbin:/usr/bin:/usr/ucb#g' /etc/default/login
/opt/csw/bin/gsed -i -e 's#^\#PATH=.*$#PATH=/opt/csw/bin:/usr/xpg4/bin:/usr/sbin:/usr/bin:/usr/ucb#g' \
    -e 's#^\#SUPATH=.*$#SUPATH=/opt/csw/bin:/usr/xpg4/bin:/usr/sbin:/usr/bin:/usr/ucb#g' /etc/default/su



## Add the CSW libraries to the LD path
/usr/bin/crle -u -l /opt/csw/lib

## Add loghost to /etc/hosts
/opt/csw/bin/gsed -i -e 's/localhost/localhost loghost/g' /etc/hosts

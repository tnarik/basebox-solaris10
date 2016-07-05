case "$PACKER_BUILDER_TYPE" in 
virtualbox*)
  # Installing the virtualbox guest additions
  mkdir /tmp/vboxguest_mnt
  mount -F hsfs -o ro `lofiadm -a ${HOME}/VBoxGuestAdditions.iso` /tmp/vboxguest_mnt
  /usr/bin/pkgtrans /tmp/vboxguest_mnt/VBoxSolarisAdditions.pkg /tmp all
  yes|/usr/sbin/pkgadd -d . SUNWvboxguest
  
  umount /tmp/vboxguest_mnt
  lofiadm -d ${HOME}/VBoxGuestAdditions.iso
  rm -rf ${HOME}/VBoxGuestAdditions.iso
  ;;
vmware*)
  mkdir /tmp/vmwaretools_mnt
  mount -F hsfs -o ro `lofiadm -a ${HOME}/VMWareTools.iso` /tmp/vmwaretools_mnt

  mkdir /tmp/vmwaretools_tmp
  cd /tmp/vmwaretools_tmp
  gunzip -c /tmp/vmwaretools_mnt/vmware-solaris-tools.tar.gz | tar xf -
  # Fix for some versions of VMware as per http://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=2057912 (2057912)
  /opt/csw/bin/gsed -i -e 's#!/bin/sh#!/bin/bash#g' ./vmware-tools-distrib/installer/services.sh
  # Continue installation
  ./vmware-tools-distrib/vmware-install.pl -d
  
  cd /
  umount /tmp/vmwaretools_mnt
  lofiadm -d ${HOME}/VMWareTools.iso
  rm -rf ${HOME}/VMWareTools.iso
  rm -rf /tmp/vmwaretools_tmp
  ;;
parallels*)
  # Not supported
  ;;
esac
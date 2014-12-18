case "$PACKER_BUILDER_TYPE" in 
virtualbox*)
  # Installing the virtualbox guest additions
  cd /tmp
  mkdir vboxguestmnt
  mount -F hsfs -o ro `lofiadm -a /export/home/vagrant/VBoxGuestAdditions.iso` /tmp/vboxguestmnt
  /usr/bin/pkgtrans /tmp/vboxguestmnt/VBoxSolarisAdditions.pkg /tmp all
  yes|/usr/sbin/pkgadd -d . SUNWvboxguest
  
  umount /tmp/vboxguestmnt
  lofiadm -d /export/home/vagrant/VBoxGuestAdditions.iso
  rm -rf /export/home/vagrant/VBoxGuestAdditions.iso
  ;;
vmware*)
  cd /tmp
  mkdir vmwaretoolsmnt
  mount -F hsfs -o ro `lofiadm -a /export/home/vagrant/VMWareTools.iso` /tmp/vmwaretoolsmnt
  gunzip -c /tmp/vmwaretoolsmnt/vmware-solaris-tools.tar.gz | tar xf -
  # Fix for some versions of VMware as per http://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=2057912 (2057912)
  /opt/csw/bin/gsed -i -e 's#!/bin/sh#!/bin/bash#g' ./vmware-tools-distrib/installer/services.sh
  # Continue installation
  ./vmware-tools-distrib/vmware-install.pl -d
  
  umount /tmp/vmwaretoolsmnt
  lofiadm -d /export/home/vagrant/VMWareTools.iso
  rm -rf /export/home/vagrant/VMWareTools.iso
  rm -rf vmware-tools-distrib
  ;;
parallels*)
  # Not supported
  ;;
esac
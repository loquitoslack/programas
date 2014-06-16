#!/bin/sh
rsync -avrt rsync://mirrors.kernel.org/centos/6/updates/x86_64/ --exclude=debug/ /var/spool/apt-mirror/mirror/centos/6/updates/x86_64/ > /dev/null
rsync -avrt rsync://mirrors.kernel.org/centos/6/updates/i386/ --exclude=debug/ /var/spool/apt-mirror/mirror/centos/6/updates/i386/ > /dev/null
rsync -avrt rsync://mirrors.kernel.org/centos/6/os/i386/ --exclude=debug/ /var/spool/apt-mirror/mirror/centos/6/os/i386/ > /dev/null
rsync -avrt rsync://mirrors.kernel.org/centos/6/os/x86_64/ --exclude=debug/ /var/spool/apt-mirror/mirror/centos/6/os/x86_64/ > /dev/null
rsync -avrt rsync://mirrors.kernel.org/centos/6/centosplus/i386/ --exclude=debug/ /var/spool/apt-mirror/mirror/centos/6/centosplus/i386/ > /dev/null
rsync -avrt rsync://mirrors.kernel.org/centos/6/centosplus/x86_64/ --exclude=debug/ /var/spool/apt-mirror/mirror/centos/6/centosplus/x86_64/ > /dev/null
rsync -avrt rsync://mirrors.kernel.org/centos/6/xen4/ --exclude=debug/ /var/spool/apt-mirror/mirror/centos/6/xen4/ > /dev/null
rsync -avrt rsync://mirrors.kernel.org/centos/6/fasttrack/ --exclude=debug/ /var/spool/apt-mirror/mirror/centos/6/fasttrack/ > /dev/null
rsync -avrt rsync://mirrors.kernel.org/centos/6/extras/ --exclude=debug/ /var/spool/apt-mirror/mirror/centos/6/extras/ > /dev/null
rsync -avrt rsync://mirrors.kernel.org/centos/6/SCL/ --exclude=debug/ /var/spool/apt-mirror/mirror/centos/6/SCL/ > /dev/null

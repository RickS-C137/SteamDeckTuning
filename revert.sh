#!/bin/bash

systemctl disable cpu_performance.service
rm /etc/security/limits.d/memlock.conf
sed -i -e 's/,noatime//' /etc/fstab
sed -i -e 's/mitigations=off nowatchdog nmi_watchdog=0 //' /etc/default/grub
grub-mkconfig -o /boot/efi/EFI/steamos/grub.cfg
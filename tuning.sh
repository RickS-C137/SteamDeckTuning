#!/bin/bash

cat << EOF | tee /etc/systemd/system/cpu_performance.service
[Unit]
Description=CPU performance governor
[Service]
Type=oneshot
ExecStart=/usr/bin/cpupower frequency-set -g performance
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

systemctl enable cpu_performance.service

cat << EOF | tee /etc/security/limits.d/memlock.conf
* hard memlock 2147484
* soft memlock 2147484
EOF

sed -i -e '/home/s/\bdefaults\b/&,noatime/' /etc/fstab

sed -i 's/\bGRUB_CMDLINE_LINUX_DEFAULT="\b/&mitigations=off nowatchdog nmi_watchdog=0 /' /etc/default/grub

grub-mkconfig -o /boot/efi/EFI/steamos/grub.cfg
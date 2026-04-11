#!/bin/bash

cp ./vmhgfs.service  /etc/systemd/system/vmhgfs.service 

mkdir -p /mnt/hgfs

sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable --now vmhgfs.service
sudo systemctl enable --now keyd.service

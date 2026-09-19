#!/bin/bash
sudo mount.cifs -v //192.168.1.105/$1 ~/Downloads/$2 --verbose -o user=Administrator,password='123',gid=$(id -g),uid=$(id -u),dir_mode=0777,file_mode=0777,vers=1.0,cache=loose,acttimeo=60

---
description: >-
  Sequence of commands to get the remote desktop connection of  the super
  computer in biology park
---

# Remote desktop

## get the IP address

`hostname -I` # get the ip address to be used

## install the necessary tools

`sudo apt install net-tools`\
`sudo apt install openssh-client`\
`sudo apt install openssh-server`\
`sudo apt install curl`\
`sudo apt install xrdp -y`&#x20;

## Do the settings

`sudo systemctl enable ssh`\
`sudo ufw allow ssh`\
`sudo systemctl status xrdp` # check the status of remote desktop\
`sudo systemctl start xrdp`\
`sudo vim /etc/xrdp/xrdp.ini` # adjust the xrdp config, was not needed\
`curl ifconfig.me` # in the powershell on windows get the ip address\
`sudo ufw allow from [ip-address-from-previous-command]/32 to any port 3889` # from a public ip of windows machine, didtn work\
`sudo ufw status`\
`sudo ufw enable` # in case the status is not active\
`sudo ufw status numbered` # to check what is enabled so that it can be deleted with the number\
`sudo ufw delete 2` # example how to delete the rule number two\
`sudo ufw allow from [the-lan-ip-address-from-windows-settings]/24 to any port 3389` # testing from the local ip address\
`sudo ufw status`

